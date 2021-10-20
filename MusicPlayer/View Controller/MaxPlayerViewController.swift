//
//  MaxPlayerViewController.swift
//  containerTest
//
//  Created by 林煜凱 on 10/17/21.
//
import AVFoundation
import UIKit

class MaxPlayerViewController: UIViewController {
    
    var player: MusicPlayer?
    var timeObserver: Any?
    
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var songLengthLabel: UILabel!
    @IBAction func tapPreButton(_ sender: Any) {
        
    }
    @IBAction func tapNextButton(_ sender: Any) {
    }
    @IBAction func changeSlider(_ sender: UISlider) {
        
        guard let duration = player?.songDuration, let player = player?.player else { return }
        let targetTime = duration * sender.value
        
        player.seek(to: CMTime(seconds: Double(targetTime), preferredTimescale: 1))
        
    }
    @IBAction func clickPlayButton(_ sender: Any) {
        guard let player = player?.player else {
            return
        }

        switch player.timeControlStatus {
        case .playing:
            playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            player.pause()
            NotificationCenter.default.post(name: Notification.Name("musicPause"), object: nil)
        case .paused:
            playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            player.play()
            NotificationCenter.default.post(name: Notification.Name("musicStart"), object: nil)
        default: return
        }
        
    }
    @IBAction func changeVolumeSlider(_ sender: UISlider) {
        guard let player = player?.player else {
            return
        }
        player.volume = sender.value

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(onEndPlaySong), name: .AVPlayerItemDidPlayToEndTime, object: nil)
        configure()
        guard let player = player?.player else {
            return
        }
    
        timeObserver = player.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1), queue: DispatchQueue.main) { [unowned self] time in
            if player.currentItem?.status == .readyToPlay {
                let time : Float64 = CMTimeGetSeconds(player.currentTime());
                    print("Current play time: \(time)")
                    configureSlider(time)
                currentTimeLabel.text = formatToTimeStr(timeInSec: Float(time))

            }
           
        }

    }
    
    func configureSlider(_ currentTime: Float64) {
        guard let duration = player?.songDuration else { return }
        let percentage = Float(currentTime)/duration
        slider.setValue(Float(percentage), animated: true)
    }
    func configure() {
        albumImage.image = player?.getSongInfo()?.albumImage
        playButton.tintColor = UIColor.black

        print("歌曲時長\(player?.songDuration)")
        //let songLengthStr = formatToTimeStr(timeInSec: player.currentItem?.duration.seconds)
        let songLengthStr = formatToTimeStr(timeInSec: player?.songDuration)
        songLengthLabel.text = songLengthStr
                guard let player = player?.player else {
                    return
                }
        
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
    override func viewWillDisappear(_ animated: Bool) {
       
        // remove observer
        
        if let token = timeObserver {
            guard let player = player?.player
            else {
                return
            }

            player.removeTimeObserver(token)
            timeObserver = nil
        }
        
    }
}
