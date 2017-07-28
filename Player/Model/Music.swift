//
//  DataMusic.swift
//  Player
//
//  Created by Келбин on 12.07.17.
//  Copyright © 2017 Келбин. All rights reserved.
//

import Foundation


class Music: NSObject, NSCoding {
    var name:String
    var url:String
    var genre:String
    var album:String?
    var author:String?
    
    struct Keys {
        static let nameKey: String = "name"
        static let urlKey: String = "url"
        static let albumKey: String = "album"
        static let genreKey: String = "genre"
        static let authorKey: String = "author"
    }
    
    init(name: String, url: String, genre: String, album: String, author: String){
        self.name = name
        self.url = url
        self.genre = genre
        self.album = album
        self.author = author
    }
    
    required  convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: Keys.nameKey) as? String,
        let url = aDecoder.decodeObject(forKey: Keys.urlKey) as? String,
        let album = aDecoder.decodeObject(forKey: Keys.albumKey) as? String,
        let genre = aDecoder.decodeObject(forKey: Keys.genreKey) as? String,
        let author =  aDecoder.decodeObject(forKey: Keys.authorKey) as? String
        else { return nil }
        self.init(
            name: name,
            url: url,
            genre: genre,
            album: album,
            author: author
        )
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: Keys.nameKey)
        aCoder.encode(url, forKey: Keys.urlKey)
        aCoder.encode(genre, forKey: Keys.genreKey)
        aCoder.encode(album, forKey: Keys.albumKey)
        aCoder.encode(author, forKey: Keys.authorKey)
    }
}

