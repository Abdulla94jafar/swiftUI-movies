//
//  ContentView.swift
//  movies
//
//  Created by Abdulla Jafar on 1/23/21.
//

import Foundation
import SwiftUI
import SwiftUIPager

struct MainView: View {
    
    let screenSize = UIScreen.main.bounds.width
    let movies = Bundle.main.decode([Movie].self, from: "movies.json")!
    @State var show : Bool = true
    @StateObject var page1: Page = .first()
    
    @State var selectedIndex : Int = 0
    @State var selectedMovie : Movie = Movie.example
    
    
    @Namespace var namespace
    
        
    let columns = [
        GridItem(.flexible(minimum: 160), spacing: 16),
        GridItem(.flexible(minimum: 160), spacing: 16)
    ]


    var body: some View {
        ZStack {
            Color(hex: "#EDF1F3")
                .ignoresSafeArea()
                .overlay(Group {
                    if !show {
                        ScrollView (/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false) {
                            VStack (alignment: .leading, spacing : 0) {
                                HeaderView()
                                    .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
                                Pager(page: self.page1, data: self.movies, id: \.id) { movie in
                                    LargeMovieItem(item: movie)
                                }
                                .onPageChanged({ (newIndex) in
                                    self.selectedMovie = movies[newIndex]
                                })
                                .itemSpacing(15)
                                .horizontal()
                                .interactive(0.8)
                                .itemAspectRatio(0.77)
                                .alignment(.center)
                                .pageOffset(0.1)
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 500, maxHeight: .infinity, alignment: .center)
                                .matchedGeometryEffect(id: "\(selectedMovie.id)", in: namespace)
                                .onTapGesture {
                                    withAnimation(.spring(response : 0.5,dampingFraction : 0.7)) {
                                        self.show.toggle()
                                    }
                                }
                                
                                LargeItemDetailsView(item: selectedMovie)
                                    .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 0))
                                    .offset(x: 0, y: -10)

                                
                                Text("Premiers:")
                                    .foregroundColor(.coolBlack)
                                    .font(.custom("AvenirNext-Bold", size: 25))
                                    .padding()
                                LazyVGrid(columns: columns, spacing:30) {
                                    ForEach(movies, id: \.id) { item in
                                        SmallMovieItem(item: item)
                                    }
                                }.padding(.horizontal,20)
                            }
                        }
                    } else {
                        ScrollView (/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false) {
                            VStack (alignment : .leading , spacing : 30){
                                // MARK: - DETAILS IMAGE VIEW
                                Image(selectedMovie.posterImage)
                                    .resizable()
                                    .frame(height: 650, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .cornerRadius(20)
                                    .matchedGeometryEffect(id: "id\(selectedIndex)", in: namespace)
                                    .shadow(color: getImageShadowColor(imageName: selectedMovie.posterImage), radius: 20, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 15)
                                    .onTapGesture {
                                        withAnimation(.spring(response : 0.5,dampingFraction : 0.7)) {
                                            self.show.toggle()
                                        }
                                    }
                                
                    
                                // MARK: - DETAILS VIEW TITLE
                                VStack (alignment : .leading){
                                    HStack {
                                        Image("ic-imdb-badge")
                                            .frame(width: 40, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                        Text(getFormattedRating(selectedMovie.rating))
                                            
                                            .font(.custom("AvenirNext-DemiBold", size: 14))
                                            .foregroundColor(.veryLightGray)
                                    }
                                    Text(selectedMovie.name)
                                        .font(.custom("AvenirNext-Bold", size: 20))
                                        .foregroundColor(.coolBlack)
                                    Text(selectedMovie.genre)
                                        .font(.custom("AvenirNext-DemiBold", size: 17))
                                        .foregroundColor(.veryLightGray)
                                }.padding(.horizontal, 20)
                                
                                
                                // MARK: - STORY VIEW TITLE
                                VStack (alignment : .leading){
                                    Text("Story")
                                        .foregroundColor(.coolBlack)
                                        .font(.custom("AvenirNext-Bold", size: 25))
                                    Text(selectedMovie.story)
                                        .font(.custom("AvenirNext-DemiBold", size: 17))
                                        .foregroundColor(.veryLightGray)
                                }.padding(.horizontal, 20)
                                
                                // MARK: - CAST VIEWS
                                VStack (alignment : .leading, spacing : 10) {
                                    HStack {
                                        Text("Cast")
                                            .foregroundColor(.coolBlack)
                                            .font(.custom("AvenirNext-Bold", size: 25))
                                        Spacer()
                                        HStack (spacing : 5){
                                            Text("Full Cast")
                                                .foregroundColor(.mainColor)
                                                .font(.custom("AvenirNext-DemiBold", size: 13))
                                            Image(systemName: "chevron.forward")
                                                .foregroundColor(.mainColor)
                                                .font(.custom("AvenirNext-DemiBold", size: 10))
                                        }
                                    }
                                    CastView(item: selectedMovie)
                                }
                                .padding(.horizontal, 20)
                                
                                // MARK: - GALLERY VIEWS
                                VStack (alignment : .leading, spacing : 10) {
                                    HStack (alignment : .center){
                                        Text("Photos")
                                            .foregroundColor(.coolBlack)
                                            .font(.custom("AvenirNext-Bold", size: 25))
                                        Spacer()
                                        HStack (spacing : 5){
                                            Text("More Photos")
                                                .foregroundColor(.mainColor)
                                                .font(.custom("AvenirNext-DemiBold", size: 13))
                                            Image(systemName: "chevron.forward")
                                                .foregroundColor(.mainColor)
                                                .font(.custom("AvenirNext-DemiBold", size: 10))
                                        }
                                    }
                                    MovieGalleryView(item: selectedMovie)
                                }
                                .padding(.horizontal, 20)
                                 
                                
                                Spacer(minLength: 20)
                            }
                        }
                        .overlay(
                        )
                        .ignoresSafeArea()
                    }
                })
            
            
        }
        
               
    }
    
    func getImageShadowColor (imageName : String) -> Color {
        let image = UIImage(named: imageName) ?? UIImage()
        let color = image.averageColor ?? .clear
        return Color(color).opacity(0.7)
    }
    
    func getPagerItemAspectRatio() ->  CGFloat {
        let ratio : Double = Double(screenSize) * 0.0021
        return CGFloat(ratio)
    }
    
    func getFormattedRating (_ rating : Double ) -> String {
        let f = NumberFormatter()
        f.numberStyle = .decimal
        return f.string(from: NSNumber(value: rating)) ?? ""
    }
        

    
    
    

}

struct ContentViewreviews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
