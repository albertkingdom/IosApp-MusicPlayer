//
//  Player.swift
//  containerTest
//
//  Created by 林煜凱 on 10/17/21.
//
import AVFoundation
import Foundation
import MediaPlayer

class MusicPlayer {
    static var shared = MusicPlayer() //singleton
    var currentIndex: Int?
    var player: AVPlayer?
    var playerItem: AVPlayerItem?
    private var songInfo: SongData?
    var songDuration: Float?
    var nowPlayingInfo: [String: Any] = [:]
    init() {
        
        player = AVPlayer(playerItem: playerItem)
        // notified when one song is ended
        NotificationCenter.default.addObserver(self, selector: #selector(onEndPlaySong), name: .AVPlayerItemDidPlayToEndTime, object: nil)
        setupMediaPlayerNotificatinView()
        // notified when music play or pause by user
        NotificationCenter.default.addObserver(self, selector: #selector(onPauseOrPlay), name: Notification.Name("musicPause"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onPauseOrPlay), name: Notification.Name("musicStart"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onPauseOrPlay), name: Notification.Name("musicSeek"), object: nil)
    }
    func play() {

        replacePlayerItem()
     
    }
    func startPlay() {
        player?.play()
    }
    func stopPlay() {
        player?.pause()
    }
    func setSongInfo(_ song: SongData) {
        songInfo = song
    }
    func getSongInfo() -> SongData?{
        return self.songInfo
    }
    func replacePlayerItem(){
    
        guard let url = songInfo?.songUrl else {
            return
        }
        
        playerItem = AVPlayerItem(url: url)
        player?.replaceCurrentItem(with: playerItem)
        
        guard let duration = playerItem?.asset.duration.seconds else { return }
        songDuration = Float(duration)
       
        startPlay()
        // reset notification music control info
        setupNotificationView()
    }
    @objc func onEndPlaySong() {
        print("song end")
       
        // 切換下首歌
        guard let currentIndex = currentIndex else {
            return
        }
  
        if currentIndex >= songs.count - 1 {
            songInfo = songs[0]
            self.currentIndex = 0
        } else {
            songInfo = songs[currentIndex + 1]
            self.currentIndex! += 1
        }
        replacePlayerItem()
    }
    // enable music remote control in notification
    func setupMediaPlayerNotificatinView() {
        let commandCenter = MPRemoteCommandCenter.shared()
        
        commandCenter.playCommand.addTarget { event in
            self.startPlay()
            NotificationCenter.default.post(name: Notification.Name("musicStart"), object: nil)
            return .success
        }
        commandCenter.pauseCommand.addTarget { event in
            self.stopPlay()
            NotificationCenter.default.post(name: Notification.Name("musicPause"), object: nil)
            return .success
        }
    }
    // set up notification music controller view
    func setupNotificationView() {
      
        guard let songInfo = songInfo else {
            return
        }
       
        nowPlayingInfo[MPMediaItemPropertyTitle] = songInfo.songTitle
        nowPlayingInfo[MPMediaItemPropertyArtist] = songInfo.singer
        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = songDuration
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = CMTimeGetSeconds((player?.currentTime())!)
        nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: songInfo.albumImage.size, requestHandler: { size in
            return songInfo.albumImage
        })
        
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
    // when play or pause in app, the notification music control have to react to the change
    @objc func onPauseOrPlay() {
       
        switch player?.timeControlStatus {
        case .paused:
            nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = CMTimeGetSeconds((player?.currentTime())!)
            nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = 0
           
            MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
        case .waitingToPlayAtSpecifiedRate, .playing:
            nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = CMTimeGetSeconds((player?.currentTime())!)
            nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = 1
         
            MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
      
        default: break
        }
    }
    /*
    func registerObserve(_ callback:@escaping ([String:Any])->Void) {
       player?.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1), queue: DispatchQueue.main) { [unowned self] time in
            if self.player?.currentItem?.status == .readyToPlay {
                let time : Float64 = CMTimeGetSeconds((self.player!.currentTime()));
                        //print("Current play time: \(time)")
                let status = self.player?.timeControlStatus.rawValue
                callback(["time": time, "timecontrolstatus":status])
               
                    }
           
                }
        player?.addObserver(self, forKeyPath: "timeControlStatus", options: [], context: nil)
    }
     */
//    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//        super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
//        if keyPath == "timeControlStatus", let player = object as? AVPlayer {
//            if player.timeControlStatus == .playing {
//                   //print("Playing")
//
//               } else {
//                   //print("Paused")
//
//               }
//           }
//    }
     

    
    
}
