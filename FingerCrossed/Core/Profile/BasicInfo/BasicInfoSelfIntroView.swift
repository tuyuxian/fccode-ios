//
//  BasicInfoSelfIntroView.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/8/23.
//

import SwiftUI

struct BasicInfoSelfIntroView: View {
    
    @State var remainCharacters: Int = 200
    
    var body: some View {
        ContainerWithHeaderView(parentTitle: "Basic Info", childTitle: "Self Introduction") {
            Box {
                VStack(alignment: .trailing, spacing: 6.0){
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.red)
                        .frame(height: 192)
                    Text("\(200 - remainCharacters)/200")
                        .font(.captionRegular)
                        .foregroundColor(Color.textHelper)
                }
                .padding(EdgeInsets(top: 30, leading: 24, bottom: 0, trailing: 24))
                Spacer()
                TabBar()
            }
        }
    }
}

struct BasicInfoSelfIntroView_Previews: PreviewProvider {
    static var previews: some View {
        BasicInfoSelfIntroView()
    }
}
