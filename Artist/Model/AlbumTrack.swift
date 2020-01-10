//
//  AlbumTracks.swift
//  Artist
//
//  Created by Akan Akysh on 12/24/19.
//  Copyright © 2019 Akysh Akan. All rights reserved.
//

import Foundation

struct AlbumTrack {
    let name: String
    let duration: String
}

extension AlbumTrack: Codable {
    enum CodingKeys: String, CodingKey {
        case name = "strTrack"
        case duration = "intDuration"
    }
}

// Array of album tracks
struct AlbumTrackResponse: Codable {
    let track: [AlbumTrack]
}
