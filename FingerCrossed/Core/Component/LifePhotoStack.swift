//
//  LifePhotoStack.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/12/23.
//

import SwiftUI

struct LifePhotoStack: View {
    
    @State var showModal: Bool = false
    
    var body: some View {
        HStack(spacing: 14) {
            LifePhotoButton(
                content_url: "https://img.freepik.com/free-photo/pretty-smiling-joyfully-female-with-fair-hair-dressed-casually-looking-with-satisfaction_176420-15187.jpg?w=2000&t=st=1681172860~exp=1681173460~hmac=36c61c8ef9089e6e9875a89f7cc83463dcdcb9f79c052fab35a91224253a5d1e",
                position: 0,
                showModal: $showModal
            )
            VStack(spacing: 14) {
                HStack(spacing: 14) {
                    LifePhotoButton(position: 1, showModal: $showModal)
                    LifePhotoButton(position: 2, showModal: $showModal)
                }
                HStack(spacing: 14) {
                    LifePhotoButton(position: 3, showModal: $showModal)
                    LifePhotoButton(position: 4, showModal: $showModal)
                }
            }
        }
    }
}

struct LifePhotoStack_Previews: PreviewProvider {
    static var previews: some View {
        LifePhotoStack(showModal: false)
    }
}
