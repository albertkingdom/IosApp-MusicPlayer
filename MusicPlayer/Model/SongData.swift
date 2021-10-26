//
//  SongData.swift
//  containerTest
//
//  Created by 林煜凱 on 10/17/21.
//

import Foundation
import UIKit

struct SongData: Codable {
    var songTitle: String
    var singer: String
    var albumImage: String
    var fileName: String
}

let songs:[SongData] = [
    SongData(songTitle: "HAVE A NICE DAY", singer: "魏如萱", albumImage:  "魏如萱", fileName: "haveANiceDay"),
    SongData(songTitle: "ON THE GROUND", singer: "ROSÉ", albumImage:  "ROSÉ", fileName: "onTheGround"),
    SongData(songTitle: "BEAUTIFUL MISTAKES", singer: "Maroon 5, Megan Thee Stallion", albumImage: "Maroon5,MeganTheeStallion", fileName: "beautiful-mistakes"),
    SongData(songTitle: "愛我的時候", singer: "周興哲", albumImage:  "周興哲", fileName: "愛我的時候"),
    SongData(songTitle: "甘蔗掰掰", singer: "艾薇", albumImage:  "艾薇", fileName: "甘蔗掰掰")

]
