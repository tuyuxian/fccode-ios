//
//  ActionSheet.swift
//  FingerCrossed
//
//  Created by Lawrence on 6/28/23.
//

import SwiftUI

struct ActionSheet: View {
    @Binding var isPresented: Bool
//    @ViewBuilder var content: Content
    @State var description: String = ""
    @State var actionButtonList: [ActionButton] = []
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if isPresented {
                Color.black
                    .opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            isPresented.toggle()
                        }
                    }
                
                VStack(spacing: 6) {
                    VStack(spacing: 14) {
                        if description != "" {
                            Text(description)
                                .foregroundColor(Color.text)
                                .fontTemplate(.noteMedium)
                                .padding(.top, 14)
                            
                            Divider()
                                .overlay(Color.surface3)
                        }
                        
                        ForEach(Array(actionButtonList.enumerated()),
                                id: \.element.id) { index, button in
                            
                            Text(button.label)
                                .foregroundColor(Color.text)
                                .fontTemplate(.pMedium)
                                .frame(maxWidth: .infinity)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    button.action()
                                }
                                .padding(.top, description == "" ? 14 : 0)
                                .padding(.bottom, index != actionButtonList.count - 1 ? 0 : 14)
                            
                            index != actionButtonList.count - 1
                            ? Divider()
                                .overlay(Color.surface3)
                            : nil
                        }
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .foregroundColor(Color.white)
                    )
                    
                    ActionSheetButton(label: "Cancel") {
                        withAnimation(.easeInOut) {
                            isPresented.toggle()
                        }
                    }
                }
                .padding(.bottom, 40)
                .padding(.horizontal, 10)
                .transition(.move(edge: .bottom))
                .cornerRadius(16, corners: [.topLeft, .topRight])
            }
        } 
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
    }
}

struct ActionSheet_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ActionSheet(isPresented: .constant(true),
                        description: "Your message was not sent. ",
                        actionButtonList: [
                            ActionButton(label: "Try again", action: {}),
                            ActionButton(label: "Delete", action: {})
                        ]
            )
            
            ActionSheet(isPresented: .constant(true),
                        actionButtonList: [
                            ActionButton(label: "Try again", action: {}),
                            ActionButton(label: "Delete", action: {})
                        ]
            )
            
            ActionSheet(isPresented: .constant(true),
                        actionButtonList: [
                            ActionButton(label: "Try again", action: {})
                        ]
            )
        }
    }
}

private struct ActionSheetButton: View {
    let label: String
    let action: () -> Void
    
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .foregroundColor(Color.white)
            .frame(height: 52)
            .frame(maxWidth: .infinity)
            .onTapGesture {
                action()
            }
            .overlay(
                Text(label)
                    .foregroundColor(Color.text)
                    .fontTemplate(.pMedium)
                , alignment: .center
            )
    }
}

class ActionButton: Identifiable {
    let label: String
    let action: () -> Void
    
    init(label: String, action: @escaping () -> Void) {
        self.label = label
        self.action = action
    }
}
