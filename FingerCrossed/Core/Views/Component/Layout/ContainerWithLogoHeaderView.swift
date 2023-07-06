//
//  ContainerWithLogoHeaderView.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/9/23.
//

import SwiftUI

struct ContainerWithLogoHeaderView<Content: View>: View {
    
    @State var headerTitle: String
    
    @State var path = NavigationPath()
        
    @ViewBuilder var content: Content
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                Color.background.edgesIgnoringSafeArea(.all)
                
                content
                    .navigationBarItems(
                        leading:
                            NavigationHeaderWithLogo(
                                title: $headerTitle
                            )
                    )
                    .padding(.top, 19) // 75px - 59px (iPhone 14 Pro safe area)
            }
        }
    }
}

struct ContainerWithLogoHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ContainerWithLogoHeaderView(headerTitle: "Header") {}
    }
}

private struct NavigationHeaderWithLogo: View {
    
    @Binding var title: String
    
    /// Design style changelog
    /// - Horizontal padding: 24px - 16px(default) = 8px
    /// - Height of navigation bar set to 40px
    var body: some View {
        HStack(
            alignment: .center,
            spacing: 8
        ) {
            Image("Logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)

            Text(title)
                .fontTemplate(.h1Medium)
                .foregroundColor(Color.text)
                .frame(height: 40)
        }
        .frame(height: 40)
        .padding(.horizontal, 8)
    }
}
