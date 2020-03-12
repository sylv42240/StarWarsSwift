//
//  FilmTableViewCell.swift
//  StarWars
//
//  Created by lpiem on 12/03/2020.
//  Copyright © 2020 lpiem. All rights reserved.
//

import UIKit
import Kingfisher

class FilmTableViewCell: UITableViewCell {
    
    public static let reuseIdentifier = "FilmCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var filmTitle: UILabel!
    @IBOutlet weak var filmDate: UILabel!
    @IBOutlet weak var filmImage: UIImageView!
    
    public func configureWith(_ film: Film) {
        filmTitle.text = film.title
        filmDate.text = getDate(date: film.release_date)
        if (film.image_path != nil){
            filmImage.kf.setImage(with: film.getImagePath(), options: [.transition(.fade(0.3))])
        }
    }

}

extension FilmTableViewCell {
    private func getDate(date: String) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd MMM yyyy"

        if let date = dateFormatterGet.date(from: date) {
            return dateFormatterPrint.string(from: date)
        } else {
           return "error"
        }
    }
}
