//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Lance Kent Briones on 4/10/20.
//  Copyright © 2020 Lance Kent Briones. All rights reserved.
//

import SwiftUI
struct PointStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .shadow(color: .black ,radius: 5)
    }
}
struct SpinButton: ViewModifier {
    var rval: Double
    func body(content: Content) -> some View {
        content
            .rotation3DEffect(.degrees(self.rval), axis: (x:0, y: 1, z: 0))
    }
}
extension View {
    func spin_button(rval: Double) -> some View{
        self.modifier(SpinButton(rval: rval))
    }
    func point_style() -> some View {
        self.modifier(PointStyle())
    }
}
struct ContentView: View {
    @State private var countries = ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"].shuffled()
    @State private var rand = Int.random(in: 0...2)
    @State private var alert_condition: Bool = false
    @State private var score_message: String = ""
    @State private var score: Int = 0
    
    @State private var rotate: Bool = false
    @State private var rotate_value: Double = 0.0
    
   // @State private var opacity: Double = 1
    
    var body: some View {
       return ZStack{
            AngularGradient(gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, Color(red: 0.294, green: 0, blue: 51), .red]), center: .center)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 50){
                VStack{
                    Text("Tap the country of")
                        .foregroundColor(.black)
                    Text("\(self.countries[rand])")
                        .foregroundColor(.black)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0 ..< 3) { i in
                    Button(action: {
                        self.tapped(n: i, country: self.countries[i])
                        if self.rotate {
                            withAnimation{
                                self.rotate_value += 360
                            }
                            
                        }
                    }){
                        Image("\(self.countries[i])")
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 2))
                            .shadow(color: .black, radius: 2)
                    }
                    .spin_button(rval: self.rotate_value)
                }
                
                Text("Your score is: \(self.score)")
                .point_style()
                //Spacer()
            }
        }
        .alert(isPresented: $alert_condition){
            Alert(title: Text("Wrong!"), message: Text(self.score_message + " Your score is \(self.score)."), dismissButton: .default(Text("Reset")){
                self.reset()
            })
        }
        
    }
    func reset() -> Void {
        self.score = 0
        self.ask_question()
    }
    func ask_question() -> Void {
        self.countries.shuffle()
        self.rand = Int.random(in: 0...2)
        self.alert_condition = false
    }
    func tapped(n number: Int, country: String) -> Void {
        if number == self.rand{
            self.score += 1
            self.ask_question()
            self.rotate = true
        }
        else {
            self.score_message = "You picked \(country)."
            alert_condition = true
            self.rotate = false
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
