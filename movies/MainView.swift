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
    
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    let screenSize = UIScreen.main.bounds.width
    
    let movies = Bundle.main.decode([Movie].self, from: "movies.json")!
    @State var show : Bool = true
    @StateObject var page1: Page = .first()
    
    @State var selectedIndex : Int = 0
    @State var selectedMovie : Movie = Movie.example
    
    
    @Namespace var namespace
    
        
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "AvenirNext-Bold", size: 30)!]
    }
    var body: some View {
        
        
        
        if !show {
            ScrollView (/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false) {
                VStack (alignment: .leading){
                    Pager(page: self.page1, data: self.movies, id: \.id) { movie in
                        LargeMovieItem(item: movie)
                    }
                        .onPageChanged({ (newIndex) in
                            self.selectedIndex = newIndex
                        })
                        .sensitivity(.high)
                        .itemSpacing(20)
                        .horizontal()
                        .interactive(0.85)
                        .itemAspectRatio(0.77)
                        .alignment(.center)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 570, maxHeight: .infinity, alignment: .bottom)
                        .matchedGeometryEffect(id: "id\(selectedIndex)", in: namespace)
                        .onTapGesture {
                            withAnimation(.spring(response : 0.5,dampingFraction : 0.7)) {
                                self.show = true
                            }
                        }

                    Text("Premiers:")
                        .font(.title)
                        .bold()
                        .padding()

                    LazyVGrid(columns: columns, spacing:30) {
                        ForEach(movies, id: \.id) { item in
                            SmallMovieItem(item: item)
                        }
                    }
                }
            }
        } else {
            ScrollView {
                VStack {
                    Image(movies[selectedIndex].posterImage)
                        .resizable()
                        .frame(width: .infinity, height: 600, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .cornerRadius(30)
                        .matchedGeometryEffect(id: "id\(selectedIndex)", in: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Namespace@*/Namespace().wrappedValue/*@END_MENU_TOKEN@*/)
                        .onTapGesture {
                            self.show.toggle()
                        }
                }
            }
            .ignoresSafeArea()
        }
               
    }
    
    func getImageShadowColor () -> Color {
        let image = UIImage(named: self.selectedMovie.posterImage) ?? UIImage()
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
