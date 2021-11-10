//
//  SliderView.swift
//  MoveSlider
//
//  Created by Олег Федоров on 08.11.2021.
//

import SwiftUI

struct SliderView: UIViewRepresentable {
    
    @Binding var sliderValue: Float
    var alphaComponent: CGFloat
    
    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 100
        
        slider.addTarget(
            context.coordinator,
            action: #selector(Coordinator.setSliderValue),
            for: .allTouchEvents
        )
        
        return slider
    }
    
    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.value = sliderValue
        uiView.thumbTintColor = .red.withAlphaComponent(alphaComponent)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(sliderValue: $sliderValue)
    }
}

extension SliderView {
    class Coordinator: NSObject {
        @Binding var sliderValue: Float
        
        init(sliderValue: Binding<Float>) {
            self._sliderValue = sliderValue
        }
        
        @objc func setSliderValue(_ sender: UISlider) {
            sliderValue = sender.value
        }
    }
}

struct SliderView_Previews: PreviewProvider {
    static var previews: some View {
        SliderView(
            sliderValue: .constant(50),
            alphaComponent: 0.5
        )
    }
}
