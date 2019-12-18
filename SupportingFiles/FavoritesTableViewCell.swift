//
//  FavoritesTableViewCell.swift
//  Unit3-ReviewLab
//
//  Created by Liubov Kaper  on 12/17/19.
//  Copyright © 2019 Luba Kaper. All rights reserved.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {

    
    @IBOutlet weak var favoriteImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    @IBOutlet weak var favoriteByLabel: UILabel!
    
    
    func configureCell(for favorite: Podcast) {
        
        nameLabel.text = favorite.collectionName
        favoriteByLabel.text = favorite.favoritedBy
        
        favoriteImage.getImage(with: favorite.artworkUrl600) { [weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.favoriteImage.image = UIImage(systemName: "excaimationmark.triangle")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.favoriteImage.image = image
                }
            }
        }
        
    }
    
}
