//
//  Movie.swift
//  movies
//
//  Created by Abdulla Jafar on 1/25/21.
//

import Foundation

struct Movie : Codable , Equatable, Identifiable  {
    
    var id: UUID
        
    let name, genre: String
    let rating: Double
    let posterImage, story: String
    let images: [MovieImage]
    let cast: [Cast]
    
    static var example  = Movie (
        id: UUID(),
        name: "John ",
        genre: "Action",
        rating: 8.4,
        posterImage: "im-johnwick-poster",
        story: "Super-assassin John Wick returns with a $14 million price tag on his head and an army of bounty-hunting killers on his trail. After killing a member of the shadowy international assassin’s guild, the High Table, John Wick is excommunicado, but the world’s most ruthless hit men and women await his every turn.",
        images: [
            MovieImage( id: UUID(), image: "im-john-whick_media-1"),
            MovieImage( id: UUID(), image: "im-john-whick-media-2")
        ], cast: [
            Cast( id: UUID(), name: "Keanu Reeves", cherecterName: "John Wick", image: "im-keanu-reeves"),
            Cast( id: UUID(), name: "Keanu Reeves", cherecterName: "John Wick", image: "im-keanu-reeves")
        ]
    )
    
}

struct Cast : Codable, Equatable {
    var id : UUID
    let name, cherecterName, image: String
}

struct MovieImage :  Equatable, Codable {
    var id : UUID
    let image: String
}
