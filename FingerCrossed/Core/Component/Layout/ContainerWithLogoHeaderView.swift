//
//  ContainerWithLogoHeaderView.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/9/23.
//

import SwiftUI

struct ContainerWithLogoHeaderView<Content: View>: View {
    
    @State var headerTitle: String
    
    @ViewBuilder var content: Content
    
    var body: some View {
        NavigationView{
            ZStack {
                Color.background.ignoresSafeArea(.all)
                content
                .navigationBarItems(leading:
                    // TODO(Sam): change padding 
                    HStack(alignment: .center, spacing: 8) {
                        Image("HeaderLogo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width:50, height: 50)

                        HStack(alignment: .center) {
                            Text(headerTitle)
                                .fontTemplate(.h1Medium)
                                .foregroundColor(Color.text)
                                .frame(height: 40)
                                .padding(.bottom, -8)
                        }
                    }
                    .padding(.top, 10)
                    .padding(.leading, 24)
                )
                .padding(.top, 19)
            }
        }
    }
}

struct ContainerWithLogoHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ContainerWithLogoHeaderView(headerTitle:"Header" ,content: {})
    }
}
