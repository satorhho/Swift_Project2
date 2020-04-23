//
//  ContentView.swift
//  Animations
//
//  Created by Lance Kent Briones on 4/21/20.
//  Copyright © 2020 Lance Kent Briones. All rights reserved.
//

import SwiftUI
struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View{
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}
extension AnyTransition{
    static var pivot: AnyTransition {
        .modifier(active: CornerRotateModifier(amount: -90, anchor: .topLeading), identity: CornerRotateModifier(amount: 0, anchor: .topLeading))
    }
}

struct ContentView: View {
    @State private var showButton: Bool = false
    var body: some View {
        Button(action: {
            withAnimation{
                self.showButton.toggle()
            }
        }){
            VStack{
                Text("Tap Me")
                
                if self.showButton {
                    Rectangle().fill(Color.red).frame(width: 200, height: 200)
                        .transition(.pivot)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
