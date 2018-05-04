//
//  GameModel.swift
//  swift-2048
//
//  Created by Austin Zheng on 6/3/14.
//  Copyright (c) 2014 Austin Zheng. Released under the terms of the MIT license.
//
//负责定义委托协议，以及包含所有游戏逻辑的GameModel处理类

import UIKit

/// A protocol that establishes a way for the game model to communicate with its parent view controller.
protocol GameModelProtocol : class {
    func scoreChanged(to score: Int)
    func moveOneTile(from: (Int, Int), to: (Int, Int), value: Int)
    func moveTwoTiles(from: ((Int, Int), (Int, Int)), to: (Int, Int), value: Int)
    func insertTile(at location: (Int, Int), withValue value: Int)
}

/// A class representing the game state and game logic for swift-2048. It is owned by a NumberTileGame view controller.
class GameModel : NSObject {
    let dimension : Int
    let threshold : Int
    
    var score : Int = 0 {
        didSet {
            delegate.scoreChanged(to: score)
        }
    }
    var gameboard: SquareGameboard<TileObject>//该属性表示游戏盘（Gameboard）和盘上的棋子（tile）
                                              //SquareGameboard和TileObject就是定义在AuxiliaryModles.swift中的数据结构
    
    unowned let delegate : GameModelProtocol
    
    var queue: [MoveCommand]//MoveCommand队列
    var timer: Timer//计时器
    
    let maxCommands = 100
    let queueDelay = 0.3
    
    init(dimension d: Int, threshold t: Int, delegate: GameModelProtocol) {
        dimension = d
        threshold = t
        self.delegate = delegate
        queue = [MoveCommand]()
        timer = Timer()
        gameboard = SquareGameboard(dimension: d, initialValue: .empty)
        super.init()
    }
    
    /// Reset the game state.
    func reset() {
        score = 0
        gameboard.setAll(to: .empty)
        queue.removeAll(keepingCapacity: true)
        timer.invalidate()
    }
    
    /// Order the game model to perform a move (because the user swiped their finger). The queue enforces a delay of a few
    /// milliseconds between each move.
    //从NumberTileGame.swift -> 滑动手势处理函数，如dwonCommand()中调用 m.queuMove(MoveDirection.down, completion)，这样来到了该方法
    //queueMove方法够简单，就做了2件事情
    //1.参数生成MoveCommand，放到队列，等待处理
    //2.调用timerFired(timer)计时器执行
    func queueMove(direction: MoveDirection, onCompletion: @escaping (Bool) -> ()) {
        guard queue.count <= maxCommands else {
            // Queue is wedged. This should actually never happen in practice.
            return
        }
        queue.append(MoveCommand(direction: direction, completion: onCompletion)) //参数整合成MoveCommand对象，放入队列
        if !timer.isValid {  //计时器未启动，则启动
            // Timer isn't running, so fire the event immediately
            timerFired(timer)
        }
    }
    
    //------------------------------------------------------------------------------------------------------------------//
    
    /// Inform the game model that the move delay timer fired. Once the timer fires, the game model tries to execute a
    /// single move that changes the game state.
    //循环queue，取出最先的MoveCommand
    //执行performMove，并执行完成函数
    //如果结果游戏盘有变化，则跳出循环，一定时间间隔后再执行timerFired
    //如果没有变化，则循环继续，处理下一个MoveCommand
    //理解上要拐个弯：timerFired中的while循环，仅仅为了处理相同的动作（过滤掉相同的动作），而真正对queue的循环处理，其实Timer来完成的
    @objc func timerFired(_: Timer) {//利用timer循环处理外界传入的用户手势动作
        if queue.count == 0 {
            return
        }
        // Go through the queue until a valid command is run or the queue is empty
        var changed = false
        while queue.count > 0 {  //循环队列
            let command = queue[0]  //得到队列的第一个
            queue.remove(at: 0)  //删除队列的第一个
            changed = performMove(direction: command.direction)
                //将performMove方法执行结果赋值给changed
            command.completion(changed)
            //将得到的changed的值当作参数传给command.completion，即在这里无名闭包才得到参数，才被调用了
        //在queueMove方法中，@escaping就是指逃逸闭包，即queueMove方法执行完成后再执行该闭包
        //在queueMove方法中，queue.append(MoveCommand(direction: direction, completion: onCompletion)),即将onCompletion闭包传给了queue
        //在timerFired方法中，command=queue[0]的方式，再将onCompletion传给了赋值给了command
            if changed {  //如果没有变化，进行到下一个（没有变化，不break）
                // If the command doesn't change anything, we immediately run the next one
                break
            }
        }
        if changed {//如果发生了变化，将timer在一定间隔之后，再次执行中执行本方法
            timer = Timer.scheduledTimer(timeInterval: queueDelay,
                                         target: self,
                                         selector:
                #selector(GameModel.timerFired(_:)),
                                         userInfo: nil,
                                         repeats: false)
        }
    }
    
