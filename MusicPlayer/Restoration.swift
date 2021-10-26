//
//  Restoration.swift
//  MusicPlayer
//
//  Created by 林煜凱 on 10/25/21.
//

import Foundation

extension NSUserActivity {
    
    var currentSong: SongData? {
        get {
            guard let jsonData = userInfo?["currentSong"] as? Data else {
                return nil
            }
            
            return try? JSONDecoder().decode(SongData.self, from: jsonData)
        }
        
        set {
            if let newValue = newValue, let jsonData = try? JSONEncoder().encode(newValue) {
                addUserInfoEntries(from: ["currentSong": jsonData])
            } else {
                userInfo?["currentSong"] = nil
            }
            
        }
    }
}
