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
                    for songJson in rootArray {
                        let music = Music(
                            name: songJson["name"] as? String ?? "",
                            url: songJson["url"] as? String ?? "",
                            genre: songJson["genre"] as? String ?? "",
                            album: songJson["album"] as? String,
                            author: songJson["author"] as? String
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
