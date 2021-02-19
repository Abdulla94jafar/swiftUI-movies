//
//  LargeItemDetailsView.swift
//  movies
//
//  Created by Abdulla Jafar on 2/9/21.
//

import SwiftUI

struct LargeItemDetailsView: View {
    
    let item : Movie
    var body: some View {
        VStack (alignment: .leading){
            HStack {
                Image("ic-imdb-badge")
                    .animation(.default)
                Text(getFormattedRating(item.rating))
                    .font(.custom("AvenirNext-DemiBold", size: 13))
                    .foregroundColor(.veryLightGray)
                    
            }
            VStack (alignment: .leading){
                Text (item.name)
                    .lineLimit(1)
                    .font(.custom("AvenirNext-Bold", size: 20))
                    .foregroundColor(.coolBlack)
                
                Text(item.genre)
                    .foregroundColor(.veryLightGray)
                    .lineLimit(1)
                    .font(.custom("AvenirNext-DemiBold", size: 17))
            }
            .offset(x: 0, y: -8)
        }
    }
    
    
    func getFormattedRating (_ rating : Double ) -> String {
        let f = NumberFormatter()
        f.numberStyle = .decimal
        return f.string(from: NSNumber(value: rating)) ?? ""
    }
}

struct LargeItemDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        LargeItemDetailsView(item: Movie.example)
    }
}
