//
//  CardView.swift
//  Swipeable Cards
//
//  Created by Oleg Frolov on 27.06.2021.
//

import SwiftUI

struct CardView: View
{
    
    @State private var translation: CGSize = .zero
    var day: String = ""
    
    var body: some View
    {
        GeometryReader
        {
            geometry in
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            {
                Image("Love")
                    .frame(width: 96, height: 96)
                Text(day)
            }
            .frame(width: geometry.size.width, height: geometry.size.width * 1.33)
            .background(Color.white)
            .cornerRadius(24)
            .shadow(color: Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.05), radius: 16, x: 0, y: 16)
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