    //------------------------------------------------------------------------------------------------------------------//
    
    /// Insert a tile with a given value at a position upon the gameboard.
    func insertTile(at location: (Int, Int), value: Int) {
        let (x, y) = location
        if case .empty = gameboard[x, y] {
            gameboard[x, y] = TileObject.tile(value)
            delegate.insertTile(at: location, withValue: value)
        }
    }
    
    /// Insert a tile with a given value at a random open position upon the gameboard.
    func insertTileAtRandomLocation(withValue value: Int) {
        let openSpots = gameboardEmptySpots()
        if openSpots.isEmpty {
            // No more open spots; don't even bother
            return
        }
        // Randomly select an open spot, and put a new tile there
        let idx = Int(arc4random_uniform(UInt32(openSpots.count-1)))
        let (x, y) = openSpots[idx]
        insertTile(at: (x, y), value: value)
    }
    
    /// Return a list of tuples describing the coordinates of empty spots remaining on the gameboard.
    func gameboardEmptySpots() -> [(Int, Int)] {
        var buffer : [(Int, Int)] = []
        for i in 0..<dimension {
            for j in 0..<dimension {
                if case .empty = gameboard[i, j] {
                    buffer += [(i, j)]
                }
            }
        }
        return buffer
    }
    
    //------------------------------------------------------------------------------------------------------------------//
    
    func tileBelowHasSameValue(location: (Int, Int), value: Int) -> Bool {
        let (x, y) = location
        guard y != dimension - 1 else {
            return false
        }
        if case let .tile(v) = gameboard[x, y+1] {
            return v == value
        }
        return false
    }
    
    func tileToRightHasSameValue(location: (Int, Int), value: Int) -> Bool {
        let (x, y) = location
        guard x != dimension - 1 else {
            return false
        }
        if case let .tile(v) = gameboard[x+1, y] {
            return v == value
        }
        return false
    }
    
    func userHasLost() -> Bool {
        guard gameboardEmptySpots().isEmpty else {
            // Player can't lose before filling up the board
            return false
        }
        
        // Run through all the tiles and check for possible moves
        for i in 0..<dimension {
            for j in 0..<dimension {
                switch gameboard[i, j] {
                case .empty:
                    assert(false, "Gameboard reported itself as full, but we still found an empty tile. This is a logic error.")
                case let .tile(v):
                    if tileBelowHasSameValue(location: (i, j), value: v) ||
                        tileToRightHasSameValue(location: (i, j), value: v)
                    {
                        return false
                    }
                }
            }
        }
        return true
    }
    
    func userHasWon() -> (Bool, (Int, Int)?) {
        for i in 0..<dimension {
            for j in 0..<dimension {
                // Look for a tile with the winning score or greater
                if case let .tile(v) = gameboard[i, j], v >= threshold {
                    return (true, (i, j))
                }
            }
        }
        return (false, nil)
    }
    
    //------------------------------------------------------------------------------------------------------------------//
    
