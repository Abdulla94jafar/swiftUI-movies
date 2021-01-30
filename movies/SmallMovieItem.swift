//
//  MovieItem.swift
//  movies
//
//  Created by Abdulla Jafar on 1/23/21.
//

import SwiftUI

struct SmallMovieItem: View {
    
    let item : Movie
    var body: some View {
        
        
        ZStack {
            Rectangle()
                .foregroundColor(.white)
                .frame(width: 165, height: 355, alignment: .top)
                .cornerRadius(15)
                .offset(x: 0, y: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
            VStack {
                Image(item.posterImage)
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 165, height: 295, alignment: .center)
                    .clipped()
                    .cornerRadius(15)
                
                VStack (alignment: .center){
                    Text (item.name)
                        .bold()
                        .fontWeight(.medium)
                        .lineLimit(1)
                    Text(item.genre)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                }
                .frame(width: 155, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
        }


    }
}

struct MovieItem_Previews: PreviewProvider {
    static var previews: some View {
        SmallMovieItem(item: Movie.example)
    }
}
