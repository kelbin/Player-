//
//  MusicTableViewCell.swift
//  Player
//
//  Created by Келбин on 01.08.17.
//  Copyright © 2017 Келбин. All rights reserved.
//

import UIKit

class MusicTableViewCell: UITableViewCell {
    @IBOutlet var genreLabel: UILabel?
    @IBOutlet var authorLabel: UILabel?
    @IBOutlet var nameLabel: UILabel?

    var music: Music? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        nameLabel?.text = music?.name
        genreLabel?.text = music?.genre
        authorLabel?.text = music?.author
    }
}

