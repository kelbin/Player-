//
//  MusicTableViewCell.swift
//  Player
//
//  Created by Келбин on 01.08.17.
//  Copyright © 2017 Келбин. All rights reserved.
//

import UIKit

class MusicTableViewCell: UITableViewCell {
    @IBOutlet public var genreLabel: UILabel?
    @IBOutlet public var authorLabel: UILabel?
    @IBOutlet public var nameLabel: UILabel?
    @IBOutlet public var pictureView: UIImageView!
    
    
    var music: Music? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        guard let url = URL(string: (music?.picture)!) else { fatalError("False") }
        loadPicture(url: url)
        nameLabel?.text = music?.name
        genreLabel?.text = music?.genre
        authorLabel?.text = music?.author
    }
    
    func fetchPicture(url: URL, completion: @escaping (_ data: Data?, _ response: URLResponse?,_ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data,response,error) in completion(data,response,error)
            }.resume()
    }
    
    func loadPicture(url: URL) {
        print("Начало загрузки")
        fetchPicture(url: url) {(data, response, error) in
            guard let data = data else { return }
            DispatchQueue.main.async { () -> Void in
                self.pictureView?.image = UIImage(data: data)
            }
        }
    }

    
}

