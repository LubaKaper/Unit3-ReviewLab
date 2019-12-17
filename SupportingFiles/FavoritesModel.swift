//
//  PostPodcastAPIClient.swift
//  Unit3-ReviewLab
//
//  Created by Liubov Kaper  on 12/17/19.
//  Copyright © 2019 Luba Kaper. All rights reserved.
//

import Foundation

struct Favorite: Codable {
    let trackId: Int 
    let favoritedBy: String
    let collectionName: String
    let artworkUrl600: String
   
}
