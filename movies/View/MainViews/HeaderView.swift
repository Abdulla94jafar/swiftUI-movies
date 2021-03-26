//
//  HeaderView.swift
//  movies
//
//  Created by Abdulla Jafar on 2/9/21.
//

import SwiftUI

struct HeaderView: View {
    
    @State var movieSearch: String = ""
    var body: some View {
        
        
        VStack (alignment : .leading, spacing : 15){
            ZStack (alignment : .trailing){
                Rectangle()
                    .frame(height: 45, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                
                TextField("Search", text: $movieSearch)
                    .padding(.horizontal, 20)
                
                Image(systemName: "magnifyingglass")
                    .padding(.horizontal,20)
                    .foregroundColor(.mainColor)
                    .font(.system(size: 23, weight: .semibold))
            }

            Text("Now Playing")
                .font(.custom("AvenirNext-Bold", size: 30))
                .foregroundColor(.coolBlack)
        }

        

    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
