//
//  MovieGalleryView.swift
//  movies
//
//  Created by Abdulla Jafar on 2/14/21.
//

import SwiftUI

struct MovieGalleryView: View {
    let item : Movie
    var body: some View {
        ScrollView (.horizontal,showsIndicators: false){
            HStack (spacing : 15){
                ForEach(item.images,id: \.id) { imageItem in
                        HStack (spacing: 20){
                            Image(imageItem.image)
                                .resizable()
                                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                                .frame(width: 190, height: 163, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .cornerRadius(15)
                        }
                }
            }

        }
    }
}

struct MovieGalleryView_Previews: PreviewProvider {
    static var previews: some View {
        MovieGalleryView(item: Movie.example)
    }
}
