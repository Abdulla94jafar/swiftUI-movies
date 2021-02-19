//
//  ContentView.swift
//  movies
//
//  Created by Abdulla Jafar on 1/23/21.
//

import Foundation
import SwiftUI
import SwiftUIPager

let items: [BarItem] = [
    BarItem(title: "Trending", icon: "star.fill", color: .purple),
    BarItem(title: "Trailers", icon: "film.fill", color: .pink),
    BarItem(title: "Tickets", icon: "ticket.fill", color: .orange),
    BarItem(title: "Saved", icon: "bookmark.fill", color: .blue)
]

struct MainView: View {
    
    let screenSize = UIScreen.main.bounds.width
    let movies = Bundle.main.decode([Movie].self, from: "movies.json")!
    
    @State var selectedTaps: Int = 0
    @State var show : Bool = false
    @StateObject var page1: Page = .first()
    @State var selectedMovie : Movie = Movie.example
        
    let columns = [
        GridItem(.flexible(minimum: 160), spacing: 16),
        GridItem(.flexible(minimum: 160), spacing: 16)
    ]

    var body: some View {
        ZStack (alignment : .bottom){
            Color(hex: "#EDF1F3")
                .ignoresSafeArea()
            ScrollView (.vertical, showsIndicators: false) {
                if !show {
                    VStack (alignment: .leading, spacing : 0) {
                        Spacer(minLength: 40)
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
                        .onTapGesture {
                            withAnimation(.spring(response : 0.4,dampingFraction : 0.85)) {
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
                        
                        Spacer(minLength: 150)
                        
                    }
                } else {
                    VStack (alignment : .leading , spacing : 30){
                        
                        // MARK: - DETAILS IMAGE VIEW
                        ZStack {
                            Image(selectedMovie.posterImage)
                                .resizable()
                                .frame(height: 650, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .cornerRadius(20)
                                .shadow(color: getImageShadowColor(imageName: selectedMovie.posterImage), radius: 20, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 15)
                                .onTapGesture {
                            }
                            VStack{
                                HStack {
                                    Button(action: {
                                        withAnimation(.easeIn(duration :0.1 )) {
                                            self.show.toggle()
                                        }
                                    }) {
                                        Image("ic-close-button")
                                    }
                                    .frame(width: 32, height: 32, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .offset(x: 20, y: 50)
                                    Spacer()
                                }
                                Spacer()
                                HStack {
                                    Spacer()
                                    Button(action: {
                                        print("Edit button was tapped")
                                    }) {
                                        Image("ic-play-button")
                                    }
                                    .frame(width: 60, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .offset(x: -20, y: -20)
                                }
                            }
                        }
                        .transition(.opacity)
                        
            
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
                        .transition(.opacity)
                        
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
                        Spacer(minLength: 80)
                    }
                    .transition(.scale )
                }
                
                
            }
            .ignoresSafeArea()
            
            TabBar(selectedIndex: $selectedTaps, items: items)
                .offset(x: 0, y: 35)
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
