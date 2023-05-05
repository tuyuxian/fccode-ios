//
//  Banner.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/27/23.
//

import SwiftUI

struct BannerModifier: ViewModifier {
    struct BannerData {
        var content: String
        var type: BannerType
    }
    enum BannerType {
        case info
        case warning
        case success
        case error
        
        var leadingIcon: String {
            switch self {
            case .info:
                return "HeartBased"
            case .success:
                return "HeartBased"
            case .warning:
                return "HeartBased"
            case .error:
                return "HeartBased"
            }
        }
    }
    
    @Binding var data: BannerData
    @Binding var show: Bool
    
    func body(
        content: Content
    ) -> some View {
        ZStack {
            content
            if show {
                withAnimation(
                    .easeInOut
                ) { VStack {
                        Spacer()
                        HStack(
                            alignment: .center,
                            spacing: 5.33
                        ) {
                            Image(data.type.leadingIcon)
                                .resizable()
                                .frame(width: 21.33, height: 21.33)
                            Text(data.content)
                                .fontTemplate(.noteMedium)
                                .foregroundColor(Color.text)
                                .lineLimit(1)
                        }
                        .padding(
                            EdgeInsets(
                                top: 13.33,
                                leading: 13.33,
                                bottom: 13.33,
                                trailing: 13.33
                            )
                        )
                        .background(Color.yellow100)
                        .cornerRadius(16)
                        .frame(
                            maxWidth: UIScreen.main.bounds.width * 0.8,
                            alignment: .center
                        )
                    }
                    .padding(.bottom, UIScreen.main.bounds.height * 0.02)
                    .transition(
                        AnyTransition
                            .move(edge: .bottom)
                            .combined(with: .opacity)
                    )
                    .onAppear(perform: {
                        DispatchQueue.main.asyncAfter(
                            deadline: .now() + 2  // last for 2 seconds
                        ) {
                            withAnimation {
                                self.show = false
                            }
                        }
                    })
                }
            }
        }
    }
    
    static private var demoBanner: Binding<BannerModifier.BannerData> {
        Binding.constant(
            BannerModifier.BannerData(
                content: "We've sent a reset link to your email!",
                type: .info)
        )
    }
    
    struct Banner_Previews: PreviewProvider {
        static var previews: some View {
            VStack {
                Text("Hello")
            }
            .banner(
                data: demoBanner,
                show: .constant(true)
            )
        }
    }
}

extension View {
    func banner(
        data: Binding<BannerModifier.BannerData>,
        show: Binding<Bool>
    ) -> some View {
        self.modifier(
            BannerModifier(
                data: data,
                show: show
            )
        )
    }
}
