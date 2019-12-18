//
//  DetailPodcastViewController.swift
//  Unit3-ReviewLab
//
//  Created by Liubov Kaper  on 12/17/19.
//  Copyright © 2019 Luba Kaper. All rights reserved.
//

import UIKit

class DetailPodcastViewController: UIViewController {
    
    @IBOutlet weak var podcastImage: UIImageView!
    
    
    @IBOutlet weak var podcastName: UILabel!
    
    
    @IBOutlet weak var artistNameLabel: UILabel!
    
    @IBOutlet weak var genreLabel: UILabel!
    
    var podcastInfo: Podcast?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
    }
    
    func updateUI() {
        guard let podcast = podcastInfo else {
            fatalError("check prepare for segueue")
        }
        podcastName.text = podcast.collectionName
        artistNameLabel.text = podcast.artistName
        genreLabel.text = podcast.genres?.first
        
        podcastImage.getImage(with: podcast.artworkUrl100 ?? "") { [weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.podcastImage.image = UIImage(systemName: "excaimationmark.triangle")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.podcastImage.image = image
                }
            }
        }
    }

   // this function creates the post tho the URLEndpoint
    @IBAction func addToFavorites(_ sender: UIBarButtonItem) {
        
        sender.isEnabled = false
        
        guard let podcast = podcastInfo else{
            fatalError("error")
        }
        
        let podcastPost = Podcast(artistName: podcast.artistName, trackName: podcast.trackName, artworkUrl100: podcast.artworkUrl100, artworkUrl600: podcast.artworkUrl600, genres: podcast.genres, collectionName: podcast.collectionName, trackId: podcast.trackId, favoritedBy: "Luba") //(trackId: podcast.trackId, favoritedBy: "Luba", collectionName: podcast.collectionName, artworkUrl600: podcast.artworkUrl600)
        
        PodcastAPIClient.postPodcast(podcast: podcastPost) { [weak self, weak sender] (result) in
          DispatchQueue.main.async {
            sender?.isEnabled = true
          }
          switch result {
          case .failure(let appError):
            DispatchQueue.main.async {
              self?.showAlert(title: "Error posting podcast", message: "\(appError)")
            }
          case .success:
            DispatchQueue.main.async {
              self?.showAlert(title: "Success", message: "podcast was posted") { action in
                self?.dismiss(animated: true)
              }
            }
          }
        }
    }
    
      
}
