//
//  EditableImage.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 6/18/23.
//

import SwiftUI

extension LifePhotoEditSheet {
    // TODO(Lawrence): add drag and fix magnification gesture
    struct EditableImage: View {
        
        @ObservedObject var basicInfoVM: BasicInfoViewModel
        
        @ObservedObject var vm: LifePhotoEditSheetViewModel
        
        @State var scale = 1.0
        
        @State private var lastScale = 1.0
        
        private let minScale = 1.0
        
        private let maxScale = 2.0
        
        let haptic = UIImpactFeedbackGenerator(style: .light)
        
        var magnification: some Gesture {
            MagnificationGesture()
                .onChanged { val in
                    adjustScale(from: val)
                }
                .onEnded { _ in
                    withAnimation(.spring()) {
                        validateScaleLimits()
                        lastScale = 1.0
                    }
                }
        }
        
        var body: some View {
            GeometryReader { geometry in
                Image(uiImage: basicInfoVM.selectedImage!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(
                        width: vm.imageWidth(),
                        height: vm.imageHeight()
                    )
                    .scaleEffect(basicInfoVM.selectedLifePhoto?.scale ?? 1)
                    .cornerRadius(6)
                    .gesture(magnification)
                    .overlay(
                        BackgroundGrid(geometry: geometry)
                    )
            }
        }
        
        private func adjustScale(
            from val: MagnificationGesture.Value
        ) {
            let delta = val / lastScale
            scale *= delta
            lastScale = val
        }
        
        private func getMinimumScaleAllowed() -> CGFloat {
            if scale < minScale {
                haptic.impactOccurred()
            }
            return max(scale, minScale)
        }
        
        private func getMaximumScaleAllowed() -> CGFloat {
            if scale > maxScale {
                haptic.impactOccurred()
            }
            return min(scale, maxScale)
        }
        
        private func validateScaleLimits() {
            scale = getMinimumScaleAllowed()
            scale = getMaximumScaleAllowed()
        }
    }
    
}
