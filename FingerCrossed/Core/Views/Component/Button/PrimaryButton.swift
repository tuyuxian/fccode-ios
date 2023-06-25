//
//  PrimaryButton.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/3/23.
//  Modified by Sam on 5/6/23.
//

import SwiftUI

struct PrimaryButton: View {
    
    @State var label: String
    
    @State var action: () -> Void = {}
    
    @Binding var isTappable: Bool
    
    @Binding var isLoading: Bool
    
    var body: some View {
        HStack {
            isLoading
            ? LottieView(lottieFile: "spinner.json")
                .frame(width: 24, height: 24)
            : nil
            
            isLoading
            ? nil
            : Text(label)
                .fontTemplate(.pMedium)
                .foregroundColor(isTappable ? Color.text : Color.white)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 52)
        .background(isTappable ? Color.yellow100 : Color.surface2)
        .cornerRadius(50)
        .contentShape(Rectangle())
        .onTapGesture {
            action()
        }
        .disabled(!isTappable || isLoading)
        
    }
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PrimaryButton(
                label: "Button",
                isTappable: .constant(true),
                isLoading: .constant(false)
            )
            PrimaryButton(
                label: "Button",
                isTappable: .constant(true),
                isLoading: .constant(true)
            )
            PrimaryButton(
                label: "Button",
                isTappable: .constant(false),
                isLoading: .constant(false)
            )
        }
        .padding(.horizontal, 24)
    }
}
