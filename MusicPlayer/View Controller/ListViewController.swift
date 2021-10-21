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
        

    }
 
    

}

extension ListViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songInfoCell", for: indexPath)
        
        cell.textLabel?.text = songs[indexPath.row].songTitle
        cell.detailTextLabel?.text = songs[indexPath.row].singer
        cell.imageView?.image = songs[indexPath.row].albumImage
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

        
        // set songInfo

        player.setSongInfo(songs[indexPath.row]) 
        
        player.currentIndex = indexPath.row
        
        player.replacePlayerItem()
       

        NotificationCenter.default.post(name: Notification.Name("musicStart"), object: nil)
        
    }

}
