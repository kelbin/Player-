//
//  Service.swift
//  Player
//
//  Created by Келбин on 12.07.17.
//  Copyright © 2017 Келбин. All rights reserved.
//

import Foundation
import UIKit

protocol MusicService {
    var musicList: Array<Music> {get}
    func jsonSerialize() -> Array<Music>
}

class JsonFileSongService: MusicService {
    var musicList: Array<Music> = []
    var url: URL?
    var data: Data!
    
    func jsonSerialize() -> Array<Music> {
        url = Bundle.main.url(forResource: "Data", withExtension: "json")
        do {
            try data = Data(contentsOf: url!)
            let jsonObj = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
            if let jsonObj = jsonObj as? [String: Any] {
                if let rootArray = jsonObj["music"] as? [[String:Any]] {
                    for musicJson in rootArray {
                        let music = Music(
                            name: musicJson["name"] as? String ?? "",
                            url: musicJson["url"] as? String ?? "",
                            genre: musicJson["genre"] as? String ?? "",
                            album: musicJson["album"] as? String,
                            author: musicJson["author"] as? String
                        )
                        musicList.append(music)
                    }
                }
            }
        } catch  {
            print(error.localizedDescription)
        }
        return musicList
    }
}
