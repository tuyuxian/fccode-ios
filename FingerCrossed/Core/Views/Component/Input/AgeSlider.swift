//
//  AgeSlider.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/26/23.
//

import SwiftUI

struct AgeSlider: View {
    @Binding var ageFrom: Int
    @Binding var ageTo: Int
    @State var from: CGFloat = 0
    @State var to: CGFloat = 100
    
    @State var isFromDragging: Bool = false
    @State var isToDragging: Bool = false
        
    var body: some View {
        GeometryReader { proxy in
            HStack(alignment: .bottom, spacing: 4) {
                Text("18")
                    .fontTemplate(.noteMedium)
                    .foregroundColor(Color.surface4)
                    .multilineTextAlignment(.center)
                    .frame(width: 14, height: 28)
                
                VStack(spacing: 4) {
                    HStack(spacing: 0) {
                        isFromDragging
                        ? Image("DragIndicator")
                            .renderingMode(.template)
                            .resizable()
                            .foregroundColor(Color.peach100)
                            .frame(width: 28, height: 34.85)
                            .overlay(
                                Text(self.getValue(val: ((self.from / (proxy.size.width - 56 - 46)) * 47)))
                                    .fontTemplate(.noteMedium)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(Color.white)
                                    .padding(.bottom, 6.85)
                            )
                            .offset(x: self.from)
                            .onChange(of: from) { val in
                                ageFrom = Int(
                                    self.getValue(val: ((val / (proxy.size.width - 56 - 46)) * 47))
                                ) ?? 18
                            }
                        : nil
                        isToDragging
                        ? Image("DragIndicator")
                            .renderingMode(.template)
                            .resizable()
                            .foregroundColor(Color.peach100)
                            .frame(width: 28, height: 34.85)
                            .overlay(
                                Text(self.getValue(val: ((self.to / (proxy.size.width - 56 - 46)) * 47)))
                                    .fontTemplate(.noteMedium)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(Color.white)
                                    .padding(.bottom, 6.85)
                            )
                            .offset(x: isFromDragging ? self.to : self.to + 28)
                            .onChange(of: to) { val in
                                ageTo = Int(
                                    self.getValue(val: ((val / (proxy.size.width - 56 - 46)) * 47))
                                ) ?? 65
                            }
                        : nil
                        Spacer()
                    }
                    .onAppear {
                        self.from = self.getX(age: ageFrom, width: proxy.size.width - 46)
                        self.to = self.getX(age: ageTo, width: proxy.size.width - 46)
                    }
                    .frame(width: proxy.size.width - 46, height: 34.85)
                    .padding(.bottom, 8.15)
                    
                    HStack(spacing: 0) {
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 50)
                                .fill(Color.surface3)
                                .frame(width: proxy.size.width - 46, height: 28)
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
                                        ? Text(
                                            self.getValue(
                                                val: ((self.from / (proxy.size.width - 56 - 46)) * 47))
                                        )
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
                                        // TODO(): long press gesture
                                    )

                                Circle()
                                    .fill(Color.peach100)
                                    .frame(width: isToDragging ? 16 : 28, height: isToDragging ? 16 : 28)
                                    .overlay(
                                        !isToDragging
                                        ? Text(
                                            self.getValue(
                                                val: ((self.to / (proxy.size.width - 56 - 46)) * 47)
                                            )
                                        )
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
                                                    proxy.size.width - 56 - 46 &&
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
                }
                
                Text("65+")
                    .fontTemplate(.noteMedium)
                    .foregroundColor(Color.surface4)
                    .multilineTextAlignment(.center)
                    .frame(width: 24, height: 28)
            }
        }
        .frame(height: 75)
    }
    
    private func getValue(
        val: CGFloat
    ) -> String {
        let result = String(format: "%.0f", val+18)
        return result == "65" ? "65+" : result
    }
    
    private func getX(
        age: Int,
        width: CGFloat
    ) -> CGFloat {
        let result = (age - 18) * (Int(ceil(width)) - 56) / 47
        return CGFloat(result)
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

private var valueFrom: Binding<Int> {
    Binding.constant(20)
}

private var valueTo: Binding<Int> {
    Binding.constant(40)
}

struct AgeSlider_Previews: PreviewProvider {
    static var previews: some View {
        AgeSlider(ageFrom: valueFrom, ageTo: valueTo)
    }
}
