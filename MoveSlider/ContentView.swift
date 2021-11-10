//
//  ContentView.swift
//  MoveSlider
//
//  Created by Олег Федоров on 08.11.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var targetValue = Int.random(in: 1...100)
    @State private var currentValue = Float.random(in: 1...100)
    
    @State private var alertIsPresented = false
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Подвиньте слайдер, как можно ближе к: \(targetValue)")
            
            HStack {
                Text("0")
                
                SliderView(
                    sliderValue: $currentValue,
                    alphaComponent: getAlpha()
                )
                    .onChange(of: currentValue) { newValue in
                        currentValue = newValue
                    }
                    .alert(
                        "Your score",
                        isPresented: $alertIsPresented,
                        actions: {}
                    ) {
                        Text("\(computeScore())")
                    }
                    
                Text("100")
            }
            
            Button("Проверь меня!") {
                showAlert()
            }
            
            Button("Начать заново") {
                updateValues()
            }
        }
        .padding()
    }
}

extension ContentView {
    private func computeScore() -> Int {
        let difference = abs(targetValue - lround(Double(currentValue)))
        return 100 - difference
    }
    
    private func getAlpha() -> CGFloat {
        CGFloat(Double(computeScore()) / 100.0)
    }

    private func showAlert() {
        alertIsPresented.toggle()
    }
    
    private func updateValues() {
        targetValue = Int.random(in: 1...100)
        withAnimation() {
            currentValue = Float.random(in: 1...100)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
