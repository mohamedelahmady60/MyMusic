//
//  PlayerViewController.swift
//  MyMusic
//
//  Created by Mo Elahmady on 13/12/2020.
//  Copyright © 2020 Mo Elahmady. All rights reserved.
//

import UIKit
import AVFoundation

class PlayerViewController: UIViewController {
    
    //sound variable
    var player: AVAudioPlayer?
    
    //MARK: - Outlets
    
    //view
    @IBOutlet weak var holder: UIView!
    
    //labels
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var albumNameLabel: UILabel!
    //image view
    @IBOutlet weak var albumImageview: UIImageView!
    
    //buttons
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    //slider
    @IBOutlet weak var volumeSlider: UISlider!
    
    
    
    //variables
    public var position: Int = 0;
    private var songsCopy: [Song] = []
    public var songs: [Song] = [] {
        didSet {
            self.songsCopy = songs
            allConfigurations()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
        
    override func viewDidDisappear(_ animated: Bool) {
        //stop the song
        super.viewDidDisappear(animated)
        player?.stop()
    }
    
    
    func allConfigurations() {
        
        //play the song
        let selectedSong = songsCopy[position]
        let urlString = Bundle.main.path(forResource: selectedSong.trackName, ofType: "mp3")
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            guard let url = urlString else {return}
            player = try AVAudioPlayer(contentsOf: URL(string: url)!)
            guard let player = player else {return}
            player.volume = selectedSong.volumeValue
            if selectedSong.isPlaying == true { player.play() }
        }catch {
            print("error playing the song ")
        }
        
        
        
        
        //set album cover
        if selectedSong.isPlaying == true {
            albumImageview.image = UIImage(named: selectedSong.imageName)
            albumImageview.frame = CGRect(x: 10,
                                          y: 10,
                                          width: holder.frame.size.width - 20,
                                          height: holder.frame.size.height / 2.0)
        }else {
            albumImageview.frame = CGRect(x: 30,
                                          y: 30,
                                          width: holder.frame.size.width - 60,
                                          height: holder.frame.size.height / 3.0)
        }
        
        //set lables: song , album and artist names
        songNameLabel.text = selectedSong.name
        albumNameLabel.text = selectedSong.albumName
        artistNameLabel.text = selectedSong.artistName
        
        //set the slider
        volumeSlider.value = selectedSong.volumeValue
        
        //configure the buttons
        playPauseButton.tintColor = .black
        if selectedSong.isPlaying == true {
            playPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        }else {
            playPauseButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
        }
        nextButton.tintColor = .black
        backButton.tintColor = .black
    }
    
    
    
    @IBAction func playPauseButtonGotPressed(_ sender: UIButton) {
        if songsCopy[position].isPlaying == true {
            //pause
            player?.pause()
            songsCopy[position].isPlaying = false
            playPauseButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
        } else {
            player?.play()
            songsCopy[position].isPlaying = true
            playPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
    }
    
    
    @IBAction func backButtonGotPressed(_ sender: UIButton) {
        if position > 0 {
            let oldPos = position
            position = position - 1
            songsCopy[position].volumeValue = volumeSlider.value
            if songsCopy[oldPos].isPlaying == true {
                player?.pause()
            }else {
                songsCopy[position].isPlaying = false
                songsCopy[oldPos].isPlaying = true
            }
            allConfigurations()
        }
        
    }
    
    @IBAction func nextButtonGotPressed(_ sender: UIButton) {
        if position < songsCopy.count - 1 {
            let oldPos = position
            position = position + 1
            songsCopy[position].volumeValue = volumeSlider.value
            if songsCopy[oldPos].isPlaying == true {
                player?.pause()
            }else {
                songsCopy[position].isPlaying = false
                songsCopy[oldPos].isPlaying = true
            }
            allConfigurations()
        }
        
    }
    
    @IBAction func volumeSliderGotChanged(_ sender: UISlider) {
        let value = volumeSlider.value
        //adgust the volume
        player?.volume = value
    }
    
    
    
}
