//
//  DetailsView.swift
//  movies
//
//  Created by Abdulla Jafar on 2/1/21.
//

import SwiftUI

struct DetailsView: View {
    
    let item : Movie
    var body: some View {
        ZStack (alignment : .trailing){
            Color(hex: "#EFF0FF")
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                
                VStack (alignment : .leading){
                    ZStack (alignment : .topTrailing){
                        Image(item.posterImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxHeight: 650, alignment: .top)
                            .clipped()
                            .cornerRadius(30)
                            .shadow(color: getImageShadowColor(), radius: 25, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 20)
                        
                        VStack (alignment : .center){
                            Button(action: {
                                print("Close")
                            }) {
                                
                                Image(systemName: "xmark.circle.fill")
                                    .font(.system(size: 25))
                                    .foregroundColor(.white)
                            }
                
                            Spacer()
                            Button(action: {
                                print("Close")
                            }) {
                                
                                Image(systemName: "play.circle.fill")
                                    .font(.system(size: 50))
                                    .foregroundColor(.white)
                                    .opacity(0.5)
                            }
                        }
                        .padding(EdgeInsets(top: 40, leading: 20, bottom: 20, trailing: 20))
                    }
                }
                

                
                    
    

            }
            .edgesIgnoringSafeArea(.all)
            
            
            

        }
    }
    
    
    
    
    func getImageShadowColor () -> Color {
        let image = UIImage(named: self.item.posterImage) ?? UIImage()
        let color = image.averageColor ?? .clear
        return Color(color).opacity(0.7)
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(item: Movie.example)
    }
}
