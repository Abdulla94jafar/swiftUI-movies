//
//  DetailsView.swift
//  movies
//
//  Created by Abdulla Jafar on 2/19/21.
//

import SwiftUI

struct DetailsView: View {
    
    var items = ["Details", "Showtimes"]
    
    @Binding var show : Bool
    @State var selection : Int = 0
    @Binding var selectedMovie : Movie
    
    var body: some View {
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
                            withAnimation(.easeIn(duration :0.25)) {
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

            
            SegmentedPicker(items: items, selection: $selection)
                .padding(.horizontal, 20)
                .onTapGesture {
                    selection = selection == 0 ? 1 : 0
                }
            
            
            
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
    }
    
    
    func getImageShadowColor (imageName : String) -> Color {
        let image = UIImage(named: imageName) ?? UIImage()
        let color = image.averageColor ?? .clear
        return Color(color).opacity(0.7)
    }
    
    func getFormattedRating (_ rating : Double ) -> String {
        let f = NumberFormatter()
        f.numberStyle = .decimal
        return f.string(from: NSNumber(value: rating)) ?? ""
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(show: .constant(false), selection: 0, selectedMovie: .constant(Movie.example))
    }
}
