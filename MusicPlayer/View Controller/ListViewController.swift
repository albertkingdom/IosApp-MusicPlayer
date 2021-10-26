//
//  ListViewController.swift
//  containerTest
//
//  Created by 林煜凱 on 10/17/21.
//

import UIKit
import AVFoundation

class ListViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    //var player: MusicPlayer?
    var player =  MusicPlayer.shared
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 50, leading: 0, bottom: 5, trailing: 0)

    }
 
    

}

extension ListViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songInfoCell", for: indexPath) as! ListTableViewCell
        
        //cell.textLabel?.text = songs[indexPath.row].songTitle
        //cell.detailTextLabel?.text = songs[indexPath.row].singer
        //cell.imageView?.image = songs[indexPath.row].albumImage
        //cell.imageView?.layer.cornerRadius = 5
        //cell.imageView?.layer.masksToBounds = true
        cell.setData(with: songs[indexPath.row])
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

        
        // set songInfo

        player.setSongInfo(songs[indexPath.row]) 
        
        player.currentIndex = indexPath.row
        
        player.replacePlayerItem()
        player.startPlay()

        NotificationCenter.default.post(name: Notification.Name("musicStart"), object: nil)
        player.userActivityHistory.currentSong = songs[indexPath.row]
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

}
