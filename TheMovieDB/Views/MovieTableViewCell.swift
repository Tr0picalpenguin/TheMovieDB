//
//  MovieTableViewCell.swift
//  TheMovieDB
//
//  Created by Scott Cox on 8/14/22.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    
    func updateView(with movie: ResultsDictionary) {
        titleLabel.text = movie.title
        releaseDateLabel.text = movie.releaseDate
        ratingLabel.text = "\(movie.rating)"
    }

}
