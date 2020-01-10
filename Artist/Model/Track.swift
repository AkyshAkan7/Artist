//
//  Track.swift
//  Artist
//
//  Created by Akan Akysh on 12/13/19.
//  Copyright © 2019 Akysh Akan. All rights reserved.
//

import Foundation

struct Track {
    let name: String
    let albumName: String
    let duration: String
    let genre: String
    let mood: String?
    let imageUrl: String?
}

extension Track: Codable {
    enum CodingKeys: String, CodingKey {
        case name = "strTrack"
        case albumName = "strAlbum"
        case duration = "intDuration"
        case genre = "strGenre"
        case mood = "strMood"
        case imageUrl = "strTrackThumb"
    }
}

// Array of tracks
struct TrackResponse: Codable {
    let track: [Track]
}
