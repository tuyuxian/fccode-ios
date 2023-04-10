//
//  SignUpNationalityView.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/3/23.
//

import SwiftUI

struct SignUpNationalityView: View {
    @State private var showNationalitySheet: Bool = false
    
    @State private var x = 0
    
    @State private var nationalities = []
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea(.all)
            
            
            VStack {
                EntryLogo()
                
                Spacer()
                
                HStack {
                    Text("Tell us about your...")
                        .font(.h3Medium)
                    .foregroundColor(Color.textHelper)
                    
                    Spacer()
                }
                .padding(.horizontal, 24)
                
                HStack {
                    Text("Nationality")
                        .foregroundColor(.text)
                    .font(.bigBoldTitle)
                    
                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                
                Button(action: {
                    self.showNationalitySheet.toggle()
                }) {
                    HStack {
                        Text("Choose languages").foregroundColor(Color.black)
                        Spacer()
                        Text("\(nationalities.count)")
                            .foregroundColor(Color(UIColor.systemGray))
                            .font(.body)
                        Image(systemName: "chevron.right")
                            .foregroundColor(Color(UIColor.systemGray4))
                            .font(Font.body.weight(.medium))

                    }
                }
                .sheet(isPresented: $showNationalitySheet) {
                    NationalityPickerView()
                }

                Picker(selection: $x, label: Text("One item Picker")) {
                   ForEach(0..<10) { x in
                      Text("\(x)")
                   }
                }
                
                
                Spacer()
                    .frame(height: 170)
                
                Button {
                    print("Continue")
                } label: {
                    Text("Continue")
                }
                .buttonStyle(PrimaryButton())
                .padding(.horizontal, 24)
                
                Spacer()
                
            }
            
            
        }
    }
}

struct SignUpNationalityView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpNationalityView()
    }
}
