//
//  MusicGenreListViewController.swift
//  Player
//
//  Created by Келбин on 15.08.17.
//  Copyright © 2017 Келбин. All rights reserved.
//

import UIKit

class MusicGenreListViewController: UITableViewController {
    let musicVar: MusicService = JsonFileMusicService()
    private var uniqueMusicListGenre: [String] = []
    public var musicListResult: [Music] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        shapingGenreList()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func shapingGenreList() {
        let musicList = musicVar.musicList
        let uniqueMusicList = musicList.map { $0.genre }
        uniqueMusicListGenre = Array(Set(uniqueMusicList))
    }
    
    // MARK: - Table view data source

    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return uniqueMusicListGenre.count
    }

    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = uniqueMusicListGenre[indexPath.row]
        return cell
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let musicChange = uniqueMusicListGenre[indexPath.row]
        musicListResult = musicVar.musicList.filter{ $0.genre == musicChange }
        //musicListResult = musicList.map { $0.name }
        performSegue(withIdentifier: "segue", sender: self)
    }
    
    // MARK: - Navigation
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondTableViewController = segue.destination as! MusicGenreListSubViewController
        secondTableViewController.musicList = musicListResult
    }

}
