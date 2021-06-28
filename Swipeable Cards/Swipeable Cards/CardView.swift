//
//  CardView.swift
//  Swipeable Cards
//
//  Created by Oleg Frolov on 27.06.2021.
//

import SwiftUI

struct CardView: View {
    
    @State private var translation: CGSize = .zero
    var day: String = ""
    
    var body: some View {
        GeometryReader {
            geometry in
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                Image("Love")
                    .frame(width: 96, height: 96)
                Text(day)
            }
            .frame(width: geometry.size.width, height: geometry.size.width * 1.33)
            .background(Color.gray)
            .cornerRadius(24)
            .shadow(radius: 10)
            .animation(.interactiveSpring(response: 0.5, blendDuration: 0.3))
            .offset(x: self.translation.width, y: self.translation.height)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                self.translation = gesture.translation
                    }
                    .onEnded {gesture in
                        self.translation = .zero
                    }
            )
            
        }
        
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        
        CardView()
    }
}
