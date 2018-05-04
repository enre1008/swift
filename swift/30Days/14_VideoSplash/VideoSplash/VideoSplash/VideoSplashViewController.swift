
import UIKit
import AVKit

public enum ScalingMode {
    case Resize
    case ResizeAspect
    case ResizeAspectFill
}

public class VideoSplashViewController: UIViewController {
    public let moviePlayer = AVPlayerViewController()
    public var moviePlayerSoundLevel: Float = 1.0
    public var startTime: CGFloat = 0.0
    public var duration: CGFloat = 0.0
    public var videoFrame: CGRect = CGRect()
    public var sound: Bool = true {
        didSet {
            if sound {
                moviePlayerSoundLevel = 1.0
            }else {
                moviePlayerSoundLevel = 0.0
            }
        }
    }
    public var alpha: CGFloat = CGFloat() {
        didSet {
            self.view.alpha = alpha
        }
    }
    public var backgroundColor: UIColor = UIColor.black {
        didSet {
            self.view.backgroundColor = backgroundColor
        }
    }
    public var contentURL: NSURL = NSURL() {
        didSet {
            setMoviePlayer(url: contentURL)
        }
    }
    public var alwaysRepeat: Bool = true {
        didSet {
            if alwaysRepeat {
                NotificationCenter.default.addObserver(self,
                                                       selector: #selector(VideoSplashViewController.moviePlayItemDidReachEnd),
                                                       name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                                       object: moviePlayer.player?.currentItem)
            }
        }
    }
    public var fillMode: ScalingMode = .ResizeAspectFill {
        didSet {
            switch fillMode {
            case .Resize:
                moviePlayer.videoGravity = AVLayerVideoGravity.resize.rawValue
            case .ResizeAspect:
                moviePlayer.videoGravity = AVLayerVideoGravity.resizeAspect.rawValue
            case .ResizeAspectFill:
                moviePlayer.videoGravity = AVLayerVideoGravity.resizeAspectFill.rawValue
            }
        }
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        moviePlayer.view.frame = videoFrame
        moviePlayer.showsPlaybackControls = false
        self.view.addSubview(moviePlayer.view)
        self.view.sendSubview(toBack: moviePlayer.view)
    }
    
    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    public func setMoviePlayer(url: NSURL) {
        let videoCutter = VideoCutter()
        videoCutter.cropVideoWithUrl(videoUrl: url, startTime: startTime, duration: duration) { (videoPath, error) -> Void in
            if let path = videoPath as NSURL? {
                self.moviePlayer.player = AVPlayer(url: path as URL)
                self.moviePlayer.player?.play()
                self.moviePlayer.player?.volume = self.moviePlayerSoundLevel
            }
            
        }
    }
    
    @objc public func moviePlayItemDidReachEnd() {
        moviePlayer.player?.seek(to: kCMTimeZero)
        moviePlayer.player?.play()
    }
    
}





