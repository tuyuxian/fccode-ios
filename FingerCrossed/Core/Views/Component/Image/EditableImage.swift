//
//  EditableImage.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 6/18/23.
//

import SwiftUI
import UIKit

struct EditableImage<Content: View>: View {

    @ViewBuilder var image: Content
    
    @Binding var cropRatio: LifePhotoEditSheet.CropRatio
    
    @Binding var currentOffset: CGPoint
    
    @Binding var currentScale: CGFloat
            
    var body: some View {
        GeometryReader { proxy in
            image
            .aspectRatio(1, contentMode: .fit)
            .frame(width: proxy.size.width, height: proxy.size.height)
//            .frame(maxHeight: .infinity)
            .modifier(
                EditableImageModifier(
                    contentSize: cropRatio.size(),
                    currentScale: $currentScale,
                    currentOffset: $currentOffset,
                    currentRatio: $cropRatio
                )
            )
            .overlay { grids(size: proxy.size) }
        }
        .frame(width: cropRatio.size().width, height: cropRatio.size().height)
    }

    @ViewBuilder
    private func grids(size: CGSize) -> some View {
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

struct EditableImage_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EditableImage(
                image: {
                    FCAsyncImage(
                        url: URL(string: "")!
                    )
                },
                cropRatio: .constant(.ratio1),
                currentOffset: .constant(.zero),
                currentScale: .constant(1.2)
            )
        }
    }
}

struct EditableImageModifier: ViewModifier {
    
    enum ScrollPosition: Hashable {
        case image( index: Int)
    }
    
    var contentSize: CGSize
    var min: CGFloat = 1.0
    var max: CGFloat = 3.0
    @Binding var currentScale: CGFloat
    @Binding var currentOffset: CGPoint
    @Binding var currentRatio: LifePhotoEditSheet.CropRatio
    
    var doubleTapGesture: some Gesture {
        TapGesture(count: 2).onEnded {
            if currentScale <= min { currentScale = max } else
            if currentScale >= max { currentScale = min } else {
                currentScale = ((max - min) * 0.5 + min) < currentScale ? max : min
            }
        }
    }
    
    func body(content: Content) -> some View {
        ScrollReader { proxy in
            // FIXME: can not scroll to top or bottom
            ScrollView([.horizontal, .vertical], showsIndicators: false) {
                content
                    .frame(
                        width: currentRatio.size().width * currentScale,
                        height: currentRatio.size().height * currentScale,
                        alignment: .center
                    )
//                    .frame(
//                        width: contentSize.width * currentScale,
//                        height: contentSize.height * currentScale,
//                        alignment: .center
//                    )
//                    .frame(maxHeight: .infinity, alignment: .center)
                    .modifier(
                        PinchToZoom(
                            minScale: min,
                            maxScale: max,
                            scale: $currentScale
                        )
                    )
                    .background(
                        GeometryReader { geometry in
                            Color.clear.preference(
                                key: ViewOffsetKey.self,
                                value: geometry.frame(in: .named("scrollOffset")).origin
                            )
                        }
                    )
                    .onPreferenceChange(ViewOffsetKey.self) {
                        currentOffset = $0
                    }
                    .scrollAnchor(ScrollPosition.image(index: 0))
                    .onAppear {
                        print("frameHeight: \(contentSize.height * currentScale)")
                        print("frameWidth: \(contentSize.width * currentScale)")
                        DispatchQueue.main.async {
                            print("onAppear: \(currentOffset)")
                            proxy.scroll(
                                to: ScrollPosition.image(index: 0),
                                anchor: .topLeading,
                                offset: CGPoint(
                                    x: -currentOffset.x,
                                    y: -currentOffset.y
                                )
                            )
                        }
                    }
            }
            .gesture(doubleTapGesture)
//            .animation(.spring(), value: currentScale)
            .coordinateSpace(name: "scrollOffset")
        }
    }
}

class PinchZoomView: UIView {
    let minScale: CGFloat
    let maxScale: CGFloat
    var isPinching: Bool = false
    var scale: CGFloat = 1.0
    let scaleChange: (CGFloat) -> Void
    
    init(
        minScale: CGFloat,
        maxScale: CGFloat,
        currentScale: CGFloat,
        scaleChange: @escaping (CGFloat) -> Void
    ) {
        self.minScale = minScale
        self.maxScale = maxScale
        self.scale = currentScale
        self.scaleChange = scaleChange
        super.init(frame: .zero)
        let pinchGesture = UIPinchGestureRecognizer(
            target: self,
            action: #selector(pinch(gesture:))
        )
        pinchGesture.cancelsTouchesInView = false
        addGestureRecognizer(pinchGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc private func pinch(gesture: UIPinchGestureRecognizer) {
        switch gesture.state {
        case .began:
            isPinching = true
            
        case .changed, .ended:
            if gesture.scale <= minScale {
                scale = minScale
            } else if gesture.scale >= maxScale {
                scale = maxScale
            } else {
                scale = gesture.scale
            }
            scaleChange(scale)
            print("pinch: \(scale)")
        case .cancelled, .failed:
            isPinching = false
            scale = 1.0
        default:
            break
        }
    }
}

struct PinchZoom: UIViewRepresentable {
    let minScale: CGFloat
    let maxScale: CGFloat
    @Binding var scale: CGFloat
    @Binding var isPinching: Bool
    
    func makeUIView(context: Context) -> PinchZoomView {
        let pinchZoomView = PinchZoomView(
            minScale: minScale,
            maxScale: maxScale,
            currentScale: scale,
            scaleChange: { scale = $0 }
        )
        return pinchZoomView
    }
    
    func updateUIView(_ pageControl: PinchZoomView, context: Context) { }
}

struct PinchToZoom: ViewModifier {
    let minScale: CGFloat
    let maxScale: CGFloat
    @Binding var scale: CGFloat
    @State var anchor: UnitPoint = .center
    @State var isPinching: Bool = false
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(scale, anchor: anchor)
//            .animation(.spring(), value: isPinching)
            .overlay(
                PinchZoom(
                    minScale: minScale,
                    maxScale: maxScale,
                    scale: $scale,
                    isPinching: $isPinching
                )
            )
    }
}

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGPoint
    static var defaultValue = CGPoint.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value.x += nextValue().x
        value.y += nextValue().y
        print("viewOffsetX:\(value.x)")
        print("viewOffsetY:\(value.y)")
    }
}
