//
//  FavoritePodcastsViewController.swift
//  Unit3-ReviewLab
//
//  Created by Liubov Kaper  on 12/17/19.
//  Copyright © 2019 Luba Kaper. All rights reserved.
//

import UIKit

class FavoritePodcastsViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    private var refreshControl: UIRefreshControl!
    
    
    var favoritePodcasts = [Podcast]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    var favePodcast: Podcast?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchFave()
        tableView.dataSource = self 
        tableView.delegate = self
        configureRefreshControl()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailPodcastVC = segue.destination as? DetailPodcastViewController, let indexPath = tableView.indexPathForSelectedRow else {
            fatalError("error")
        }
        let podcastInfo = favoritePodcasts[indexPath.row]
        detailPodcastVC.podcastInfo = podcastInfo
    }
    
    func configureRefreshControl() {
      refreshControl = UIRefreshControl()
      tableView.refreshControl = refreshControl
      
      // programmable target-action using objective-c runtime api
      refreshControl.addTarget(self, action: #selector(fetchFave), for: .valueChanged)
    }
    @objc
    func fetchFave() {
        PodcastAPIClient.fetchFavoritePodcast {[weak self] (result) in
            
            DispatchQueue.main.async {
              self?.refreshControl.endRefreshing()
            }
            switch result {
            case .failure(let appError):
            DispatchQueue.main.async {
              self?.showAlert(title: "Failed fetching favorite", message: "\(appError)")
            }
            case .success(let favorites):
                self?.favoritePodcasts = favorites.filter {$0.favoritedBy == "Luba" }
            }
        }
    }


}

extension FavoritePodcastsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritePodcasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as? FavoritesTableViewCell else {
            fatalError("")
        }
        let favorite = favoritePodcasts[indexPath.row]
        cell.configureCell(for: favorite)
        return cell
    }
    
    
}

extension FavoritePodcastsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
