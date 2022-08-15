//
//  TheMovieDBTableViewController.swift
//  TheMovieDB
//
//  Created by Scott Cox on 8/9/22.
//

import UIKit

class TheMovieDBTableViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Properties
    
    var movies: [ResultsDictionary] = []
    
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        
        let movie = movies[indexPath.row]
        cell.updateView(with: movie)
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            if let indexPath = tableView.indexPathForSelectedRow {
                if let destination = segue.destination as? MovieDetailViewController {
                    let movieToSend = movies[indexPath.row]
                    destination.movie = movieToSend
                }
                
            }
        }
    }
} // End of class

extension TheMovieDBTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchTerm = searchBar.text else {
            print("No text entered.")
            return
        }
        
      
        NetworkController.fetchMovieDictionary(with: searchTerm) { result in
            switch result {
            case.success(let movieDict):
                self.movies = movieDict.results
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.searchBar.resignFirstResponder()
                }
            case.failure(let error):
                print("There was an error!", error.errorDescription!)
        }
        }
    }
}
