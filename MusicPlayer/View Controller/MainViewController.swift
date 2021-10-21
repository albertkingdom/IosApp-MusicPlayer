//
//  ViewController.swift
//  containerTest
//
//  Created by 林煜凱 on 10/17/21.
//
import MediaPlayer
import UIKit

class MainViewController: UIViewController {
    var miniPlayerVC: MiniPlayerViewController!
    var listVC: ListViewController!
    //var player: MusicPlayer?
    var player =  MusicPlayer.shared
    override func viewDidLoad() {
        super.viewDidLoad()
       
        guard let miniPlayerVC = miniPlayerVC else { return }
        miniPlayerVC.player = self.player
        
        guard let listVC = listVC else { return }
        listVC.player = self.player
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
        case "miniPlayerVC":
            let miniPlayerVC = segue.destination as! MiniPlayerViewController
            self.miniPlayerVC = miniPlayerVC
        case "listVC":
            let listVC = segue.destination as! ListViewController
            self.listVC = listVC
        default: return
        }
    }
    
   

}

