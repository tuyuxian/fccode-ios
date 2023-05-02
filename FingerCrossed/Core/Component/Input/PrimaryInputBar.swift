//
//  PrimaryInputBar.swift
//  FingerCrossed
//
//  Created by Lawrence on 3/31/23.
//  Modified by Sam on 4/8/23.
//

import SwiftUI

struct PrimaryInputBar: View {
    @Binding var value: String
    @State var view: AnyView = AnyView(EmptyView())
    var hint: String = "Log in or sign up with email"
    var iconName: String = "ArrowRightCircleBased"
    var isDisable: Bool
    var hasButton: Bool
    var isPassword: Bool = false
    var isEmail: Bool = false
    var isError: Bool = false
    @Binding var isQualified: Bool
    @State var isPresent = false
    @State var isVisible: Bool = true
    @FocusState var isFocus: Bool
    
    var body: some View {
        HStack {
            Group {
                if isPassword && isVisible {
                    SecureField("",
                                text: $value,
                                prompt: Text(hint)
                                    .font(Font.system(size: 16, weight: .regular))
                                    .foregroundColor(isDisable ? Color.surface1 : Color.textHelper))
                } else {
                    TextField("" ,
                              text: $value,
                              prompt: Text(hint)
                                    .font(Font.system(size: 16, weight: .regular))
                                    .foregroundColor(isDisable ? Color.surface1 : Color.textHelper))
                    .keyboardType(isEmail ? .emailAddress : .default)
                }
            }
            .fontTemplate(.pRegular)
            .foregroundColor(isDisable ? Color.surface1 : isError ? Color.warning : Color.text)
            .frame(height: 56)
            .disabled(isDisable)
            .focused($isFocus)
            
            if hasButton {
                if isError {
                    Button(action: {
                        value = ""
                    }, label: {
                        Image("CloseWarning")
                            .resizable()
                            .frame(width: 24, height: 24)
                    })
                } else {
                    Button {
                        isPresent = isQualified
                    } label: {
                        Image(iconName)
                            .resizable()
                            .frame(width: 24, height: 24)
                    }

                }
            }
            
            isPassword ? Button(action: {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        self.isVisible.toggle()
                    }
                }, label: {
                    Image( self.isVisible ? "EyeShow" : "EyeClose")
                        .resizable()
                        .frame(width: 24, height: 24)
                })
                .padding(.vertical, 16)
            : nil
            
            
        }
        .navigationDestination(isPresented: $isPresent) {
            view
        }
        .navigationBarBackButtonHidden(true)
        .padding(.horizontal, 16)
        .frame(height: 56)
        .background(
            RoundedRectangle(cornerRadius: 50)
                .stroke(isError ? Color.warning : Color.surface2, lineWidth: 1)
                .background(
                    VStack {
                        if isDisable {
                            RoundedRectangle(cornerRadius: 50)
                                .fill(Color.surface2)
                        } else {
                            RoundedRectangle(cornerRadius: 50)
                                .fill(Color.white)
                        }
                    }
                )
            )
    }

}

private var value: Binding<String> {
    Binding.constant("Value")
}

private var bool: Binding<Bool> {
    Binding.constant(false)
}

struct PrimaryInputBar_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryInputBar(value: value, isDisable: false, hasButton: true, isPassword: false, isQualified: bool)
    }
}
