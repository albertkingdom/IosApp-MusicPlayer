//
//  MaxPlayerViewController.swift
//  containerTest
//
//  Created by 林煜凱 on 10/17/21.
//
import AVFoundation
import UIKit

class MaxPlayerViewController: UIViewController {
    
    //var player: MusicPlayer?
    var player =  MusicPlayer.shared
    var timeObserver: Any?
    
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var songLengthLabel: UILabel!
    @IBOutlet weak var songTitle: UILabel!
    @IBAction func tapPreButton(_ sender: Any) {
        
    }
    @IBAction func tapNextButton(_ sender: Any) {
    }
    @IBAction func changeSlider(_ sender: UISlider) {
        
        guard let duration = player.songDuration, let player = player.player else { return }
        let targetTime = duration * sender.value
        
        player.seek(to: CMTime(seconds: Double(targetTime), preferredTimescale: 1)) { isCompleted in
            NotificationCenter.default.post(name: Notification.Name("musicSeek"), object: nil)
        }
        
    }
    @IBAction func clickPlayButton(_ sender: Any) {
        guard let player = player.player else {
            return
        }
        
        switch player.timeControlStatus {
           
        case .playing:

            playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)

            self.player.stopPlay()
            NotificationCenter.default.post(name: Notification.Name("musicPause"), object: nil)
        case .paused, .waitingToPlayAtSpecifiedRate:

            playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)

 
            self.player.startPlay()
            NotificationCenter.default.post(name: Notification.Name("musicStart"), object: nil)
        default: return
        }
        
    }
    @IBAction func changeVolumeSlider(_ sender: UISlider) {
        guard let player = player.player else {
            return
        }
        player.volume = sender.value

    }
    override func viewDidLoad() {
 
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(onEndPlaySong), name: .AVPlayerItemDidPlayToEndTime, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onPauseOrPlay), name: Notification.Name("musicPause"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onPauseOrPlay), name: Notification.Name("musicStart"), object: nil)
        configure()
        
        
        guard let player = player.player else {
            return
        }
    
        timeObserver = player.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 20), queue: DispatchQueue.main) { [weak self] time in

            if player.currentItem?.status == .readyToPlay {
                let time : Float64 = CMTimeGetSeconds(player.currentTime());

                self?.configureSlider(time)
                self?.currentTimeLabel.text = self?.formatToTimeStr(timeInSec: Float(time))

            }
           
        }

    }
    override func viewWillLayoutSubviews() {
        setGradientColor()
    }
    func configureSlider(_ currentTime: Float64) {
        guard let duration = player.songDuration else { return }
        let percentage = Float(currentTime)/duration
        slider.setValue(Float(percentage), animated: true)
    }
    func configure() {
        // setup time label and slider value when observer is not set up
        let currentTime = player.player?.currentTime().seconds ?? 0
        configureSlider(Float64(currentTime))
        self.currentTimeLabel.text = self.formatToTimeStr(timeInSec: Float(currentTime))
        
        
        if let songInfo = player.getSongInfo(), let image = UIImage(named: songInfo.albumImage) {
        albumImage.image = image
        }
 
        songTitle.text = player.getSongInfo()?.songTitle
    
        //let songLengthStr = formatToTimeStr(timeInSec: player.currentItem?.duration.seconds)
        let songLengthStr = formatToTimeStr(timeInSec: player.songDuration)
        songLengthLabel.text = songLengthStr
        guard let player = player.player else { return }
        
        switch player.timeControlStatus {
        case .playing:
            playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        case .paused:
            playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        default: return
        }
    }
    @objc func onEndPlaySong() {

        configure()
    }
    @objc func onPauseOrPlay() {
        guard let player = player.player else {
            return
        }
        switch player.timeControlStatus {
        case .waitingToPlayAtSpecifiedRate, .playing:
           
            playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        case .paused:
            
            playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        default:
            break
        }
        
    }
    func formatToTimeStr(timeInSec: Float?) -> String {
        guard let timeInSec = timeInSec else {
            return "--:--"
        }
        let formater = DateComponentsFormatter()
        formater.allowedUnits = [.hour, .minute, .second]
        formater.zeroFormattingBehavior = .pad
        formater.unitsStyle = .positional
        return formater.string(from: Double(timeInSec)) ?? "--:--"
    }
    func setGradientColor() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        
        let blueOne = UIColor(red: 0/255, green: 71/255, blue: 171/255, alpha: 1)
        let blueTwo = UIColor(red: 0/255, green: 51/255, blue: 102/255, alpha: 1)
        gradientLayer.colors = [blueOne.cgColor, blueTwo.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
       
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    override func viewWillDisappear(_ animated: Bool) {

        // remove observer
        
        if let token = timeObserver {
            guard let player = player.player
            else {
                return
            }

            player.removeTimeObserver(token)
            timeObserver = nil
        }
        
    }
}
