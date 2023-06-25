//
//  EditableImage.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 6/18/23.
//

import SwiftUI

extension LifePhotoEditSheet {
    struct EditableImage: View {
        
        @ObservedObject var basicInfoVM: BasicInfoViewModel
        @ObservedObject var vm: LifePhotoEditSheetViewModel
        
        @State private var scale: CGFloat = 1
        @State private var lastScale: CGFloat = 0
        @State private var offset: CGSize = .zero
        @State private var lastStoredOffset: CGSize = .zero
        @GestureState private var isInteracting: Bool = false
        
        var body: some View {
            imageView()
                .cornerRadius(6)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        
        @ViewBuilder
        func imageView() -> some View {
            let crop = Crop.tagToType(tag: vm.selectedTag)
            let cropSize = crop.size()
            GeometryReader {
                let size = $0.size
                
                if let image = basicInfoVM.selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .overlay(content: {
                            GeometryReader { geometry in
                                let rect = geometry.frame(in: .named("CROPVIEW"))
                                
                                Color.clear
                                    .onChange(of: isInteracting) { newValue in
                                        
                                        withAnimation(.easeInOut(duration: 0.2)) {
                                            if rect.minX > 0 {
                                                offset.width = (offset.width - rect.minX)
                                                haptics(.light)
                                            }
                                            
                                            if rect.minY > 0 {
                                                offset.height = (offset.height - rect.minY)
                                                haptics(.light)
                                            }
                                            
                                            if rect.maxX < size.width {
                                                offset.width = (rect.minX - offset.width)
                                                haptics(.light)
                                            }
                                            
                                            if rect.maxY < size.height {
                                                offset.height = (rect.minY - offset.height)
                                                haptics(.light)
                                            }
                                        }
                                        
                                        if !newValue {
                                            lastStoredOffset = offset
                                        }
                                    }
                            }
                        })
                        .frame(size)
                        
                }
            }
            .scaleEffect(scale)
            .offset(offset)
            .overlay(content: {
                grids(size: cropSize)
            })
            .coordinateSpace(name: "CROPVIEW")
            .gesture(
                DragGesture()
                    .updating($isInteracting, body: { _, out, _ in
                        out = true
                    })
                    .onChanged({ value in
                        let translation = value.translation
                        offset = CGSize(
                            width: translation.width + lastStoredOffset.width,
                            height: translation.height + lastStoredOffset.height
                        )
                        vm.currentOffset = offset
                    })
            )
            .gesture(
                MagnificationGesture()
                    .updating($isInteracting, body: { _, out, _ in
                        out = true
                    })
                    .onChanged({ value in
                        let updatedScale = value + lastScale
                        scale = (updatedScale < 1 ? 1 : updatedScale)
                    })
                    .onEnded({ _ in
                        withAnimation(.easeInOut(duration: 0.2)) {
                            if scale < 1 {
                                scale = 1
                                lastScale = 0
                            } else {
                                lastScale = scale - 1
                            }
                        }
                        vm.currentScale = scale
                    })
            )
            .frame(cropSize)
        }
        
        @ViewBuilder
        func grids(size: CGSize) -> some View {
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
}

extension View {
    @ViewBuilder
    func frame(_ size: CGSize) -> some View {
        self.frame(width: size.width, height: size.height)
    }
    
    func haptics(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
        UIImpactFeedbackGenerator(style: style).impactOccurred()
    }
}
