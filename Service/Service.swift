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
}

class JsonFileMusicService: NSObject, MusicService, NSCoding {
    var musicList: Array<Music> = []
    override init() {
        super.init()
        self.musicList = self.jsonSerialize()
    }
    
    func jsonSerialize() -> Array<Music> {
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
                            author: musicJson["author"] as? String ?? ""
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
    
    required init?(coder aDecoder: NSCoder) {
        
    }
    
    func encode(with aCoder: NSCoder) {
        
    }
}
/*
class MusicArchive: NSObject, NSCoding{
    var musicStruct: Music = Music(name: "", url: "", genre: "", album: "", author: "")
    var _name: String = ""
    
    
    init(name: String) {
        self._name = name
    }
    
    required init?(coder aDecoder: NSCoder) {
        if let nameObj = aDecoder.decodeObject(forKey: musicStruct.name) as? String {
            _name = nameObj
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(_name, forKey: musicStruct.name)
    }
    
    name: String {
        get {
        return _name
        }
        set {
        return _name = newvalue
        }
 }
 
}
*/
