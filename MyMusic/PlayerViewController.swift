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

    //variables
    public var position: Int = 0;
    public var songs: [Song] = []
    //sound variable
    var player: AVAudioPlayer?

    //MARK: - user interface elements
    
    //view
    @IBOutlet weak var holder: UIView!
    //image view
    private let albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    //labels
    private let songNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    private let albumNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    //buttons
    let backButton = UIButton()
    let nextButton = UIButton()
    let playBauseButton = UIButton()
    //slider
    var slider = UISlider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if holder.subviews.count == 0 {
            configure()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        //stop the song
        super.viewDidDisappear(animated)
        player?.stop()
    }
    
    
    
    func configure() {
        
        //MARK: - plat the song
        //play the song
        let selectedSong = songs[position]
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
        
        
        //MARK: - configure the layout
        
        //set album cover
        albumimageConfiguration(selectedSong)
        
        
        //set lables: song , album and artist names
        songNameLabelConfiguration(selectedSong)
        albumNameLabelConfiguration(selectedSong)
        artistNameLabelConfiguration(selectedSong)

        //set the slider
        sliderConfiguration(selectedSong)
        
        
        //set the Buttons: play, next and back Buttons
        playBauseButtonConfiguration(selectedSong)
        BackButtonConfiguration(selectedSong)
        NextButtonConfiguration(selectedSong)

    }
    
    
    //configure the album image
    func albumimageConfiguration(_ selectedSong: Song) {
        albumImageView.frame = CGRect(x: 10,
                                      y: 10,
                                      width: holder.frame.size.width - 20,
                                      height: holder.frame.size.width - 20)
        albumImageView.image = UIImage(named: selectedSong.imageName)
        holder.addSubview(albumImageView)

    }
    
    
    //configure the song name label
    func songNameLabelConfiguration(_ selectedSong: Song) {
        songNameLabel.frame = CGRect(x: 10,
                                     y: albumImageView.frame.size.height + 30 ,
                                     width: holder.frame.size.width - 20,
                                     height: 40)
        songNameLabel.text = selectedSong.name
        holder.addSubview(songNameLabel)

    }

    
    //configure the album name label
    func albumNameLabelConfiguration(_ selectedSong: Song) {
        albumNameLabel.frame = CGRect(x: 10,
                                      y: albumImageView.frame.size.height + 70,
                                      width: holder.frame.size.width - 20,
                                      height: 40)
        albumNameLabel.text = selectedSong.albumName
        holder.addSubview(albumNameLabel)

    }

    
    //configure the artist name label
    func artistNameLabelConfiguration(_ selectedSong: Song) {
        artistNameLabel.frame = CGRect(x: 10,
                                       y: albumImageView.frame.size.height + 110,
                                       width: holder.frame.size.width - 20,
                                       height: 40)
        artistNameLabel.text = selectedSong.artistName
        holder.addSubview(artistNameLabel)
    }
    
    
    //configure the slider
    func sliderConfiguration(_ selectedSong: Song) {
        slider = UISlider(frame: CGRect(x: 20,
                                            y: holder.frame.size.height - 60,
                                            width: holder.frame.size.width - 40,
                                            height: 50))
        slider.value = selectedSong.volumeValue
        slider.addTarget(self, action: #selector(didSlidSlider(_:)), for: .valueChanged)
        holder.addSubview(slider)
    }

    
    func playBauseButtonConfiguration(_ selectedSong: Song) {
        if selectedSong.isPlaying == true {
            playBauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        }else {
            playBauseButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
        }
        playBauseButton.tintColor = .black
        playBauseButton.addTarget(self, action: #selector(didTapPlayBauseButton), for: .touchUpInside)

        //frame
        playBauseButton.frame = CGRect(x: (holder.frame.width - 70) / 2.0,
                                       y: holder.frame.size.height - 150,
                                       width: 70,
                                       height: 70)
        
        holder.addSubview(playBauseButton)

    }
    
    func BackButtonConfiguration(_ selectedSong: Song) {
        nextButton.setBackgroundImage(UIImage(systemName: "forward.fill"), for: .normal)
        nextButton.tintColor = .black
        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)

        nextButton.frame = CGRect(x: holder.frame.width - 90,
                                       y: holder.frame.size.height - 150,
                                       width: 70,
                                       height: 70)

        
        holder.addSubview(nextButton)
    }

    func NextButtonConfiguration(_ selectedSong: Song) {
        backButton.setBackgroundImage(UIImage(systemName: "backward.fill"), for: .normal)
        backButton.tintColor = .black
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        
        backButton.frame = CGRect(x: 20,
                                       y: holder.frame.size.height - 150,
                                       width: 70,
                                       height: 70)

        
        holder.addSubview(backButton)

    }

    
    
    
    
    
    
    
    
    @objc func didSlidSlider(_ slider: UISlider) {
        let value = slider.value
        //adgust the volume
        player?.volume = value
    }
    
    
    @objc func didTapPlayBauseButton() {
        if player?.isPlaying == true {
            //pause
            player?.pause()
            playBauseButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
        } else {
            player?.play()
            playBauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)

        }
    }
    
    @objc func didTapBackButton() {
        if position > 0 {
            position = position - 1
            songs[position].volumeValue = slider.value
            if player?.isPlaying == true {
                player?.pause()
            }else {
                songs[position].isPlaying = false
            }
            for subview in holder.subviews {
                subview.removeFromSuperview()
            }
            configure()
        }
    }


    @objc func didTapNextButton() {
        if position < songs.count - 1 {
            position = position + 1
            songs[position].volumeValue = slider.value
            if player?.isPlaying == true {
                player?.pause()
            }else {
                songs[position].isPlaying = false
            }
            for subview in holder.subviews {
                subview.removeFromSuperview()
            }
            configure()
        }
    }

}
