//
//  AsyncEditImageLoader.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/30/23.
//

import SwiftUI

struct AsyncEditImageLoader<Placeholder: View>: View {
    @StateObject private var loader: ImageLoader
    @ObservedObject var config: ProfileViewModel
    private let placeholder: Placeholder
    private let url: URL
    private let image: (UIImage) -> Image
    @State private var currentOffset: CGSize = .zero
    @State private var currentScale: CGFloat = 0.0
        
    init(
        url: URL,
        config: ProfileViewModel,
        @ViewBuilder placeholder: () -> Placeholder,
        @ViewBuilder image: @escaping (UIImage) -> Image = Image.init(uiImage:)
    ) {
        self.url = url
        self.config = config
        self.placeholder = placeholder()
        self.image = image
        _loader = StateObject(
            wrappedValue: ImageLoader(
                url: url,
                cache: Environment(\.imageCache).wrappedValue
            )
        )
    }

    var body: some View {
        content
            .onAppear(perform: loader.load)
    }
    
    private var content: some View {
        GeometryReader { geometry in
            if loader.image != nil {
                image(loader.image!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .scaleEffect(config.imageScale + currentScale)
                    .offset(config.imageOffset + currentOffset)
                    .cornerRadius(6)
//                    .modifier(ImageModifier(contentSize: CGSize(width: geometry.size.width, height: geometry.size.height)))
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                currentOffset = gesture.translation
                            }
                            .onEnded { _ in
                                if config.imageOffset.width < geometry.size.width {
                                    config.imageOffset = CGSize(width: config.imageOffset.width + self.currentOffset.width, height: config.imageOffset.height + self.currentOffset.height)
                                    currentOffset = .zero
                                } else {
                                    config.imageOffset = .zero
                                }
                            }
                    )
                    .gesture(
                        MagnificationGesture()
                            .onChanged {(value) in
                            config.imageScale = value
                            }
                            .onEnded {(value) in
                            config.imageScale = value < 1 ? 1 : value
                            }
                    )
//                    .onChange(of: config.imageScale, perform: { newScale in
//                        let data = loader.image!.jpegData(compressionQuality: 0.95)!
//                        config.newUIImage = UIImage(data: data, scale: newScale)!
//                        
//                        config.cropCGRect = CGRect(x: config.imageOffset.width, y: config.imageOffset.height, width: geometry.size.width, height: geometry.size.height)
//                        config.cropCGImage = (config.newUIImage.cgImage?.cropping(to: config.cropCGRect))!
//                    })
//                    .onChange(of: config.imageOffset, perform: { newOffset in
//                        config.cropCGRect = CGRect(x: newOffset.width, y: newOffset.height, width: geometry.size.width, height: geometry.size.height)
//                        config.cropCGImage = (config.newUIImage.cgImage?.cropping(to: config.cropCGRect))!
//                    })
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

            } else {
                placeholder
            }
        }
    }
}

extension CGSize {
    static func + (lhs: CGSize, rhs: CGSize) -> CGSize {
        return CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
    }
    
    static func - (lhs: CGSize, rhs: CGSize) -> CGSize {
        return CGSize(width: lhs.width - rhs.width, height: lhs.height - rhs.height)
    }
}

extension CGPoint {
    static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    
    static func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
}
