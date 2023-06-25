//
//  CustomPicker.swift
//  FingerCrossed
//
//  Created by Lawrence on 5/1/23.
//  Reference: https://github.com/GGJJack/SwiftUIWheelPicker
//

import SwiftUI

public struct CustomPicker<Content: View, Item>: View {
    
    public enum HeightOption {
        case visibleCount(Int)
        case fixed(CGFloat)
        case ratio(CGFloat)
    }
    
    private var items: Binding<[Item]>
    let contentBuilder: (Item) -> Content
    @Binding var position: Int
    @GestureState private var translation: CGFloat = 0
    private var contentHeightOption: HeightOption = .visibleCount(5)
    private var sizeFactor: CGFloat = 1
    private var alphaFactor: Double = 1
    private var edgeTopView: AnyView?
    private var edgeTopHeight: HeightOption?
    private var edgeBottomView: AnyView?
    private var edgeBottomHeight: HeightOption?
    private var centerView: AnyView?
    private var centerViewHeight: HeightOption?
    private var onValueChanged: ((Item) -> Void)?
    
    public init(
        _ position: Binding<Int>,
        items: Binding<[Item]>,
        @ViewBuilder content: @escaping (Item) -> Content
    ) {
        self.items = items
        self._position = position
        self.contentBuilder = content
    }
    
