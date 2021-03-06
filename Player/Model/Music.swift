//
//  DataMusic.swift
//  Player
//
//  Created by Келбин on 12.07.17.
//  Copyright © 2017 Келбин. All rights reserved.
//

import Foundation


class Music: NSObject, NSCoding {
    var name: String
    var url: String
    var genre: String
    var album: String?
    var author: String?
    var picture: String
    
    private struct Keys {
        static let nameKey = "name"
        static let urlKey = "url"
        static let albumKey = "album"
        static let genreKey = "genre"
        static let authorKey = "author"
        static let pictureKey = "picture"
    }
    
    init(name: String, url: String, genre: String, album: String, author: String, picture: String) {
        self.name = name
        self.url = url
        self.genre = genre
        self.album = album
        self.author = author
        self.picture = picture
    }
    
    convenience required init?(coder decoder: NSCoder) {
        guard
            let name = decoder.decodeObject(forKey: Keys.nameKey) as? String,
            let url = decoder.decodeObject(forKey: Keys.urlKey) as? String,
            let album = decoder.decodeObject(forKey: Keys.albumKey) as? String,
            let genre = decoder.decodeObject(forKey: Keys.genreKey) as? String,
            let author =  decoder.decodeObject(forKey: Keys.authorKey) as? String,
            let picture = decoder.decodeObject(forKey: Keys.pictureKey) as? String
        else { return nil }
        
        self.init(
            name: name,
            url: url,
            genre: genre,
            album: album,
            author: author,
            picture: picture
        )
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: Keys.nameKey)
        coder.encode(url, forKey: Keys.urlKey)
        coder.encode(genre, forKey: Keys.genreKey)
        coder.encode(album, forKey: Keys.albumKey)
        coder.encode(author, forKey: Keys.authorKey)
        coder.encode(picture, forKey: Keys.pictureKey)
    }
}

