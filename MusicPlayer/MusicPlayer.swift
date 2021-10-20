//
//  Player.swift
//  containerTest
//
//  Created by 林煜凱 on 10/17/21.
//
import AVFoundation
import Foundation

class MusicPlayer {
    var currentIndex: Int?
    var player: AVPlayer?
    var playerItem: AVPlayerItem?
    private var songInfo: SongData?
    var songDuration: Float?
    init() {
        player = AVPlayer(playerItem: playerItem)
        // notified when one song is ended
        NotificationCenter.default.addObserver(self, selector: #selector(onEndPlaySong), name: .AVPlayerItemDidPlayToEndTime, object: nil)
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
        print("replace songduration, \(songDuration)")
        startPlay()
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
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "timeControlStatus", let player = object as? AVPlayer {
            if player.timeControlStatus == .playing {
                   //print("Playing")
                self.status = "playing"
               } else {
                   //print("Paused")
                   self.status = "paused"
               }
           }
    }
     */
    
    
    
}
