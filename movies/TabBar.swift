//
//  TabBar.swift
//  movies
//
//  Created by Abdulla Jafar on 2/18/21.
//

import SwiftUI


public  struct BarItem  {
    let title : String
    let icon : String
    let color : Color
}


public struct BarItemView : View  {
    
    public let isSelected: Bool
    public let item: BarItem
    
    public var body: some View {
        HStack {
            Image(systemName : item.icon)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor( isSelected ? .mainColor : .veryLightGray)
            if isSelected {
                Text(item.title)
                    .foregroundColor(.mainColor)
                    .font(.custom("AvenirNext-Bold", size: 17))
            }
        }
        .padding(EdgeInsets(top: 5, leading: 18, bottom: 0, trailing: 18))


    }
    

}

struct TabBar: View {
    
    let screenWidth = UIScreen.main.bounds.width
    
    @Binding public var selectedIndex: Int
    let items : [BarItem]
    
    
    func itemView(at index: Int) -> some View {
        Button(action: {
            withAnimation { self.selectedIndex = index }
        }) {
            BarItemView(isSelected: index == selectedIndex, item: items[index])
        }
    }
    
    var body: some View {
        HStack {
            ForEach (0..<items.count) { index in
                self.itemView(at: index)
                if index != self.items.count-1 {
                     Spacer()
                }
            }
        }
        .padding()
        .frame(width: screenWidth, height: 90,alignment: .top)
        .animation(.easeInOut)
        .background(Color.white)
        .cornerRadius(20, corners: .topLeft)
        .cornerRadius(20, corners: .topRight)
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: -2)
        .edgesIgnoringSafeArea(.bottom)
        
    }
}


struct TabBar_Previews : PreviewProvider {
    static var previews: some View {
        TabBar(selectedIndex: .constant(0), items: [
            BarItem(title: "Trending", icon: "star.fill", color: .purple),
            BarItem(title: "Trailers", icon: "film.fill", color: .pink),
            BarItem(title: "Tickets", icon: "ticket.fill", color: .orange),
            BarItem(title: "Saved", icon: "bookmark.fill", color: .blue)
        ])
    }
}

