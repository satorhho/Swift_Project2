//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Lance Kent Briones on 4/10/20.
//  Copyright © 2020 Lance Kent Briones. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"].shuffled()
    @State private var rand = Int.random(in: 0...2)
    @State private var alert_condition: Bool = false
    @State private var score_title: String = ""
    @State private var score: Int = 0
    
    var body: some View {
        ZStack{
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
                    }) {
                        Image("\(self.countries[i])")
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 2))
                            .shadow(color: .black, radius: 2)
                    }
                }
                //Spacer()
            }
        }
        .alert(isPresented: $alert_condition){
            Alert(title: Text("\(self.score_title)"), message: Text("Your score is \(self.score)"), dismissButton: .default(Text("Continue")){
                self.ask_question()
            })
        }
        
    }
    func ask_question() -> Void {
        self.countries.shuffle()
        self.rand = Int.random(in: 0...2)
        self.alert_condition = false
    }
    func tapped(n number: Int, country: String) -> Void {
        if number == self.rand{
            self.score_title = "You're Right!"
            self.score += 1
        }
        else {
            self.score_title = "Oops! You picked \(country)."
        }
        
        alert_condition = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
