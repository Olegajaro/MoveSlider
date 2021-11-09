//
//  SliderView.swift
//  MoveSlider
//
//  Created by Олег Федоров on 08.11.2021.
//

import SwiftUI

struct SliderView: UIViewRepresentable {
    
    @Binding var sliderValue: Float
    @Binding var alphaComponent: CGFloat
    
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
        Coordinator(sliderValue: $sliderValue, alpha: $alphaComponent)
    }
}

extension SliderView {
    class Coordinator: NSObject {
        @Binding var sliderValue: Float
        @Binding var alpha: CGFloat
        
        init(sliderValue: Binding<Float>, alpha: Binding<CGFloat>) {
            self._sliderValue = sliderValue
            self._alpha = alpha
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
            alphaComponent: .constant(0.5)
        )
    }
}
