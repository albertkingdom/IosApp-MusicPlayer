//
//  SongData.swift
//  containerTest
//
//  Created by 林煜凱 on 10/17/21.
//

import Foundation
import UIKit

struct SongData {
    var songTitle: String
    var singer: String
    var albumImage: UIImage!
    var songUrl: URL
}
let songs:[SongData] = [
    SongData(songTitle: "HAVE A NICE DAY", singer: "魏如萱", albumImage: UIImage(named: "魏如萱.jpg"),songUrl: Bundle.main.url(forResource: "haveANiceDay", withExtension: "mp3", subdirectory: "Music")!),
    SongData(songTitle: "ON THE GROUND", singer: "ROSÉ", albumImage: UIImage(named: "ROSÉ.jpg"),songUrl: Bundle.main.url(forResource: "onTheGround", withExtension: "mp3", subdirectory: "Music")!),
    SongData(songTitle: "BEAUTIFUL MISTAKES", singer: "Maroon 5, Megan Thee Stallion", albumImage: UIImage(named: "Maroon5,MeganTheeStallion.jpg"),songUrl: Bundle.main.url(forResource: "beautiful-mistakes", withExtension: "mp3", subdirectory: "Music")!),
    SongData(songTitle: "愛我的時候", singer: "周興哲", albumImage: UIImage(named: "周興哲.jpg"),songUrl: Bundle.main.url(forResource: "愛我的時候", withExtension: "mp3", subdirectory: "Music")!),
    SongData(songTitle: "甘蔗掰掰", singer: "艾薇", albumImage: UIImage(named: "艾薇.jpg"),songUrl: Bundle.main.url(forResource: "甘蔗掰掰", withExtension: "mp3", subdirectory: "Music")!)

]
