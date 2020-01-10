//
//  FavouriteArtistDescriptionViewController.swift
//  Artist
//
//  Created by Akan Akysh on 12/27/19.
//  Copyright © 2019 Akysh Akan. All rights reserved.
//

import UIKit
import AlamofireImage

class FavouriteArtistDescriptionViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var artistBornYearLabel: UILabel!
    @IBOutlet weak var artistGenreLabel: UILabel!
    @IBOutlet weak var artistWebsiteButton: UIButton!
    @IBOutlet weak var artistBiographyLabel: UILabel!
    
    var artist: Artist! = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    

    func setupView() {
        // load image
        imageView.af_setImage(withURL: URL(string: artist.imageUrl)!)
        
        // setup ui elements with data
        if artist != nil {
            artistNameLabel.text = artist.name
            artistBornYearLabel.text = artist.bornYear
            artistGenreLabel.text = artist.genre
            artistWebsiteButton.setTitle(artist.website, for: .normal)
            artistBiographyLabel.text = artist.biography
        }
    }

}
