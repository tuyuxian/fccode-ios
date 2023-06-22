//
//  EditableAsyncImage.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 6/18/23.
//

import SwiftUI

extension LifePhotoEditSheet {

    struct EditableAsyncImage: View {
        
        @ObservedObject var basicInfoVM: BasicInfoViewModel
        
        @ObservedObject var vm: LifePhotoEditSheetViewModel
        
        var url: String
        
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
                AsyncImage(
                    url: URL(string: url),
                    transaction: Transaction(animation: .easeInOut)
                ) { phase in
                    switch phase {
                    case .empty:
                        Shimmer(
                            size: CGSize(
                                width: UIScreen.main.bounds.size.width - 48,
                                height: 342
                            )
                        )
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(
                                width: geometry.size.width,
                                height: vm.imageHeight(width: geometry.size.width)
                            )
                            .scaleEffect(basicInfoVM.selectedLifePhoto?.scale ?? 1)
                            .cornerRadius(6)
                            .gesture(magnification)
                            .background(
                                RoundedRectangle(cornerRadius: 6)
                                    .strokeBorder(Color.yellow100, lineWidth: 1)
                            )
//                            .overlay(
//                                BackgroundGrid(geometry: geometry)
//                            )
    //                        .onChange(of: uiImage, perform: { newImage in
    //                            newUIImage = UIImage(
    //                                data: newImage.jpegData(compressionQuality: 0.95)!)!
    //                        })
                        
                    case .failure:
                        Shimmer(
                            size: CGSize(
                                width: UIScreen.main.bounds.size.width - 48,
                                height: 342
                            )
                        )
                    @unknown default:
                        EmptyView()
                    }
                }
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
