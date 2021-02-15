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
                .cornerRadius(15)
                .offset(x: 0, y: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
            VStack (spacing : 10){
                Image(item.posterImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
                    .cornerRadius(15)
                
                VStack (alignment: .center){
                    Text (item.name)
                        .foregroundColor(.coolBlack)
                        .font(.custom("AvenirNext-Bold", size: 16))
                        .lineLimit(1)
                    Text(item.genre)
                        .foregroundColor(.veryLightGray)
                        .lineLimit(1)
                        .font(.custom("AvenirNext-DemiBold", size: 13))
                }
                .padding(.horizontal,10)
            }
        }


    }
}

struct MovieItem_Previews: PreviewProvider {
    static var previews: some View {
        SmallMovieItem(item: Movie.example)
    }
}
