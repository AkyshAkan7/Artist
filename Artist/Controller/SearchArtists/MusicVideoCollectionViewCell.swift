//
//  MusicVideoCollectionViewCell.swift
//  Artist
//
//  Created by Akan Akysh on 12/24/19.
//  Copyright © 2019 Akysh Akan. All rights reserved.
//

import UIKit
import Alamofire

class MusicVideoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var musicVideoImageView: UIImageView!
    @IBOutlet weak var musicVideoNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func set(musicVideo: MusicVideo) {
        musicVideoNameLabel.text = musicVideo.name
        if musicVideo.imageUrl != nil {
            musicVideoImageView.af_setImage(withURL: URL(string: musicVideo.imageUrl)!)
        }
    }

}
