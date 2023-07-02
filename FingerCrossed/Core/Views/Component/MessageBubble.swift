//
//  MessageBubble.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/2/23.
//

import SwiftUI

enum SendingPhase {
    case sending
    case sent
    case fail
}

enum LoadingPhase {
    case loading
    case success
    case fail
}

struct MessageBubble: View {
    
    @Binding var message: String
    
    @Binding var timeStamp: String
        
    @Binding var isReceived: Bool
        
    @Binding var avatarUrl: String
    
    @State private var showFullImageCover: Bool = false
    
    @State private var showActionSheet: Bool = false
    
    @State private var showtimeStamp: Bool = false
    
    @State private var sendingPhase: SendingPhase = .sent
    
    @State private var loadingPhase: LoadingPhase = .success
    
    @State private var uploadingProgress: Double = 0.75
    
    var body: some View {
        VStack(
            alignment:
                isReceived
                ? .leading
                : .trailing
        ) {
            showtimeStamp
            ? DateStamp(datestamp: timeStamp)
            : nil
            
            HStack(alignment: .top, spacing: 6) {
                isReceived
                ? Avatar(
                    avatarUrl: avatarUrl,
                    size: 34,
                    isActive: false // isActive is false to stick to the design
                )
                : nil
                
                HStack(alignment: .bottom, spacing: 4) {
                    
                    if let url = URL(string: message) {
                        if !isReceived  && sendingPhase == .fail {
                            FCIcon.errorCircleSmall
                                .frame(width: 16, height: 16)
                                .padding(.bottom, 0)
                        }
                        
                        FCAsyncImage(url: url)
                            .aspectRatio(contentMode: .fill)
                            .frame(
                                height: MessageBubble.getHeight(
                                        photoType: FCAsyncImage(url: url).photoType,
                                        width: 230
                                )
                            )
                            .frame(
                                maxWidth: 230,
                                alignment:
                                   isReceived
                                   ? .leading
                                   : .trailing
                            )
                            .cornerRadius(
                                10,
                                corners:
                                    isReceived
                                    ? [
                                        .topRight,
                                        .bottomLeft,
                                        .bottomRight
                                    ]
                                    : [
                                        .topLeft,
                                        .topRight,
                                        .bottomLeft
                                    ]
                            )
                            .onTapGesture {
                                switch sendingPhase {
                                case .sending:
                                    print("sending")
                                case .sent:
                                    withAnimation {
                                        showFullImageCover.toggle()
                                    }
                                case .fail:
                                    withAnimation {
                                        showActionSheet.toggle()
                                    }
                                }
                            }
                            .onTapGesture {
                                switch loadingPhase {
                                case .fail:
                                    withAnimation {
                                        showActionSheet.toggle()
                                    }
                                case .success:
                                    withAnimation {
                                        showFullImageCover.toggle()
                                    }
                                case .loading:
                                    print("loading")
                                }
                            }
                            .overlay(
                                sendingPhase == .sending ?
                                CircularProgress(progress: uploadingProgress)
                                    .overlay(
                                        FCIcon.stop
                                            .resizable()
                                            .renderingMode(.template)
                                            .aspectRatio(contentMode: .fit)
                                            .foregroundColor(Color.white)
                                            .frame(width: 32.67, height: 32.67)
                                            .onTapGesture {
                                                sendingPhase = .fail
                                            }
                                    )
                                : nil
                            )
                        
                        if isReceived  && loadingPhase == .fail {
                            FCIcon.errorCircleSmall
                                .frame(width: 16, height: 16)
                                .padding(.bottom, 0)
                        }
                        
                    } else {
                        if !isReceived {
                            switch sendingPhase {
                            case .sending:
                                FCIcon.sending
                                    .frame(width: 16, height: 16)
                                    .padding(.bottom, 12)
                            case .sent:
                                FCIcon.sending
                                    .opacity(0)
                            case .fail:
                                FCIcon.errorCircleSmall
                                    .frame(width: 16, height: 16)
                                    .padding(.bottom, 12)
                            }
                        }
                        
                        Text(message)
                            .fontTemplate(.pRegular)
                            .foregroundColor(Color.text)
                            .multilineTextAlignment(.leading)
                            .padding(8)
                            .background(Color.surface3)
                            .cornerRadius(
                                10,
                                corners:
                                    isReceived
                                    ? [
                                        .topRight,
                                        .bottomLeft,
                                        .bottomRight
                                    ]
                                    : [
                                        .topLeft,
                                        .topRight,
                                        .bottomLeft
                                    ]
                            )
                            .onTapGesture {
                                switch sendingPhase {
                                case .sending:
                                    print("sending")
                                case .sent:
                                    withAnimation {
                                        showtimeStamp.toggle()
                                    }
                                case .fail:
                                    withAnimation {
                                        showActionSheet.toggle()
                                    }
                                }
                            }
                    }
                }
                .frame(
                    maxWidth: 230,
                    alignment:
                        isReceived
                        ? .leading
                        : .trailing
                )
            }
            .frame(
                maxWidth: .infinity,
                alignment:
                    isReceived
                    ? .leading
                    : .trailing
            )
            .padding(.vertical, 8)
        }
        .fullScreenCover(isPresented: $showFullImageCover) {
            FullImageCover(message: message, showFullImageCover: $showFullImageCover)
        }
        .actionSheet(
            isPresented: $showActionSheet,
            description: "Your message was not sent. ",
            actionButtonList: [
                ActionButton(label: "Try again", action: {}),
                ActionButton(label: "Delete", action: {})
            ]
        )
    }
}