    public init(
        _ position: Binding<Int>, items: [Item],
        @ViewBuilder content: @escaping (Item) -> Content
    ) {
        self.items = Binding.constant(items)
        self._position = position
        self.contentBuilder = content
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack(
                alignment:
                    Alignment(
                        horizontal: .center,
                        vertical: .top
                    )
            ) {
                VStack(spacing: 0) {
                    ForEach(0..<items.wrappedValue.count, id: \.self) { position in
                        drawContentView(
                            position,
                            geometry: geometry
                        )
                    }
                }
                .frame(
                    height: geometry.size.height,
                    alignment: .top
                )
                .offset(
                    y: -CGFloat(self.position + 1) *
                        self.calcContentHeight(geometry, option: contentHeightOption))
                .offset(
                    y: self.translation +
                        geometry.size.height / 2 +
                        self.calcContentHeight(geometry, option: contentHeightOption) / 2)
                .animation(
                    .interactiveSpring(),
                    value: self.position + 1
                )
                .animation(
                    .interactiveSpring(),
                    value: translation
                )
                .clipped()
                
                if let view = edgeTopView, let heightOption = edgeTopHeight {
                    let height = calcContentHeight(
                        geometry,
                        option: heightOption
                    )
                    view.frame(
                        width: geometry.size.width,
                        height: height,
                        alignment: .center
                    )
                }
                if let view = edgeBottomView, let heightOption = edgeBottomHeight {
                    let height = calcContentHeight(
                        geometry,
                        option: heightOption
                    )
                    view
                        .offset(y: geometry.size.height - height)
                        .frame(
                            width: geometry.size.width,
                            height: height,
                            alignment: .center
                        )
                }
                if let view = centerView, let heightOption = centerViewHeight {
                    let height = calcContentHeight(
                        geometry,
                        option: heightOption
                    )
                    view
                        .offset(y: geometry.size.height - height / 2 )
                        .frame(
                            width: geometry.size.width,
                            height: height,
                            alignment: .center
                        )
                }
            }
            .frame(
                width: geometry.size.width,
                height: geometry.size.height
            )
            .contentShape(Rectangle())
            .gesture(
                DragGesture().updating(self.$translation) { value, state, _ in
                    state = value.translation.height * 1.2
                }
                .onEnded { value in
                    let offset = value.translation.height /
                        self.calcContentHeight(
                            geometry,
                            option: contentHeightOption
                        )
                    let newIndex = (CGFloat(self.position) - offset).rounded()
                    self.position = min(max(Int(newIndex), 0), self.items.wrappedValue.count - 1)
                    self.onValueChanged?(items.wrappedValue[self.position])
                }
            )
        }
    }
    
    public func height(
        _ option: HeightOption
    ) -> Self {
        var newSelf = self
        newSelf.contentHeightOption = option
        return newSelf
    }
    
    public func scrollAlpha(
        _ value: Double
    ) -> Self {
        var newSelf = self
        newSelf.alphaFactor = value
        return newSelf
    }
    
    public func edgeTop(
        _ view: AnyView,
        height: HeightOption
    ) -> Self {
        var newSelf = self
        newSelf.edgeTopView = view
        newSelf.edgeTopHeight = height
        return newSelf
    }
    
    public func edgeBottom(
        _ view: AnyView,
        height: HeightOption
    ) -> Self {
        var newSelf = self
        newSelf.edgeBottomView = view
        newSelf.edgeBottomHeight = height
        return newSelf
    }
    
    public func centerView(
        _ view: AnyView,
        height: HeightOption
    ) -> Self {
        var newSelf = self
        newSelf.centerView = view
        newSelf.centerViewHeight = height
        return newSelf
    }
    
    public func onValueChanged(
        _ callback: @escaping (Item) -> Void
    ) -> Self {
        var newSelf = self
        newSelf.onValueChanged = callback
        return newSelf
    }
    
    private func drawContentView(
        _ position: Int,
        geometry: GeometryProxy
    ) -> some View {
        var sizeResult: CGFloat = 1
        var alphaResult: Double = 1
        
        if sizeFactor != 1.0 || alphaFactor != 1.0 {
            let maxRange = floor(maxVisible(geometry) / 2.0)
            let offset = translation /
                self.calcContentHeight(
                    geometry,
                    option: contentHeightOption
                )
            let newIndex = CGFloat(self.position) - offset
            let posGap = CGFloat(position) - newIndex
            var per = abs(posGap / maxRange)
            if 1.0 < per {
                per = 1.0
            }
            
            if sizeFactor != 1.0 {
                let sizeGap = 1.0 - sizeFactor
                let preSizeRst = per * sizeGap
                sizeResult = 1 - preSizeRst
            }
            
            if alphaFactor != 1.0 {
                let alphaGap = 1.0 - alphaFactor
                let preAlphaRst = Double(per) * alphaGap
                alphaResult = 1.0 - preAlphaRst
            }
        }
        
        let item = items.wrappedValue[position]
        return contentBuilder(item)
            .scaleEffect(sizeResult)
            .opacity(alphaResult)
            .frame(
                height: self.calcContentHeight(
                    geometry,
                    option: contentHeightOption
                ),
                alignment: .center
            )
    }
    
    private func maxVisible(
        _ geometry: GeometryProxy
    ) -> CGFloat {
        let visibleCount = geometry.size.height /
            self.calcContentHeight(
                geometry,
                option: contentHeightOption
            )
        return min(visibleCount, CGFloat(self.items.wrappedValue.count))
    }
    
    private func calcContentHeight(
        _ geometry: GeometryProxy,
        option: HeightOption
    ) -> CGFloat {
        switch option {
        case .visibleCount(let count):
            return geometry.size.height / CGFloat(count)
        case .fixed(let height):
            return height
        case .ratio(let ratio):
            return geometry.size.height * ratio
        }
    }
}

struct CustomPicker_Previews: PreviewProvider {
    
    @ViewBuilder static func preview() -> some View {
        VStack(
            alignment: .center,
            spacing: 0
        ) {
            CustomPicker(
                Binding.constant(5),
                items: Binding.constant([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
            ) { value in
                GeometryReader { reader in
                    Text("\(value)")
                        .frame(
                            width: reader.size.width,
                            height: reader.size.height,
                            alignment: .center
                        )
                }
            }
        }
        .frame(height: 192)
    }
    
    static var previews: some View {
        preview()
    }
}
