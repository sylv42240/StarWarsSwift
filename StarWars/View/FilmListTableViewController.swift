//
//  FilmListTableViewController.swift
//  StarWars
//
//  Created by lpiem on 12/03/2020.
//  Copyright © 2020 lpiem. All rights reserved.
//

import Foundation
import UIKit
import Moya

class FilmListTableViewController: UITableViewController {
    
    @IBOutlet weak var errorLabel: UILabel!
    
    let swapiProvider = MoyaProvider<Swapi>()
    let tmdbProvider = MoyaProvider<TMDB>()
    
    
    private var state: State = .loading {
      didSet {
        switch state {
        case .ready:
          errorLabel.isHidden = true
          tableView.reloadData()
        case .loading:
          errorLabel.isHidden = false
          errorLabel.text = "Getting films ..."
        case .error:
          errorLabel.isHidden = false
          errorLabel.text = "Something went wrong!"
        }
      }
    }

    override func viewDidLoad() {
      super.viewDidLoad()

      state = .loading

      swapiProvider.request(.film) { [weak self] result in
        guard let self = self else { return }

        switch result {
        case .success(let response):
          do {
            var movies = try response.map(SwapiFilmsResponse<Film>.self).results
            for index in 0...movies.count-1{
                self.tmdbProvider.request(.search(movies[index].title)){ [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case .success(let response): do {
                        let imagePath = try response.map(TMDBResponse<TMDBMovieListResult>.self).results.first?.poster_path
                        movies[index].image_path = imagePath
                        self.state = .ready(movies)
                    }catch{
                        self.state = .error
                    }
                    case .failure( _):
                        self.state = .error
                    }
                }
            }
            
            self.state = .ready(movies)
          } catch {
            self.state = .error
          }
        case .failure:
          self.state = .error
        }
      }
    }
}

extension FilmListTableViewController {
  enum State {
    case loading
    case ready([Film])
    case error
  }
}

// MARK: - UITableView Delegate & Data Source
extension FilmListTableViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: FilmTableViewCell.reuseIdentifier, for: indexPath) as? FilmTableViewCell ?? FilmTableViewCell()

    guard case .ready(let items) = state else { return cell }

    cell.configureWith(items[indexPath.item])

    return cell
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard case .ready(let items) = state else { return 0 }
    
    return items.count
  }

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

}
