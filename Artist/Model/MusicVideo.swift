//
//  MusicVideo.swift
//  Artist
//
//  Created by Akan Akysh on 12/24/19.
//  Copyright © 2019 Akysh Akan. All rights reserved.
//

import Foundation

struct MusicVideo {
    let name: String
    let imageUrl: String!
    let videoUrl: String!
}

extension MusicVideo: Codable {
    enum CodingKeys: String, CodingKey {
        case name = "strTrack"
        case imageUrl = "strTrackThumb"
        case videoUrl = "strMusicVid"
    }
}

// Arrays of music videos
struct MusicVideoResponse: Codable {
    let mvids: [MusicVideo]
}
