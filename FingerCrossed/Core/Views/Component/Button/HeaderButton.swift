//
//  HeaderButton.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/1/23.
//

import SwiftUI

struct HeaderButton: View {
    
//    @Environment(\.presentationMode) var presentationMode
    
    @Binding var name: String
    
    @Binding var isLoading: Bool
    
    var action: () -> () = {}
    
    var body: some View {
        Button {
            action()
//            presentationMode.wrappedValue.dismiss()
        } label: {
            if isLoading {
                ProgressView()
            } else {
                Text(name)
                    .fontTemplate(.pMedium)
                    .foregroundColor(Color.gold)
            }                
        }
    }
}

struct HeaderButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            HeaderButton(
                name: .constant("Demo"),
                isLoading: .constant(true)
            )
            HeaderButton(
                name: .constant("Demo"),
                isLoading: .constant(false)
            )
        }
    }
}
