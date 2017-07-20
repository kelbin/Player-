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
    @IBAction func playButton(_ sender: Any) {
        let url = URL(string: "https://cs1-46v4.vk-cdn.net/p19/d4726e26efde32.mp3?extra=zcCFmZYSDtYaIpoTA2g_pJS4cba3xsDRdYGnozwSPc6jhDRFeHcTZFBapeiuUsQoibDLs-4oMZxyWsa9BsyQgWSlqs1l0hyfwG3NVJLnFNJJI5qWIRyXe4kmHoe-o3V444LIcIrEOBAQXQkY")
        let player = AVPlayer(url:url!)
        let controller = AVPlayerViewController()
        controller.player = player
        present(controller,animated: true) {
            player.play()
        }
    }
    var musicVar: MusicService = JsonFileSongService()
    var musicList: Array<String> = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.appendMusicList()
        // Do any additional setup after loading the view.
    }
    
    func appendMusicList() {
        for i in musicVar.jsonSerialize() {
            musicList.append(i.name)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
