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
    
    let provider = MoyaProvider<Swapi>()
    
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

      provider.request(.film) { [weak self] result in
        guard let self = self else { return }

        switch result {
        case .success(let response):
          do {
            self.state = .ready(try response.map(SwapiFilmsResponse<Film>.self).results)
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

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: false)

    //guard case .ready(let items) = state else { return }

    //let comicVC = CardViewController.instantiate(comic: items[indexPath.item])
    //navigationController?.pushViewController(comicVC, animated: true)
  }
}
