//
//  PlayerController.swift
//  Player
//
//  Created by Келбин on 20.07.17.
//  Copyright © 2017 Келбин. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class PlayerController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var urlForPlaying: String = ""
    var musicVar: MusicService = JsonFileMusicService()
    var musicLister: Array<String> = []
    var musicList: Array<String> = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.appendMusicList()
        self.appendMusicLister()
        // Do any additional setup after loading the view.
    }
    
    func appendMusicList() {
        for i in musicVar.musicList {
            musicList.append(i.name)
        }
    }
    func appendMusicLister() {
        for i in musicVar.musicList {
            musicLister.append(i.url)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicList.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = musicList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        urlForPlaying = musicLister[indexPath.row]
        
    }
    
    @IBAction func playButton(_ sender:Any) {
        let url = Bundle.main.url(forResource: urlForPlaying, withExtension: "")
        let player = AVPlayer(url:url!)
        let controller = AVPlayerViewController()
        controller.player = player
        present(controller,animated: true) {
            player.play()
        }
    }
    
    func archiveData(musicList: [Music]) -> Data {
        return NSKeyedArchiver.archivedData(withRootObject: musicList)
    }
    
    func unarchiveData(data: Data) -> [Music] {
        return NSKeyedUnarchiver.unarchiveObject(with: data) as? [Music] ?? []
    }
}
