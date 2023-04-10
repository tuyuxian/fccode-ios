//
//  TabBar.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/8/23.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        VStack(spacing: 0) {
            Divider()
                .foregroundColor(Color.surface2)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            HStack(spacing:90){
                Image("Chat")
                    .resizable()
                    .frame(width:42, height:42)

                Image("HeaderLogo")
                    .resizable()
                    .frame(width:42, height:42)
                    
                Image("Profile")
                    .resizable()
                    .frame(width:42, height:42)
            }
            .padding(EdgeInsets(top: 10, leading: 42, bottom: 0, trailing: 42))
            
        }
        .background(Color.background)

    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
