//
//  Track.swift
//  ItunesApp827
//
//  Created by mac on 9/11/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation

struct TrackResponse: Decodable {
    let results: [Track]
}


class Track: Decodable {
    
    let name: String?
    let url: String?
    let image: String
    let price: Double?
    let releaseDate: String
    let duration: Int?
    
    
    init(core: CoreTrack) {
        self.name = core.name!
        self.url = core.url!
        self.image = core.image!
        self.price = core.price
        self.releaseDate = core.releaseDate!
        self.duration = Int(core.duration)
        
    }
    
    private enum CodingKeys: String, CodingKey {
        case name = "trackName"
        case url = "previewUrl"
        case image = "artworkUrl100"
        case price = "trackPrice"
        case releaseDate
        case duration = "trackTimeMillis"
    }
    
}