    // Perform all calculations and update state for a single move.
    //从timerFired()函数中 changed = performMove(direction: command.direction) 语句调用performMove函数，再将结果change当作参数传给下面一行代码
    //                   command.completion(changed)//**再当作参数传进去，注：完成无名闭包是在这里调用**
    //将棋盘按方向，拆分为与方向无关的棋子数组
    //1. 得到一行或一列 移动的顺序坐标
    //2. 用坐标找到棋子数组tiles
    //3. merge(tiles)方法得到MoveOrder数组
    //4. 根据MoveOrder数组循环处理，更新棋盘数据、调用委托，通知controller
    func performMove(direction: MoveDirection) -> Bool {
        //一个局部闭包。用来返回在移动方向上 一行或一列 棋子的坐标顺序
        //顺序是移动方向上格子移动的顺序
        //另外3个方向滑动，其实只要旋转角度，都可以转化成向下滑动手势。这个旋转动作，主要就是交给这个内部闭包来完成的
        let coordinateGenerator: (Int) -> [(Int, Int)] = { (iteration: Int) -> [(Int, Int)] in
            var buffer = Array<(Int, Int)>(repeating: (0, 0), count: self.dimension)
            for i in 0..<self.dimension {
                switch direction {
                case .up: buffer[i] = (i, iteration)
                case .down: buffer[i] = (self.dimension - i - 1, iteration)
                case .left: buffer[i] = (iteration, i)
                case .right: buffer[i] = (iteration, self.dimension - i - 1)
                }
            }
            return buffer
        }
        
        var atLeastOneMove = false
        for i in 0..<dimension {
            // Get the list of coords
            let coords = coordinateGenerator(i) //得到一行或一列 移动的顺序坐标
            
            // Get the corresponding list of tiles
            let tiles = coords.map() { (c: (Int, Int)) -> TileObject in
                let (x, y) = c
                return self.gameboard[x, y]
            }//用前面的坐标找到对应的tileObject，放到数组tiles
            
            // Perform the operation
            let orders = merge(tiles) //处理棋子的合并，返回了MoveOrder数组
            atLeastOneMove = orders.count > 0 ? true : atLeastOneMove
            
            // Write back the results
            for object in orders {
                switch object {
                case let MoveOrder.singleMoveOrder(s, d, v, wasMerge): //单棋子移动
                    // Perform a single-tile move
                    let (sx, sy) = coords[s] //疑问，怎么会这样定位到原来棋子的位置呢？？
                    let (dx, dy) = coords[d]
                    if wasMerge {
                        score += v
                    }
                    gameboard[sx, sy] = TileObject.empty  //原来的设为空
                    gameboard[dx, dy] = TileObject.tile(v) //新的设为值
                      //上面两行就是修改游戏盘中的数据
                    delegate.moveOneTile(from: coords[s], to: coords[d], value: v)  //调用委托
                case let MoveOrder.doubleMoveOrder(s1, s2, d, v):  //2个棋子移动
                    // Perform a simultaneous two-tile move
                    let (s1x, s1y) = coords[s1]
                    let (s2x, s2y) = coords[s2]
                    let (dx, dy) = coords[d]
                    score += v
                    gameboard[s1x, s1y] = TileObject.empty
                    gameboard[s2x, s2y] = TileObject.empty
                    gameboard[dx, dy] = TileObject.tile(v)
                    delegate.moveTwoTiles(from: (coords[s1], coords[s2]), to: coords[d], value: v)
                }
            }
        }
        return atLeastOneMove
    }
    
    //------------------------------------------------------------------------------------------------------------------//
    
    /// When computing the effects of a move upon a row of tiles, calculate and return a list of ActionTokens
    /// corresponding to any moves necessary to remove interstital space. For example, |[2][ ][ ][4]| will become
    /// |[2][4]|.
    //对一列的棋子，进行移动集中，每个非空棋子移动的结果以ActionToken信息表示，存放在一个新数组中，即存放在tokenBuffer中
    //新数组的索引index，就是棋子在这列中的当前（新）位置
    func condense(_ group: [TileObject]) -> [ActionToken] {
        var tokenBuffer = [ActionToken]()//数组
        for (idx, tile) in group.enumerated() {
            // Go through all the tiles in 'group'. When we see a tile 'out of place', create a corresponding ActionToken.
            switch tile {
            case let .tile(value) where tokenBuffer.count == idx://表示不用动
                tokenBuffer.append(ActionToken.noAction(source: idx, value: value))
            case let .tile(value):
                tokenBuffer.append(ActionToken.move(source: idx, value: value))//表示移动
            default:
                break
            }
        }//显然，toukenBuffer中的index就是现在新的位置
        return tokenBuffer;
    }
    //tokenBuffer[0]=move(source:1, value:2)，返回结果类似像这些
    //tokenBuffer[1]=move(source:3, value:2)，或
    //tokenBuffer[0]=NoAction(source:0, value:2)，或
    
    class func quiescentTileStillQuiescent(inputPosition: Int, outputLength: Int, originalPosition: Int) -> Bool {
        // Return whether or not a 'NoAction' token still represents an unmoved tile
        //静止的棋子仍然静止
        return (inputPosition == outputLength) && (originalPosition == inputPosition)
    }
    
