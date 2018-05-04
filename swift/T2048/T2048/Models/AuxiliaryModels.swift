//
//  AuxiliaryModels.swift
//  swift-2048
//
//  Created by Austin Zheng on 6/5/14.
//  Copyright (c) 2014 Austin Zheng. Released under the terms of the MIT license.
//

import Foundation

/// An enum representing directions supported by the game model.
enum MoveDirection {//表示滑动方向
  case up, down, left, right
}

/// An enum representing a movement command issued by the view controller as the result of the user swiping.
// AuxiliaryModels.swift -> MoveCommand
struct MoveCommand {
  let direction : MoveDirection
  let completion : (Bool) -> ()
}

/// An enum representing a 'move order'. This is a data structure the game model uses to inform the view controller
/// which tiles on the gameboard should be moved and/or combined.
//表示棋子终将如何移动。这个是修改游戏数据并调用委托通知view进行显示的依据
enum MoveOrder {
  case singleMoveOrder(source: Int, destination: Int, value: Int, wasMerge: Bool)
  case doubleMoveOrder(firstSource: Int, secondSource: Int, destination: Int, value: Int)
}

/// An enum representing either an empty space or a tile upon the board.
enum TileObject {//表示棋子
  case empty
  case tile(Int)
}

/// An enum representing an intermediate result used by the game logic when figuring out how the board should change as
/// the result of a move. ActionTokens are transformed into MoveOrders before being sent to the delegate.
//ActionToken表示了逻辑计算中一个棋子，是从何处移动或合并过来的
//负责定义model处理过程中所需的数据结构
enum ActionToken {
  case noAction(source: Int, value: Int)
  case move(source: Int, value: Int)
  case singleCombine(source: Int, value: Int)
  case doubleCombine(source: Int, second: Int, value: Int)

  // Get the 'value', regardless of the specific type
  func getValue() -> Int {
    switch self {
    case let .noAction(_, v): return v
    case let .move(_, v): return v
    case let .singleCombine(_, v): return v
    case let .doubleCombine(_, _, v): return v
    }
  }
  // Get the 'source', regardless of the specific type
  func getSource() -> Int {
    switch self {
    case let .noAction(s, _): return s
    case let .move(s, _): return s
    case let .singleCombine(s, _): return s
    case let .doubleCombine(s, _, _): return s
    }
  }
}

/// A struct representing a square gameboard. Because this struct uses generics, it could conceivably be used to
/// represent state for many other games without modification.
struct SquareGameboard<T> {//表示游戏盘
  let dimension : Int//纬度
  var boardArray : [T]//泛型数组，表示游戏盘上的每个棋子（包括空棋子）
                      //使用了泛型，使得游戏盘这个结构更通用，不受棋子类型的限制

  init(dimension d: Int, initialValue: T) {//初始化
    dimension = d
    boardArray = [T](repeating: initialValue, count: d*d)
  }

  //使用下标函数，从而达到了，内部使用一维数组存储，外部按行列坐标这种2维形式访问
  subscript(row: Int, col: Int) -> T {//下标函数
    get {
      assert(row >= 0 && row < dimension)
      assert(col >= 0 && col < dimension)
      return boardArray[row*dimension + col]
    }
    set {
      assert(row >= 0 && row < dimension)
      assert(col >= 0 && col < dimension)
      boardArray[row*dimension + col] = newValue//根据行列坐标位置，找到数组中的棋子
    }
  }

  // We mark this function as 'mutating' since it changes its 'parent' struct.
  mutating func setAll(to item: T) {
    for i in 0..<dimension {
      for j in 0..<dimension {
        self[i, j] = item
      }
    }
  }
}
