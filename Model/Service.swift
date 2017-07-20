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
    var musicList: Array<Song> {get}
}

class JsonFileSongService:MusicService {
    var musicList: Array<Song> = []
    var url: URL?
    var data: Data!
    
    func jsonSerialize() -> Array<Song> {
        url = Bundle.main.url(forResource: "Data", withExtension: "json")
        do {
            try data = Data(contentsOf: url!)
            let jsonОbj = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
            if let jsonObj = jsonОbj as? [String: Any] {
                if let rootArray = jsonObj["music"] as? [[String:Any]] {
                    for songJson in rootArray {
                        let song = Song(
                            name: songJson["name"] as? String ?? "",
                            url: songJson["url"] as? String ?? "",
                            genre: songJson["genre"] as? String ?? "",
                            album: songJson["album"] as? String,
                            author: songJson["author"] as? String
                        )
                        musicList.append(song)
                    }
                }
            }
        } catch  {
            print(error.localizedDescription)
        }
        return musicList
        
    }
    
}


