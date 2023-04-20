//
//  RadioButtonRow.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/3/23.
//  Modified by Sam on 4/8/23.
//

import SwiftUI

struct RadioButtonRow: View {
    @State var label: String
    @State var isSelected: Bool = false
    
    var body: some View {
        HStack {
            Button {
                isSelected.toggle()
            } label: {
                Text(label)
                    .fontTemplate(.pMedium)
                    .foregroundColor(Color.text)
                
                Spacer()
                
                Image(isSelected ? "RadioSelected" : "RadioDefault")
            }
        }
        .padding(EdgeInsets(top: 16, leading: 24, bottom: 16, trailing: 24))
    }
}

struct RadioButtonRow_Previews: PreviewProvider {
    static var previews: some View {
        RadioButtonRow(label: "Radio")
    }
}
