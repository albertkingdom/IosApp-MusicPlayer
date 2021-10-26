//
//  MiniPlayerViewController.swift
//  containerTest
//
//  Created by 林煜凱 on 10/17/21.
//

import UIKit
import AVFoundation

class MiniPlayerViewController: UIViewController {
    //var player: MusicPlayer?
    var player =  MusicPlayer.shared
    @IBOutlet var playerViewContainer: UIView!
    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var playerViewSongName: UILabel!
    @IBOutlet weak var playerViewAlbumImage: UIImageView!
    @IBOutlet weak var playerViewPlayButton: UIButton!
    
    @IBAction func tapPlayButton(_ sender: Any) {
        guard let songInfo = player.getSongInfo() else { return }

        switch player.player?.timeControlStatus {
        case .playing:
           
            playerViewPlayButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            player.stopPlay()
            NotificationCenter.default.post(name: Notification.Name("musicPause"), object: nil)
        case .paused:
           
            playerViewPlayButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)

            player.startPlay()
            NotificationCenter.default.post(name: Notification.Name("musicStart"), object: nil)
        default: return
        }
    }
    @objc func onTapPlayerView() {
        let playerVC = storyboard?.instantiateViewController(withIdentifier: "playerVC") as! MaxPlayerViewController

        playerVC.player = self.player
        present(playerVC, animated: true, completion: nil)
       
        
        

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTapOnView()
        playerView.layer.cornerRadius = 10
        
        NotificationCenter.default.addObserver(self, selector: #selector(onPauseOrPlay), name: Notification.Name("musicStart"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onPauseOrPlay), name: Notification.Name("musicPause"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onEndPlaySong), name: .AVPlayerItemDidPlayToEndTime, object: nil)
        
        // if a song is played before app close, load info when app start again
        if let songInfo = player.getSongInfo() {
            configure()
        }
    }
    
    @objc func onPauseOrPlay() {
//        guard let player = player else {
//            return
//        }
        switch player.player?.timeControlStatus {
        case .waitingToPlayAtSpecifiedRate, .playing:
            guard let songInfo = player.getSongInfo() else { return }
            playerViewPlayButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            playerViewSongName.text = player.getSongInfo()?.songTitle
            if let image = UIImage(named: player.getSongInfo()!.albumImage) {
                playerViewAlbumImage.image = image
            }
//            playerViewAlbumImage.image = player.getSongInfo()?.albumImage
        case .paused:
           
            playerViewPlayButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        default:
            break
        }
        
    }
    @objc func onEndPlaySong() {

        print("mini player song is end")
        configure()
    }
    func configureTapOnView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapPlayerView))
        playerViewContainer.addGestureRecognizer(tapGesture)
        playerViewContainer.isUserInteractionEnabled = true
    }
    func configure(){
        playerViewSongName.text = player.getSongInfo()?.songTitle
        if let image = UIImage(named: player.getSongInfo()!.albumImage) {
            playerViewAlbumImage.image = image
        }
        //playerViewAlbumImage.image = player.getSongInfo()?.albumImage
    }
}
