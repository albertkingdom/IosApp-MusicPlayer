//
//  ViewController.swift
//  containerTest
//
//  Created by 林煜凱 on 10/17/21.
//
import MediaPlayer
import UIKit

class MainViewController: UIViewController {
    var topVC: TopViewController!
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
        
        //setGradientColor()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
        case "miniPlayerVC":
            let miniPlayerVC = segue.destination as! MiniPlayerViewController
            self.miniPlayerVC = miniPlayerVC
        case "listVC":
            let listVC = segue.destination as! ListViewController
            self.listVC = listVC
        case "topVC":
            let topVC = segue.destination as! TopViewController
            self.topVC = topVC
        default: return
        }
    }
    func setGradientColor() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.brown.cgColor, UIColor.black.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        view.layer.insertSublayer(gradientLayer, at: 2)
    }
   

}

