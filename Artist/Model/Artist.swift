//
//  Artist.swift
//  Artist
//
//  Created by Akan Akysh on 12/11/19.
//  Copyright © 2019 Akysh Akan. All rights reserved.
//

import Foundation

struct Artist {
    let id: String
    let name: String
    let bornYear: String
    let genre: String
    let website: String
    let biography: String
    let imageUrl: String
}

extension Artist: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "idArtist"
        case name = "strArtist"
        case bornYear = "intBornYear"
        case genre = "strGenre"
        case website = "strWebsite"
        case biography = "strBiographyEN"
        case imageUrl = "strArtistThumb"
    }
}

extension Artist: Equatable {
    static func == (lhs: Artist, rhs: Artist) -> Bool {
        return
            lhs.id == rhs.id &&
                lhs.name == rhs.name &&
                lhs.bornYear == rhs.bornYear
    }
}

// Array of artists
struct ArtistResponse: Codable {
    let artists: [Artist]
}
