//
//  ApiManager.swift
//  Artist
//
//  Created by Akan Akysh on 12/11/19.
//  Copyright © 2019 Akysh Akan. All rights reserved.
//

import Foundation
import Alamofire

class ApiManager {
    
    private static let artistEndpoint = "https://theaudiodb.com/api/v1/json/1/search.php"
    
    private static let trackEndpoint = "https://theaudiodb.com/api/v1/json/1/track-top10.php"
    
    private static let albumEndPoint = "https://theaudiodb.com/api/v1/json/1/searchalbum.php"
    
    private static let albumTrackEndPoint = "https:/theaudiodb.com/api/v1/json/1/track.php"
    
    private static let musicVideoEndPoint = "https:/theaudiodb.com/api/v1/json/1/mvid.php"
    
    static func loadArtists(artistName: String, onComplete: @escaping (ArtistResponse) -> Void,
                            onError: @escaping () -> Void) {
        Alamofire.request(artistEndpoint, parameters: ["s": "\(artistName)"]).responseData { (response) in
            let artistResponse = try? JSONDecoder().decode(ArtistResponse.self, from: response.data!)
            
            if artistResponse == nil {
                onError()
                
                return
            }
            
            onComplete(artistResponse!)
        }
    }
    
    static func loadArtistTracks(artistName: String, onComplete: @escaping (TrackResponse) -> Void,
                                onError: @escaping () -> Void) {
        Alamofire.request(trackEndpoint, parameters: ["s": "\(artistName)"]).responseData { (response) in
            let trackResponse = try? JSONDecoder().decode(TrackResponse.self, from: response.data!)
            
            if trackResponse == nil {
                onError()
                
                return
            }
            
            onComplete(trackResponse!)
        }
    }
    
    static func loadArtistAlbums(artistName: String, onComplete: @escaping (AlbumResponse) -> Void,
                                 onError: @escaping () -> Void) {
        Alamofire.request(albumEndPoint, parameters: ["s": "\(artistName)"]).responseData { (response) in
            let albumResponse = try? JSONDecoder().decode(AlbumResponse.self, from: response.data!)
            
            if albumResponse == nil {
                onError()
                
                return
            }
            
            onComplete(albumResponse!)
        }
    }
    
    static func loadAlbumTracks(albumId: String, onComplete: @escaping (AlbumTrackResponse) -> Void,
                                onError: @escaping () -> Void) {
        Alamofire.request(albumTrackEndPoint, parameters: ["m": "\(albumId)"]).responseData { (response) in
            let albumTrackResponse = try? JSONDecoder().decode(AlbumTrackResponse.self, from: response.data!)
            
            if albumTrackResponse == nil {
                onError()
                
                return
            }
            
            onComplete(albumTrackResponse!)
        }
    }
    
    static func loadMusicVideos(artistId: String, onComplete: @escaping (MusicVideoResponse) -> Void,
                                onError: @escaping () -> Void) {
        Alamofire.request(musicVideoEndPoint, parameters: ["i": "\(artistId)"]).responseData { (response) in
            let musicVideoResponse = try? JSONDecoder().decode(MusicVideoResponse.self, from: response.data!)
            
            if musicVideoResponse == nil {
                onError()
                
                return
            }
            
            onComplete(musicVideoResponse!)
        }
    }
    
}
