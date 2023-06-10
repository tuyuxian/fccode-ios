//
//  EditableImage.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 6/1/23.
//

import SwiftUI

struct EditableImage: View {
    @StateObject var hapticHelper: HapticsHelper = HapticsHelper()

//    @State var image: UIImage
//
//    @State var lifePhoto: LifePhoto?
//
//    @State var selectedTag: Int
    
    private func imageHeight(
        tag: Int
    ) -> (CGFloat) {
        switch tag {
        case 0:
            return (UIScreen.main.bounds.width - 48)/16 * 9
        case 1:
            return UIScreen.main.bounds.width - 48
        case 2:
            return (UIScreen.main.bounds.width - 48)/4 * 3
        case 3:
            return UIScreen.main.bounds.width - 48
        default:
            return UIScreen.main.bounds.width - 48
        }
    }
    
    private func imageWidth(
        tag: Int
    ) -> (CGFloat) {
        switch tag {
        case 0:
            return UIScreen.main.bounds.width - 48
        case 1:
            return (UIScreen.main.bounds.width - 48)/16 * 9
        case 2:
            return UIScreen.main.bounds.width - 48
        case 3:
            return (UIScreen.main.bounds.width - 48)/4 * 3
        default:
            return (UIScreen.main.bounds.width - 48)/16 * 9
        }
    }
    
    @State var scale = 1.0
    @State private var lastScale = 1.0
    private let minScale = 1.0
    private let maxScale = 2.0
    @State var lastOffset: CGSize = .zero
    @State var offset: CGSize = .zero
    
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
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { val in
                offset = CGSize(
                    width: val.translation.width + lastOffset.width,
                    height: val.translation.height + lastOffset.height
                )
            }
            .onEnded { val in
                let boundedOffset = boundingOffset(for: CGSize(
                    width: val.translation.width,
                    height: val.translation.height
                ))
                withAnimation {
                    offset = boundedOffset
                    lastOffset = offset
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
        
    func getMinimumScaleAllowed() -> CGFloat {
        if scale < minScale {
            hapticHelper.impactFeedback.impactOccurred(intensity: 0.5)
        }
        return max(scale, minScale)
    }
    
    func getMaximumScaleAllowed() -> CGFloat {
        if scale > maxScale {
            hapticHelper.impactFeedback.impactOccurred(intensity: 0.5)
        }
        return min(scale, maxScale)
    }
    
    func validateScaleLimits() {
        scale = getMinimumScaleAllowed()
        scale = getMaximumScaleAllowed()
    }
    let boxSize: CGSize = CGSize(width: 342, height: 342)
    
    func boundingOffset(for offset: CGSize) -> CGSize {
           var boundedOffset = offset

        if offset.width > boxSize.width {
            boundedOffset.width = boxSize.width / 4
           } else if offset.width < -(boxSize.width / 4) {
               boundedOffset.width = -(boxSize.width / 4)
           }

           if offset.height > boxSize.height / 4 {
               boundedOffset.height = boxSize.height / 4
           } else if offset.height < -(boxSize.height / 4) {
               boundedOffset.height = -(boxSize.height / 4)
           }

           return boundedOffset
       }
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea(.all)
            VStack {
                VStack {}
                .frame(width: 342, height: 254)
                .background(
                    AsyncImage(
                        url: URL(string: "https://i.pravatar.cc/150?img=9"),
                        transaction: Transaction(animation: .easeInOut)
                    ) { phase in
                        switch phase {
                        case .empty:
                            EmptyView()
                        case .success(let image):
                            GeometryReader { geometry in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .scaleEffect(scale)
                                    .offset(x: offset.width, y: offset.height)
                                    .gesture(drag)
                                    .gesture(magnification)
                                    .overlay(
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 6)
                                                .strokeBorder(Color.yellow100, lineWidth: 1)
                                            
                                            Path { path in
                                                path.move(
                                                    to: CGPoint(
                                                        x: geometry.size.width / 3,
                                                        y: 0
                                                    )
                                                )
                                                path.addLine(
                                                    to: CGPoint(
                                                        x: geometry.size.width / 3,
                                                        y: geometry.size.height
                                                    )
                                                )
                                            }
                                            .stroke(Color.surface2, lineWidth: 1)
                                            
                                            Path { path in
                                                path.move(
                                                    to: CGPoint(
                                                        x: geometry.size.width * 2 / 3,
                                                        y: 0
                                                    )
                                                )
                                                path.addLine(
                                                    to: CGPoint(
                                                        x: geometry.size.width * 2 / 3,
                                                        y: geometry.size.height
                                                    )
                                                )
                                            }
                                            .stroke(Color.surface2, lineWidth: 1)
                                            
                                            Path { path in
                                                path.move(
                                                    to: CGPoint(
                                                        x: 0,
                                                        y: geometry.size.height / 3
                                                    )
                                                )
                                                path.addLine(
                                                    to: CGPoint(
                                                        x: geometry.size.width,
                                                        y: geometry.size.height / 3
                                                    )
                                                )
                                            }
                                            .stroke(Color.surface2, lineWidth: 1)
                                            
                                            Path { path in
                                                path.move(
                                                    to: CGPoint(
                                                        x: 0,
                                                        y: geometry.size.height * 2 / 3
                                                    )
                                                )
                                                path.addLine(
                                                    to: CGPoint(
                                                        x: geometry.size.width,
                                                        y: geometry.size.height * 2 / 3
                                                    )
                                                )
                                            }
                                            .stroke(Color.surface2, lineWidth: 1)
                                        }
                                    )
                            }
                            
                        case .failure:
                            EmptyView()
                        @unknown default:
                            EmptyView()
                        }
                    }
                    //        GeometryReader { geometry  in
                    //            Image(uiImage: image)
                    //                .resizable()
                    //                .aspectRatio(contentMode: .fill)
                    //                .frame(
                    //                    width: imageWidth(tag: selectedTag),
                    //                    height: imageHeight(tag: selectedTag)
                    //                )
                    //                .scaleEffect(lifePhoto.scale + currentScale)
                    //                .offset(lifePhoto.offset + currentOffset)
                    //                .cornerRadius(6)
                    //                .gesture(
                    //                    DragGesture()
                    //                        .onChanged { gesture in
                    //                            currentOffset = gesture.translation
                    //                        }
                    //                        .onEnded { _ in
                    //                            if lifePhoto.offset.width < geometry.size.width {
                    //                                lifePhoto.offset = CGSize(
                    //                                    width: lifePhoto.offset.width + self.currentOffset.width,
                    //                                    height: lifePhoto.offset.height + self.currentOffset.height
                    //                                )
                    //                                currentOffset = .zero
                    //                            } else {
                    //                                lifePhoto.offset = .zero
                    //                            }
                    //                        }
                    //                )
                    //                .gesture(
                    //                    MagnificationGesture().onChanged({ val in
                    //                        lifePhoto.scale = val
                    //                    }).onEnded({ val in
                    //                        lifePhoto.scale = val < 1 ? 1 : val
                    //                    })
                    //                )
                    //
                    //        }
                )
            }
            .background(.red)
        }
    }
}

struct EditableImage_Previews: PreviewProvider {
    static var previews: some View {
        EditableImage()
    }
}
