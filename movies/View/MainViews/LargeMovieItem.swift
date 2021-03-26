//
//  LargeMovieItem.swift
//  movies
//
//  Created by Abdulla Jafar on 1/24/21.
//

import SwiftUI

struct LargeMovieItem: View {
    
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    var item : Movie
    
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
                    .frame(width: LargeMovieItem.screenWidth - 100 , height: LargeMovieItem.screenHeight * 0.5, alignment: .center)
                    .clipped()
                    .cornerRadius(20)
                    .shadow(color: getImageShadowColor(), radius: 10, x: -3 , y: 10)
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
