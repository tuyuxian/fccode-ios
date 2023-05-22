//
//  AgeSlider.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/26/23.
//

import SwiftUI

struct AgeSlider: View {
    // TODO(Lawrence): use these two vars to get the value
    @State var from: CGFloat = 10
    @State var to: CGFloat = 80
    
    @State var isFromDragging: Bool = false
    @State var isToDragging: Bool = false
        
    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 4) {
                HStack(spacing: 0) {
                    isFromDragging
                    ? Image("DragIndicator")
                        .resizable()
                        .frame(width: 28, height: 34.85)
                        .overlay(
                            Text(self.getValue(val: ((self.from / (proxy.size.width - 56)) * 82)))
                                .fontTemplate(.noteMedium)
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color.white)
                                .padding(.bottom, 6.85)
                        )
                        .offset(x: self.from)
                    : nil
                    isToDragging
                    ? Image("DragIndicator")
                        .resizable()
                        .frame(width: 28, height: 34.85)
                        .overlay(
                            Text(self.getValue(val: ((self.to / (proxy.size.width - 56)) * 82)))
                                .fontTemplate(.noteMedium)
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color.white)
                                .padding(.bottom, 6.85)
                        )
                        .offset(x: isFromDragging ? self.to : self.to + 28)
                    : nil
                    Spacer()
                }
                .frame(width: proxy.size.width, height: 34.85)
                .padding(.bottom, 8)
                
                HStack(spacing: 0) {
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 50)
                            .fill(Color.surface3)
                            .frame(height: 28)
                        RoundedRectangle(cornerRadius: 50)
                            .fill(Color.yellow20)
                            .frame(width: self.to - self.from + 56, height: 28)
                            .offset(x: self.from)
                        HStack(spacing: 0) {
                            Circle()
                                .fill(Color.peach100)
                                .frame(width: isFromDragging ? 16 : 28, height: isFromDragging ? 16 : 28)
                                .overlay(
                                    !isFromDragging
                                    ? Text(self.getValue(val: ((self.from / (proxy.size.width - 56)) * 82)))
                                        .fontTemplate(.noteMedium)
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(Color.white)
                                    : nil
                                    
                                )
                                .offset(x: isFromDragging ? self.from + 6 : self.from)
                                .gesture(
                                    DragGesture()
                                        .onChanged({ (value) in
                                            self.isFromDragging = true
                                            if value.location.x >= 0 && value.location.x < self.to {
                                                self.from = value.location.x
                                            }
                                        })
                                        .onEnded({ _ in
                                            self.isFromDragging = false
                                        })
                                    // TODO(Sam): long press gesture
                                )

                            Circle()
                                .fill(Color.peach100)
                                .frame(width: isToDragging ? 16 : 28, height: isToDragging ? 16 : 28)
                                .overlay(
                                    !isToDragging
                                    ? Text(self.getValue(val: ((self.to / (proxy.size.width - 56)) * 82)))
                                        .fontTemplate(.noteMedium)
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(Color.white)
                                    : nil
                                )
                                .offset(x: getOffset(val: self.to))
                                .gesture(
                                    DragGesture()
                                        .onChanged({ (value) in
                                            self.isToDragging = true
                                            if value.location.x <=
                                                proxy.size.width - 56 &&
                                                value.location.x > self.from {
                                                self.to = value.location.x
                                            }
                                        })
                                        .onEnded({ _ in
                                            self.isToDragging = false
                                        })
                                )
                        }
                    }
                }
                HStack(spacing: 0) {
                    Text("18")
                        .fontTemplate(.noteMedium)
                        .foregroundColor(Color.surface4)
                        .multilineTextAlignment(.center)
                        .frame(width: 28, height: 28)
                    Spacer()
                    Text("99+")
                        .fontTemplate(.noteMedium)
                        .foregroundColor(Color.surface4)
                        .multilineTextAlignment(.center)
                        .frame(width: 28, height: 28)
                }
            }
        }
        .frame(height: 60)
    }
    
    private func getValue(
        val: CGFloat
    ) -> String {
        let result = String(format: "%.0f", val+18)
        return result == "100" ? "99+" : result
    }
    
    private func getOffset(
        val: CGFloat
    ) -> CGFloat {
        return isFromDragging
                ? isToDragging
                    ? val + 18
                    : val + 12
                : isToDragging
                    ? val + 6
                    : val
    }
}

struct AgeSlider_Previews: PreviewProvider {
    static var previews: some View {
        AgeSlider()
    }
}
