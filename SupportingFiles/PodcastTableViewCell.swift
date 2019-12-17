//
//  PodcastTableViewCell.swift
//  Unit3-ReviewLab
//
//  Created by Liubov Kaper  on 12/17/19.
//  Copyright © 2019 Luba Kaper. All rights reserved.
//

import UIKit

class PodcastTableViewCell: UITableViewCell {

    @IBOutlet weak var podcastImageView: UIImageView!
    
    @IBOutlet weak var artistNameLabel: UILabel!
    
    
    @IBOutlet weak var songNameLabel: UILabel!
    
    
    @IBOutlet weak var podcastNameLabel: UILabel!
    
    
    func configureCell(for podcast: Podcast) {
        artistNameLabel.text = podcast.artistName
        
        songNameLabel.text = podcast.trackName
        podcastNameLabel.text = podcast.collectionName
        
        podcastImageView.getImage(with: podcast.artworkUrl100) { [weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.podcastImageView.image = UIImage(systemName: "excaimationmark.triangle")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.podcastImageView.image = image
                }
            }
        }
    }
    
}
