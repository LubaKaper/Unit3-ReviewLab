//
//  PodcastModel.swift
//  Unit3-ReviewLab
//
//  Created by Liubov Kaper  on 12/17/19.
//  Copyright © 2019 Luba Kaper. All rights reserved.
//

import Foundation

struct PodcastArray: Codable {
    let results: [Podcast]
}
struct Podcast: Codable {
    let artistName: String?
    let trackName: String?
    let artworkUrl100: String?
    let artworkUrl600: String
    let genres: [String]?
    let collectionName: String
    let trackId: Int?
    let favoritedBy: String?
}
