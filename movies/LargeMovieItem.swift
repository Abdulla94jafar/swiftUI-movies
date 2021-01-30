//
//  LargeMovieItem.swift
//  movies
//
//  Created by Abdulla Jafar on 1/24/21.
//

import SwiftUI

struct LargeMovieItem: View {
    
    
    var item : Movie
    @Binding var isShowContent: Bool = false
    
    static let numberFormatter : NumberFormatter = {
       let f = NumberFormatter()
        f.allowsFloats = true
        f.maximumFractionDigits = 1
        return f
    }()
    
    var body: some View {
        VStack (alignment : .leading){
            Image(item.posterImage)
                .resizable(resizingMode: .stretch)
                .aspectRatio(contentMode: .fill)
                .frame(width: 290, height: 445, alignment: .center)
                .clipped()
                .cornerRadius(20)
                .shadow(color: getImageShadowColor(), radius: 10, x: -3 , y: 15)
            
            VStack (alignment: .leading){
                HStack {
                    Image("ic-imdb-badge")
                    Text("\(item.rating)")
                        .bold()
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                }.offset(CGSize(width: 0, height: 8))
                
                Text (item.name)
                    .font(.title2)
                    .bold()
                    .lineLimit(1)
                
                Text(item.genre)
                    .bold()
                    .foregroundColor(.gray)
                    .lineLimit(1)
                
            }
            .frame(width: 290, height: 90, alignment: .bottomLeading)
        }
    }
    
    
    func getImageShadowColor () -> Color {
        let image = UIImage(named: self.item.posterImage) ?? UIImage()
        let color = image.averageColor ?? .clear
        return Color(color).opacity(0.5)
    }
}

struct LargeMovieItem_Previews: PreviewProvider {
    static var previews: some View {
        LargeMovieItem(item: Movie.example)
    }
}
