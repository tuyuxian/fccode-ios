//
//  EditableImage.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 6/18/23.
//

import SwiftUI

struct EditableImage: View {

    var image: UIImage
    
    @Binding var cropRatio: LifePhotoEditSheet.CropRatio
    
    @Binding var currentOffset: CGSize
    
    @Binding var currentScale: CGFloat
    
    /// Offset state
    @State var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero
    
    /// Scale state
    @State var scale: CGFloat = 1
    @State private var lastScale: CGFloat = 1.0
    private let minScale: CGFloat = 1.0
    private let maxScale: CGFloat = 2.0
    
    @GestureState private var isInteracting: Bool = false
    
    var body: some View {
        imageView()
            .cornerRadius(6)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    @ViewBuilder
    private func imageView() -> some View {
        
        let cropSize = cropRatio.size()
        
        GeometryReader {
            let size = $0.size
            
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .overlay {
                    GeometryReader { geometry in
                        let rect = geometry.frame(in: .named("CROPVIEW"))
                        
                        Color.clear
                            .onChange(of: isInteracting) { newValue in
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    if rect.minX > 0 {
                                        if (offset.width - rect.minX) > size.width/2 * (scale-1) {
                                            offset.width = size.width/2 * (scale-1)
                                        } else {
                                            offset.width = (offset.width - rect.minX)
                                        }
                                    }
                                    
                                    if rect.minY > 0 {
//                                                if (offset.height - rect.minY) > size.height/2 * (scale-1) {
//                                                    offset.height = size.height/2  * (scale - 1) + (((size.width * 4 / 3) - (size.height))/2) * scale
//                                                } else {
//                                                    offset.height = (offset.height - rect.minY)
//                                                }
                                        offset.height = (offset.height - rect.minY)
                                    }
                                    
                                    if rect.maxX < size.width {
                                        if (rect.minX - offset.width) > size.width/2 * -(scale-1) {
                                            offset.width = size.width/2 * -(scale-1)
                                        } else {
                                            offset.width = (rect.minX - offset.width)
                                        }
                                    }
                                    
                                    if rect.maxY < size.height {
//                                                if (rect.minY - offset.height) > size.height/2 * -(scale-1) {
//                                                    offset.height = size.height/2 * -(scale-1)
//                                                } else {
//                                                    offset.height = (rect.minY - offset.height)
//                                                }
                                        offset.height = (rect.minY - offset.height)
                                    }
                                }
                                
                                if !newValue {
                                    lastOffset = offset
                                }
                            }
                    }
                }
                .frame(width: size.width, height: size.height)
        }
        .scaleEffect(scale)
        .offset(offset)
        .overlay { grids(size: cropSize) }
        .coordinateSpace(name: "CROPVIEW")
        .gesture(drag)
        .gesture(magnification)
        .frame(width: cropSize.width, height: cropSize.height)
        .onChange(of: cropSize) { _ in
            scale = 1.0
            offset = .zero
        }
    }
    
    var drag: some Gesture {
        DragGesture()
            .updating($isInteracting, body: { _, out, _ in
                out = true
            })
            .onChanged { value in
                let translation = value.translation
                offset = CGSize(
                    width: translation.width + lastOffset.width,
                    height: translation.height + lastOffset.height
                )
                currentOffset = offset
            }
    }
    
    var magnification: some Gesture {
        MagnificationGesture()
            .updating($isInteracting, body: { _, out, _ in
                out = true
            })
            .onChanged { val in
                adjustScale(from: val)
            }
            .onEnded { _ in
                withAnimation(.easeInOut(duration: 0.2)) {
                    validateScaleLimits()
                    currentScale = scale
                    lastScale = 1.0
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
            haptics(.light)
        }
        return max(scale, minScale)
    }
    
    private func getMaximumScaleAllowed() -> CGFloat {
        if scale > maxScale {
            haptics(.light)
        }
        return min(scale, maxScale)
    }
    
    private func validateScaleLimits() {
        scale = getMinimumScaleAllowed()
            scale = getMaximumScaleAllowed()
        }
        
    @ViewBuilder
    private func grids(
        size: CGSize
    ) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6)
                .strokeBorder(Color.yellow100, lineWidth: 1)
            
            Path { path in
                path.move(
                    to: CGPoint(
                        x: size.width / 3,
                        y: 0
                    )
                )
                path.addLine(
                    to: CGPoint(
                        x: size.width / 3,
                        y: size.height
                    )
                )
            }
            .stroke(Color.surface2, lineWidth: 1)
            
            Path { path in
                path.move(
                    to: CGPoint(
                        x: size.width * 2 / 3,
                        y: 0
                    )
                )
                path.addLine(
                    to: CGPoint(
                        x: size.width * 2 / 3,
                        y: size.height
                    )
                )
            }
            .stroke(Color.surface2, lineWidth: 1)
            
            Path { path in
                path.move(
                    to: CGPoint(
                        x: 0,
                        y: size.height / 3
                    )
                )
                path.addLine(
                    to: CGPoint(
                        x: size.width,
                        y: size.height / 3
                    )
                )
            }
            .stroke(Color.surface2, lineWidth: 1)
            
            Path { path in
                path.move(
                    to: CGPoint(
                        x: 0,
                        y: size.height * 2 / 3
                    )
                )
                path.addLine(
                    to: CGPoint(
                        x: size.width,
                        y: size.height * 2 / 3
                    )
                )
            }
            .stroke(Color.surface2, lineWidth: 1)
        }
    }
}
