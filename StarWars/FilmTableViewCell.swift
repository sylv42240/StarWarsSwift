//
//  FilmTableViewCell.swift
//  StarWars
//
//  Created by lpiem on 12/03/2020.
//  Copyright © 2020 lpiem. All rights reserved.
//

import UIKit

class FilmTableViewCell: UITableViewCell {
    
    public static let reuseIdentifier = "FilmCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var filmTitle: UILabel!
    @IBOutlet weak var filmDate: UILabel!
    
    public func configureWith(_ film: Film) {
      filmTitle.text = film.title
      filmDate.text = film.release_date
    }

}
