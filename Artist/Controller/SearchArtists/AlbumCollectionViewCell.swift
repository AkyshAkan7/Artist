//
//  AlbumCollectionViewCell.swift
//  Artist
//
//  Created by Akan Akysh on 12/14/19.
//  Copyright © 2019 Akysh Akan. All rights reserved.
//

import UIKit

class AlbumCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var albumYearLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func set(album: Album) {
        albumNameLabel.text = album.name
        albumYearLabel.text = album.year
        
        if album.imageUrl != "", album.imageUrl != nil {
            albumImageView.af_setImage(withURL: URL(string: album.imageUrl)!)
        }
    }
    
    func setupView() {
        albumImageView.layer.cornerRadius = 5
    }

}
