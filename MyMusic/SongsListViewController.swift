//
//  ViewController.swift
//  MyMusic
//
//  Created by Mo Elahmady on 12/12/2020.
//  Copyright © 2020 Mo Elahmady. All rights reserved.
//

import UIKit

class SongsListViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var songs = [Song]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //abend the songs
        configureSongs()
        
        //set the delegate and the data method functions
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    func configureSongs() {
        
        songs.append(Song(name: "Rolling in the deep",
                          albumName: "Hello album",
                          artistName: "Adele",
                          imageName: "Cover1",
                          trackName: "Song1",
                          isPlaying: true,
                          volumeValue: 0.5))
        
        
        songs.append(Song(name: "Diamond",
                          albumName: "Diamond album",
                          artistName: "Rihanna",
                          imageName: "Cover2",
                          trackName: "Song2",
                          isPlaying: true,
                          volumeValue: 0.5))
        
        
        songs.append(Song(name: "Wrecking ball",
                          albumName: "Wrecking ball album",
                          artistName: "Mily Cyrus",
                          imageName: "Cover3",
                          trackName: "Song3",
                          isPlaying: true,
                          volumeValue: 0.5))
        
        
        songs.append(Song(name: "Rolling in the deep",
                          albumName: "Hello album",
                          artistName: "Adele",
                          imageName: "Cover1",
                          trackName: "Song1",
                          isPlaying: true,
                          volumeValue: 0.5))
        
        
        songs.append(Song(name: "Diamond",
                          albumName: "Diamond album",
                          artistName: "Rihanna",
                          imageName: "Cover2",
                          trackName: "Song2",
                          isPlaying: true,
                          volumeValue: 0.5))
        
        
        songs.append(Song(name: "Wrecking ball",
                          albumName: "Wrecking ball album",
                          artistName: "Mily Cyrus",
                          imageName: "Cover3",
                          trackName: "Song3",
                          isPlaying: true,
                          volumeValue: 0.5))
        
        songs.append(Song(name: "Rolling in the deep",
                          albumName: "Hello album",
                          artistName: "Adele",
                          imageName: "Cover1",
                          trackName: "Song1",
                          isPlaying: true,
                          volumeValue: 0.5))
        
        songs.append(Song(name: "Diamond",
                          albumName: "Diamond album",
                          artistName: "Rihanna",
                          imageName: "Cover2",
                          trackName: "Song2",
                          isPlaying: true,
                          volumeValue: 0.5))
        
        
        songs.append(Song(name: "Wrecking ball",
                          albumName: "Wrecking ball album",
                          artistName: "Mily Cyrus",
                          imageName: "Cover3",
                          trackName: "Song3",
                          isPlaying: true,
                          volumeValue: 0.5))
        
        
        
    }
    
}


//MARK: - Table view methods

extension SongsListViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SongCell
        let selectedSong = songs[indexPath.row]
        
        //configure the cell
        cell.configure(song: selectedSong)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // deselect the row
        tableView.deselectRow(at: indexPath, animated: true)
        
        // go to the ohter view to play the song
        let position = indexPath.row
        guard let nextVC = storyboard?.instantiateViewController(withIdentifier: "PlayerViewController") as? PlayerViewController else {
            return
        }
        nextVC.songs = songs
        nextVC.position = position
        present(nextVC, animated: true )
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}




struct Song {
    let name: String
    let albumName: String
    let artistName: String
    let imageName: String
    let trackName: String
    var isPlaying: Bool
    var volumeValue: Float
}
