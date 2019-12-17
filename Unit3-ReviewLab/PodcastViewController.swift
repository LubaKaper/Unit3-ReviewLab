//
//  ViewController.swift
//  Unit3-ReviewLab
//
//  Created by Liubov Kaper  on 12/17/19.
//  Copyright © 2019 Luba Kaper. All rights reserved.
//

import UIKit

class PodcastViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var podcasts = [Podcast]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        searchPodcast(searchQuary: "")
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
    }

    func searchPodcast(searchQuary: String) {
        PodcastAPIClient.fetchPodcast(for: searchQuary, completion:  { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("error: \(appError)")
            case .success(let podcasts):
                self?.podcasts = podcasts
            }
        })
    }

}

extension PodcastViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "podcastCell", for: indexPath) as? PodcastTableViewCell else {
            fatalError("could not dequeue podcasytCell")
        }
        let podcast = podcasts[indexPath.row]
        cell.configureCell(for: podcast)
        return cell
    }
}

extension PodcastViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

extension PodcastViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
//        guard let searchText = searchBar.text else {
//        print("missing search text")
//        return
//    }
//        searchPodcast(searchQuary: searchText)
}
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchQuery = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        
//        PodcastAPIClient.fetchPodcast(for: searchQuery, completion:  { [weak self] (result) in
//            switch result {
//            case .failure(let appError):
//                print("error: \(appError)")
//            case .success(let podcasts):
//                self?.podcasts = podcasts
//            }
//        })
        searchPodcast(searchQuary: searchQuery)
    }
}
