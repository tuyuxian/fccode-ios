//
//  SignUpProcessBar.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/21/23.
//

import SwiftUI

struct SignUpProcessBar: View {
    var steps: Int = 6
    var status: Int = 1
    
    var body: some View {
        HStack (spacing: 12){
            
            ForEach (0..<steps, id: \.self) { index in
                RoundedRectangle(cornerRadius: 50)
                    .fill(status-1 >= index ? Color.yellow100 : Color.white)
                    .frame(height: 8)
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

struct SignUpProcessBar_Previews: PreviewProvider {
    static var previews: some View {
        SignUpProcessBar()
    }
}
