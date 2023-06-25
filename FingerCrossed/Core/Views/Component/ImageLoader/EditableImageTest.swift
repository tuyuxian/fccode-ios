//
//  EditableImageTest.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 6/1/23.
//

import SwiftUI

struct EditableImageTest: View {
  
    @State var lastOffset: CGSize = .zero
    @State var offset: CGSize = .zero
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { val in
                offset = CGSize(
                    width: val.translation.width + lastOffset.width,
                    height: val.translation.height + lastOffset.height
                )
            }
            .onEnded { val in
                let boundedOffset = boundingOffset(for: CGSize(
                    width: val.translation.width,
                    height: val.translation.height
                ))
                withAnimation {
                    offset = boundedOffset
                    lastOffset = offset
                }
            }
    }

    let boxSize: CGSize = CGSize(width: 342, height: 342)
    
    func boundingOffset(for offset: CGSize) -> CGSize {
           var boundedOffset = offset

        if offset.width > boxSize.width {
            boundedOffset.width = boxSize.width / 4
           } else if offset.width < -(boxSize.width / 4) {
               boundedOffset.width = -(boxSize.width / 4)
           }

           if offset.height > boxSize.height / 4 {
               boundedOffset.height = boxSize.height / 4
           } else if offset.height < -(boxSize.height / 4) {
               boundedOffset.height = -(boxSize.height / 4)
           }

           return boundedOffset
       }
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea(.all)
            VStack {
                VStack {}
                .frame(width: 342, height: 254)
                .background(
                    AsyncImage(
                        url: URL(string: "https://i.pravatar.cc/150?img=9"),
                        transaction: Transaction(animation: .easeInOut)
                    ) { phase in
                        switch phase {
                        case .empty:
                            EmptyView()
                        case .success(let image):
                            GeometryReader { geometry in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .offset(x: offset.width, y: offset.height)
                                    .gesture(drag)
                            }
                            
                        case .failure:
                            EmptyView()
                        @unknown default:
                            EmptyView()
                        }
                    }
                )
            }
            .background(.red)
        }
    }
}

struct EditableImageTest_Previews: PreviewProvider {
    static var previews: some View {
        EditableImageTest()
    }
}
