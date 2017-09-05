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
        pictureView.loadPicture(url: url)
        nameLabel?.text = music?.name
        genreLabel?.text = music?.genre
        authorLabel?.text = music?.author
    }
}

