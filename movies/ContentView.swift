//
//  ContentView.swift
//  movies
//
//  Created by Abdulla Jafar on 1/23/21.
//

import Foundation
import SwiftUI
import SwiftUIPager

struct ContentView: View {
    
    
    let screenSize = UIScreen.main.bounds.width
    
    let movies = Bundle.main.decode([Movie].self, from: "movies.json")!
    @StateObject var page1: Page = .first()
    
        
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "AvenirNext-Bold", size: 30)!]
    }
    var body: some View {
        
        
        

        NavigationView {
            ZStack {
                Color(hex: "#EFF0FF").edgesIgnoringSafeArea(.all)
                ScrollView (/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false) {
                    VStack (alignment: .leading){
                        Pager(page: self.page1,
                              data: self.movies,
                              id: \.id) { movie in
                            LargeMovieItem(item: movie)
                        }
                            .sensitivity(.high)
                            .itemSpacing(20)
                            .horizontal()
                            .interactive(0.85)
                        .itemAspectRatio(0.77)
                            .alignment(.center)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 570, maxHeight: .infinity, alignment: .bottom)
                            
                        
                        
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
            }
            .onAppear(perform: {
                print(screenSize)
            })
            .navigationBarTitle("Now Playing")
            .navigationBarItems(trailing:
                Button(action: {
                    print("User icon pressed...")
                }) {
                    Image("ic-search")
                }
            )

            





        }
        
    }
    
    
    func getPagerItemAspectRatio() ->  CGFloat {
        let ratio : Double = Double(screenSize) * 0.0021
        return CGFloat(ratio)
    }
        

    

}

struct ContentViewreviews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
