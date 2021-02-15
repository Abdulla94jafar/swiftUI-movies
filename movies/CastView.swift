//
//  CastView.swift
//  movies
//
//  Created by Abdulla Jafar on 2/14/21.
//

import SwiftUI

struct CastView: View {
    let item : Movie
    var body: some View {
        ScrollView (.horizontal,showsIndicators: false){
            HStack (spacing : 15){
                ForEach(item.cast,id: \.id) { actor in
                    ZStack (alignment : .leading){
                        Rectangle()
                            .frame(width: 238, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.white)
                            .cornerRadius(15)
                        HStack (spacing: 20){
                            Image(actor.image)
                                .resizable()
                                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                                .frame(width: 70, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .cornerRadius(15)
                            VStack (alignment : .leading){
                                Text(actor.name)
                                    .font(.custom("AvenirNext-Bold", size: 17))
                                    .foregroundColor(.coolBlack)
                                    .lineLimit(1)
                                Text(actor.cherecterName)
                                    .font(.custom("AvenirNext-DemiBold", size: 14))
                                    .foregroundColor(.veryLightGray)
                                    .lineLimit(1)
                            }
                            .frame(width: 120, alignment: .leading)
                            
                        }
                        
                    }
   
                }
            }

        }
        
        
    }
}

struct CastView_Previews: PreviewProvider {
    static var previews: some View {
        CastView(item: Movie.example)
    }
}
