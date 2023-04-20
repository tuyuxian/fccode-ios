//
//  BasicInfoView.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/10/23.
//

import SwiftUI

struct BasicInfoView: View {
    @State var showModal: Bool = true
        
    let basicInfoOptions: [ChildView] = [
           ChildView(
               label: "Life Photos",
               hasMedia: true,
               media: AnyView(LifePhotoStack().padding(.top, 12))
           ),
           ChildView(
               label: "Voice Message",
               hasMedia: true,
               media: AnyView(VoiceRecordButton().padding(.top, 12))
           ),
           ChildView(
               label: "Self Introduction",
               view: AnyView(BasicInfoSelfIntroView()),
               preview: AnyView(PreviewText(text: "Hello! I'm ChatGPT, a language model designed to understand and generate human-like language. I'm here to assist you in any way I can with my vast knowledge and natural language processing abilities."))
           ),
           ChildView(
               label: "Name",
               view: AnyView(BasicInfoNameView()),
               preview: AnyView(PreviewText(text: "Marine"))
           ),
           ChildView(
               label: "Birthday",
               view: AnyView(BasicInfoBirthdayView()),
               preview:  AnyView(PreviewText(text: "01/01/2000"))
           ),
           ChildView(
               label: "Gender",
               view: AnyView(BasicInfoGenderView()),
               preview:  AnyView(PreviewText(text: "Female"))
           ),
           ChildView(
               label: "Ethnicity",
               view: AnyView(BasicInfoEthnicityView()),
               preview:  AnyView(PreviewText(text: "Asian"))
           ),
    ]
    
    var body: some View {
        ZStack {
            ContainerWithHeaderView(parentTitle: "Profile", childTitle: "Basic Info") {
                VStack(spacing: 0) {
                    BoxTab()
                        .zIndex(1)
                    Box {
                        MenuList(childViewList: basicInfoOptions)
                            .padding(.top, 24) // 54 - 20 (ListRow) - 10 (first item's padding)
                    }
                    .padding(.top, -24)
                }
            }
        }
    }
}

struct BasicInfoView_Previews: PreviewProvider {
    static var previews: some View {
        BasicInfoView()
    }
}


class ModalControl: ObservableObject {
    @Published var showlifePhotoModal: Bool = false
}
