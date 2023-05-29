//
//  Banner.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/27/23.
//

import SwiftUI

struct Banner {
    
    enum BannerType {
        case info
        case warning
        case success
        case error
        
        var leadingIcon: String {
            switch self {
            case .info:
                return "Info"
            case .success:
                return "Heart"
            case .warning:
                return "Warning"
            case .error:
                return "ErrorCircle"
            }
        }
    }
    
    let title: String
    let type: BannerType
}

final class BannerManager: ObservableObject {
    
    @Published var isPresented: Bool = false
    
    var banner: Banner? {
        didSet {
            isPresented = banner != nil
        }
    }
    
    public func dismiss() {
        if isPresented {
            isPresented = false
        }
    }
    
    public func pop(
        title: String,
        type: Banner.BannerType
    ) {
        self.banner = .init(
            title: title,
            type: type
        )
    }
}

struct BannerContent: View {
    
    @ObservedObject var bm: BannerManager
    
    var body: some View {
        VStack {
            Spacer()

            HStack(
                alignment: .center,
                spacing: 8
            ) {
                Image(bm.banner?.type.leadingIcon ?? "")
                    .resizable()
                    .frame(width: 16, height: 16)

                Text(bm.banner?.title ?? "")
                    .fontTemplate(.noteMedium)
                    .foregroundColor(Color.text)
                    .lineLimit(1)
            }
            .padding(
                EdgeInsets(
                    top: 16,
                    leading: 16,
                    bottom: 16,
                    trailing: 16
                )
            )
            .background(Color.yellow20)
            .cornerRadius(16)
            .frame(
                maxWidth: UIScreen.main.bounds.width * 0.8,
                alignment: .center
            )
        }
        .padding(.bottom, UIScreen.main.bounds.height * 0.07)
        .transition(.opacity)
        .onAppear {
            DispatchQueue.main.asyncAfter(
                deadline: .now() + 2  // last for 2 seconds
            ) {
                withAnimation {
                    bm.dismiss()
                }
            }
        }
    }
}
