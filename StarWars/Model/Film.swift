//
//  Film.swift
//  StarWars
//
//  Created by lpiem on 12/03/2020.
//  Copyright © 2020 lpiem. All rights reserved.
//

import Foundation

struct Film: Codable {
    let title: String
    let episode_id: Int
    let opening_crawl: String
    let director: String
    let producer: String
    let release_date: String
    var image_path: String?
    
    func getImagePath() -> URL {
        return URL(string: "https://image.tmdb.org/t/p/w500" + (image_path ?? ""))!
    }
}
