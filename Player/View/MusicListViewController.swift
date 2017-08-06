//
//  MusicListViewController.swift
//  Player
//
//  Created by Келбин on 20.07.17.
//  Copyright © 2017 Келбин. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class  MusicListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var play: UIButton!
    var urlForPlaying = ""
    var musicVar: MusicService = JsonFileMusicService()
    var musicList: [Music] = []
    var player: AVAudioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appendMusicUrl()
        
    }
    
    func appendMusicUrl() {
        musicList = musicVar.musicList
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? MusicTableViewCell else { fatalError("Can't create cell") }
        cell.music = musicList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? MusicTableViewCell else { return }
        if let url = cell.music?.url { urlForPlaying = url  }
    }
    
    @IBAction func playButton(_ sender: Any) {
        do {
        let url = Bundle.main.url(forResource: urlForPlaying, withExtension: "")
        try player = AVAudioPlayer(contentsOf: url!)
        }
        catch { print("Error") }
        player.play()
        play.setTitle("Pause", for: .normal)
        if (play.titleLabel?.text == "Pause") {
            play.setTitle("Play", for: .normal)
            player.pause()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func archiveData(musicList: [Music]) -> Data {
        return NSKeyedArchiver.archivedData(withRootObject: musicList)
    }
    
    func unarchiveData(data: Data) -> [Music] {
        return NSKeyedUnarchiver.unarchiveObject(with: data) as? [Music] ?? []
    }
}
