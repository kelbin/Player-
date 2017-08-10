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
    private var urlForPlaying = ""
    private var timer:Timer? = nil
    private var musicList: [Music] = []
    private var player: AVAudioPlayer = AVAudioPlayer()
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var musicPositionSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appendMusicUrl()
        playButton?.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        timer? = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: updateSlider(_:))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timer?.invalidate()
    }
    
    func appendMusicUrl() {
        let musicVar: MusicService = JsonFileMusicService()
        musicList = musicVar.musicList
    }
    
    func initAudioPlayer() {
        guard let url = Bundle.main.url(forResource: urlForPlaying, withExtension: "") else { return }
        guard let player = try? AVAudioPlayer(contentsOf: url) else { return }
        self.player = player
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
        if let url = cell.music?.url { urlForPlaying = url }
        playButton?.isHidden = false
        initAudioPlayer()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func updateSlider(_ timer: Timer) {
        musicPositionSlider.value = Float(player.currentTime)
        musicPositionSlider.isContinuous = true
    }
    
    @IBAction func playMusic(_ sender: Any) {
        player.play()
        playButton.setTitle("Pause", for: .normal)
        musicPositionSlider.maximumValue = Float(player.duration)
        musicPositionSlider.value = Float(player.currentTime)
        if playButton.titleLabel?.text == "Pause" {
            playButton.setTitle("Play", for: .normal)
            player.pause()
            //playButton?.addTarget(self, action: #selector(stopButton(_:)), for: .touchUpInside)
        }
        else {
            player.play()
        }
    }
    
    @IBAction func musicRewind(_ sender: UISlider) {
        player.currentTime = TimeInterval(sender.value)
    }
    
  /*  @IBAction func stopButton(_ sender:Any) {
        playButton?.setTitle("Play", for: .normal)
        player.pause()
        playButton?.addTarget(self, action:#selector(playButton(_:)), for: .touchUpInside)
    }*/
}
