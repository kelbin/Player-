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
    @IBOutlet weak var durationMusic: UISlider?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appendMusicUrl()
        play.isHidden = true
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
    
    @IBAction func musicRewind(_ sender: UISlider) {
        player.currentTime = TimeInterval(sender.value)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? MusicTableViewCell else { return }
        if let url = cell.music?.url { urlForPlaying = url }
        play.isHidden = false
        initAudioPlayer()
    }
    
    func initAudioPlayer() {
        do {
            let url = Bundle.main.url(forResource: urlForPlaying, withExtension: "")
            try player = AVAudioPlayer(contentsOf: url!)
        } catch {
            print("Error")
        }
       // Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: updateSlider(_:))
    }
    
    @IBAction func playButton(_ sender: UISlider) {
        play.setTitle("Pause", for: .normal)
        player.play()
        durationMusic?.maximumValue = Float(player.duration)
        durationMusic?.value = Float(player.currentTime)
        if (player.play()) {
            play.addTarget(self, action: #selector(stopButton(_:)), for: .touchUpInside)
        } else {
            player.play()
        }
    }
    /*
    func updateSlider(_ timer: Timer) {
        durationMusic?.value = Float(player.currentTime)
        durationMusic?.isContinuous = true
    }*/
    
    @IBAction func stopButton(_ sender:Any) {
        play.setTitle("Play", for: .normal)
        player.pause()
        play.addTarget(self, action:#selector(playButton(_:)), for: .touchUpInside)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
