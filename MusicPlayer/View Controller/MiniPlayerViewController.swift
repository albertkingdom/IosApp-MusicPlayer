//
//  MiniPlayerViewController.swift
//  containerTest
//
//  Created by 林煜凱 on 10/17/21.
//

import UIKit
import AVFoundation

class MiniPlayerViewController: UIViewController {
    var player: MusicPlayer?
    @IBOutlet var playerView: UIView!
    @IBOutlet weak var playerViewSongName: UILabel!
    @IBOutlet weak var playerViewAlbumImage: UIImageView!
    @IBOutlet weak var playerViewPlayButton: UIButton!
    
    @IBAction func tapPlayButton(_ sender: Any) {
       
        guard let player = player else {
            return
        }
        if player.player?.timeControlStatus == .playing {
            player.stopPlay()
            playerViewPlayButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        } else {
            //player.songInfo = songs.first
            player.startPlay()
            playerViewPlayButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
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
//        player?.observe(\.status, options: [.initial, .old, .new, .prior]) { object, change in
//            guard let status = change.newValue else { return }
//            print("notify status,\(status)")
//        }
        //player?.registerObserve()
        
        NotificationCenter.default.addObserver(self, selector: #selector(onNotifyMusicStart), name: Notification.Name("musicStart"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onNotifyMusicPause), name: Notification.Name("musicPause"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onEndPlaySong), name: .AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    @objc func onNotifyMusicStart() {
        print("music start")
        playerViewPlayButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        playerViewSongName.text = player?.getSongInfo()?.songTitle
        playerViewAlbumImage.image = player?.getSongInfo()?.albumImage
    }
    @objc func onNotifyMusicPause(){
        print("music paused")
        playerViewPlayButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
    }
    @objc func onEndPlaySong() {

        print("mini player song is end")
        configure()
    }
    func configureTapOnView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapPlayerView))
        playerView.addGestureRecognizer(tapGesture)
        playerView.isUserInteractionEnabled = true
    }
    func configure(){
        playerViewSongName.text = player?.getSongInfo()?.songTitle
        playerViewAlbumImage.image = player?.getSongInfo()?.albumImage
    }
}
