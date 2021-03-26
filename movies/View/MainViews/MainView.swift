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
                    DetailsView(show: $show, selection: 0, selectedMovie: $selectedMovie)
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
    

        

    
    
    

}

struct ContentViewreviews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
