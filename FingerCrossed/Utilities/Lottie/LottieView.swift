//
//  LottieView.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 5/16/23.
//

import SwiftUI
import Lottie
 
struct LottieView: UIViewRepresentable {
    
    let lottieFile: String
     
    let animationView = LottieAnimationView()
    
    var loop: Bool = true
 
    func makeUIView(
        context: Context
    ) -> some UIView {
        let view = UIView(frame: .zero)
 
        animationView.animation = LottieAnimation.named(lottieFile)
        animationView.contentMode = .scaleAspectFit
        animationView.play()
 
        view.addSubview(animationView)
        if loop {
            animationView.loopMode = .loop
        } else {
            animationView.loopMode = .playOnce
        }
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        animationView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
 
        return view
    }
 
    func updateUIView(
        _ uiView: UIViewType,
        context: Context
    ) {}
}
