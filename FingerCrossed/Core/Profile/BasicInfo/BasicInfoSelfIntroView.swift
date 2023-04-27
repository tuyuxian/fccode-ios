//
//  BasicInfoSelfIntroView.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/8/23.
//

import SwiftUI

struct BasicInfoSelfIntroView: View {
    
    @State var text: String = ""
    var body: some View {
        ContainerWithHeaderView(parentTitle: "Basic Info", childTitle: "Self Introduction") {
            Box {
                VStack(alignment: .trailing, spacing: 6.0){
                    VStack {
                        CaptionInputBar(
                            hint: "Type your self introduction",
                            defaultPresentLine: 10,
                            lineLimit: 10
                        )
                    }
                    .padding(.horizontal, 1) // offset border width

                    Text("\(self.text.count)/200")
                        .fontTemplate(.captionRegular)
                        .foregroundColor(Color.textHelper)
                }
                .padding(EdgeInsets(top: 30, leading: 24, bottom: 0, trailing: 24))
                Spacer()
            }
        }
    }
}

struct BasicInfoSelfIntroView_Previews: PreviewProvider {
    static var previews: some View {
        BasicInfoSelfIntroView()
    }
}
