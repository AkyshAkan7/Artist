//
//  FavouriteArtistManager.swift
//  Artist
//
//  Created by Akan Akysh on 12/27/19.
//  Copyright © 2019 Akysh Akan. All rights reserved.
//

import Foundation

class FavouriteArtistManager: NSObject {
    
    static let instance = FavouriteArtistManager()
    var favouriteArtits = [Artist]()
}
