//
//  File.swift
//  MyMusic
//
//  Created by Mo Elahmady on 12/12/2020.
//  Copyright © 2020 Mo Elahmady. All rights reserved.
//



import UIKit


class SongCell: UITableViewCell {

    //MARK: - Outlets
    
    @IBOutlet weak var songImageView: UIImageView!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var songAlbumLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    //this function is used to configure the cell
    func configure(song: Song) {
        
        self.songNameLabel.text = song.name
        self.songAlbumLabel.text = song.albumName
        self.songImageView.image = UIImage(named: song.imageName)
    }

}
