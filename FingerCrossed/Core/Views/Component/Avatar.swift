//
//  Avatar.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/1/23.
//

import SwiftUI

struct Avatar: View {
    
    @State var avatarUrl: String
    
    @State var size: CGFloat
    
    @State var isActive: Bool
    /// Set this variable when the background color is not white
    @State var dotBackground: Color = Color.white
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            FCAsyncImage(
                url: URL(string: avatarUrl)!
            )
            .frame(width: size, height: size)
            .clipShape(RoundedRectangle(cornerRadius: 100))
            
            isActive
            ? Circle()
                .fill(Color.yellow100)
                .frame(width: 8, height: 8)
                .overlay(
                    Circle()
                        .stroke(dotBackground, lineWidth: 3)
                        .frame(width: 11, height: 11)
                )
            : nil
        }
    }
}

struct Avatar_Previews: PreviewProvider {
    static var previews: some View {
        Avatar(
            avatarUrl: "https://i.pravatar.cc/150?img=5",
            size: 50,
            isActive: true
        )
    }
}
