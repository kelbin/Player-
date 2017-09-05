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
    var musicList: [Music] { get }
}

class JsonFileMusicService: MusicService {
    var musicList: [Music] = []
    
    init() {
        musicList = jsonSerialize()
    }
    
    func jsonSerialize() -> [Music] {
       let data: Data
       let url = Bundle.main.url(forResource: "Data", withExtension: "json")
        
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
                            album: musicJson["album"] as? String ?? "",
                            author: musicJson["author"] as? String ?? "",
                            picture: musicJson["picture"] as? String ?? ""
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
