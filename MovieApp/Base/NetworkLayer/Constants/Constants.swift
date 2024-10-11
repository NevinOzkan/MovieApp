//
//  Constants.swift
//  MovieApp
//
//  Created by Nevin Özkan on 5.10.2024.
//

import Foundation

struct Constants {
    
    struct URL {
        static let apıKey = "1ae0a7f53c245e3bc03196612d1e663a"
        static let upcomingUrl = "https://api.themoviedb.org/3/movie/upcoming"
        static let nowPlayingUrl = "https://api.themoviedb.org/3/movie/now_playing"
        static let movieDetailUrl = "https://api.themoviedb.org/3/movie/"
    }
    
    struct Params {
        //API çağrılarına sayfa numarasını eklemek için 
        static let page = "&page="
        static let language = "&language="
    }
    struct API {
           static let apiKey = "1ae0a7f53c245e3bc03196612d1e663a"
       }
}
