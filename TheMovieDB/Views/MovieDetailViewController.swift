//
//  MovieDetailViewController.swift
//  TheMovieDB
//
//  Created by Scott Cox on 8/13/22.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    @IBOutlet weak var overviewTextView: UITextView!
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    
    var movie: ResultsDictionary? {
        didSet {
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func updateViews() {
        guard let movie = movie else {
            return
        }
        NetworkController.fetchPosterPath(with: movie.posterPath ?? "poster unavailable") { [weak self] result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.titleLabel.text = movie.title
                    self?.releaseDateLabel.text = "Release date: \(movie.releaseDate)"
                    self?.overviewTextView.text = movie.overview
                    self?.posterImageView.image = image
                }
            case .failure(let error):
                print(error.errorDescription!)
            }
        }
        
        
    }

    
}