struct MessageBubble_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            MessageBubble(
                message: .constant("This is the first long long and long test message."),
                timeStamp: .constant("Wed, Mar 15 13:45"),
                isReceived: .constant(true),
                avatarUrl: .constant("https://i.pravatar.cc/150?img=5")
            )
            MessageBubble(
                message: .constant("I got your message."),
                timeStamp: .constant("Wed, Mar 15 13:45"),
                isReceived: .constant(false),
                avatarUrl: .constant("")
            )
            MessageBubble(
                message: .constant("https://i.pravatar.cc/150?img=5"),
                timeStamp: .constant("Wed, Mar 15 13:45"),
                isReceived: .constant(true),
                avatarUrl: .constant("https://i.pravatar.cc/150?img=5")
            )
        }
    }
}

extension MessageBubble {
    struct CircularProgress: View {
        let progress: Double
        
        var body: some View {
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    Color.white,
                    style: StrokeStyle(
                        lineWidth: 4,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeOut, value: progress)
                .frame(width: 42, height: 42)
        }
    }
    
    struct FullImageCover: View {
        @State var message: String = ""
        @Binding var showFullImageCover: Bool
        
        var body: some View {
            ZStack {
                Color.surface3.ignoresSafeArea()
                
                if let url = URL(string: message) {
                    FCAsyncImage(url: url)
                        .aspectRatio(contentMode: .fill)
                        .frame(
                            height:
                                MessageBubble.getHeight(
                                    photoType: FCAsyncImage(url: url).photoType,
                                    width: UIScreen.main.bounds.size.width - 48)
                        )
                        .frame(maxWidth: UIScreen.main.bounds.size.width - 48)
                        .cornerRadius(6)
                        .padding(.horizontal, 24)
                }
                
                VStack {
                    Button {
                        showFullImageCover.toggle()
                    } label: {
                        FCIcon.close
                            .frame(width: 24, height: 24)
                            .foregroundColor(Color.text)
                    }
                }
                .padding(.leading, 16)
                .frame(maxHeight: .infinity, alignment: .top)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
    static func getHeight(photoType: PhotoType, width: CGFloat) -> CGFloat {
        switch photoType {
        case .portrait:
            return width / 0.68
        case .landscape:
            return width / 1.5
        case .square:
            return width
        }
    }
}