    /// When computing the effects of a move upon a row of tiles, calculate and return an updated list of ActionTokens
    /// corresponding to any merges that should take place. This method collapses adjacent tiles of equal value, but each
    /// tile can take part in at most one collapse per move. For example, |[1][1][1][2][2]| will become |[2][1][4]|.
    //合并
    func collapse(_ group: [ActionToken]) -> [ActionToken] {
        
        
        var tokenBuffer = [ActionToken]()
        var skipNext = false
        for (idx, token) in group.enumerated() {
            if skipNext {
                // Prior iteration handled a merge. So skip this iteration.
                skipNext = false
                continue
            }//因为只能两个格子合并，所以处理上一个棋子发生合并，则当前棋子已经处理过了，跳过
            switch token {
            case .singleCombine:
                assert(false, "Cannot have single combine token in input")
            case .doubleCombine:
                assert(false, "Cannot have double combine token in input")
            case let .noAction(s, v)
                where (idx < group.count-1
                    && v == group[idx+1].getValue()
                    && GameModel.quiescentTileStillQuiescent(inputPosition: idx, outputLength: tokenBuffer.count, originalPosition: s)):
                // This tile hasn't moved yet, but matches the next tile. This is a single merge
                // The last tile is *not* eligible for a merge
                let next = group[idx+1]
                let nv = v + group[idx+1].getValue()
                skipNext = true
                tokenBuffer.append(ActionToken.singleCombine(source: next.getSource(), value: nv))
                //如果当前的NoAction的格子，这里合并，就是SingleCombine。只记录后面的source
            case let t where (idx < group.count-1 && t.getValue() == group[idx+1].getValue()):
                // This tile has moved, and matches the next tile. This is a double merge
                // (The tile may either have moved prevously, or the tile might have moved as a result of a previous merge)
                // The last tile is *not* eligible for a merge
                let next = group[idx+1]
                let nv = t.getValue() + group[idx+1].getValue()
                skipNext = true
                tokenBuffer.append(ActionToken.doubleCombine(source: t.getSource(), second: next.getSource(), value: nv))
                //如果第一个不是NoAction，则是DoubleCombine，是要记录开始和后面
            case let .noAction(s, v) where !GameModel.quiescentTileStillQuiescent(inputPosition: idx, outputLength: tokenBuffer.count, originalPosition: s):
                // A tile that didn't move before has moved (first cond.), or there was a previous merge (second cond.)
                //如果当前是NoAction，但是前面已经有合并，中间空出来，则将变成Move
                tokenBuffer.append(ActionToken.move(source: s, value: v))
            case let .noAction(s, v):
                // A tile that didn't move before still hasn't moved
                tokenBuffer.append(ActionToken.noAction(source: s, value: v))
                //除了上一种情况，NoAction还是NoAction
            case let .move(s, v):
                // Propagate a move
                tokenBuffer.append(ActionToken.move(source: s, value: v))
                //move还是move
            default:
                // Don't do anything
                break
            }
        }
        return tokenBuffer
    }
    
    /// When computing the effects of a move upon a row of tiles, take a list of ActionTokens prepared by the condense()
    /// and convert() methods and convert them into MoveOrders that can be fed back to the delegate.
    //转化,主要将ActionToken变成 MoveOrder
    //
    func convert(_ group: [ActionToken]) -> [MoveOrder] {
        var moveBuffer = [MoveOrder]()
        for (idx, t) in group.enumerated() {
            switch t {
            case let .move(s, v)://移动单个格子
                moveBuffer.append(MoveOrder.singleMoveOrder(source: s, destination: idx, value: v, wasMerge: false))
            case let .singleCombine(s, v)://合并，但只是移动了后面的那个棋子，与前面棋子没有移动（算只移动了一个棋子）
                moveBuffer.append(MoveOrder.singleMoveOrder(source: s, destination: idx, value: v, wasMerge: true))
            case let .doubleCombine(s1, s2, v)://合并，是2个格子移动并合成了一个新的棋子
                moveBuffer.append(MoveOrder.doubleMoveOrder(firstSource: s1, secondSource: s2, destination: idx, value: v))
            default:
                // Don't do anything
                break
            }
        }
        return moveBuffer
    }
    
    /// Given an array of TileObjects, perform a collapse and create an array of move orders.
    //虽然只有1句代码，但是3个函数嵌套调用，说明了合并过程被拆分为3个步骤
    //1. condense，移动，即意思是集中
    //2. collapse，合并
    //3. convert，转化成MoveOrder
    func merge(_ group: [TileObject]) -> [MoveOrder] {
        // Calculation takes place in three steps:
        // 1. Calculate the moves necessary to produce the same tiles, but without any interstital space.
        // 2. Take the above, and calculate the moves necessary to collapse adjacent tiles of equal value.
        // 3. Take the above, and convert into MoveOrders that provide all necessary information to the delegate.
        return convert(collapse(condense(group)))
    }
}
