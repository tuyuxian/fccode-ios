//
//  MessageInputField.swift
//  FingerCrossed
//
//  Created by Yu-Hsien Tu on 4/2/23.
//

import SwiftUI

struct MessageInputField: View, KeyboardReadable {
    
    @State var message: String = ""
    @State var height: CGFloat = 30
    @State var keyboardHeight: CGFloat = 0
    @State var isKeyboardShowUp: Bool = false
    @State var isMessageSending: Bool = false
    
    @ObservedObject var vm: ChatRoomViewModel
        
    var body: some View {
        HStack(alignment: .bottom, spacing: 6) {
            if isKeyboardShowUp {
                HStack(alignment: .center, spacing: 6) {
                    IconButton(
                        icon: .arrowRight,
                        color: Color.text,
                        action: {}
                    )
                }
                .frame(height: 38)
            } else {
                HStack(alignment: .center, spacing: 6) {
                    IconButton(
                        icon: .camera,
                        color: Color.text,
                        action: {
                            vm.cameraOnTap()
                        }
                    )
                    
                    FCPhotoPicker(selectedImage: $vm.selectedImage) {
                        FCIcon.addPicture
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color.text)
                            .frame(width: 24, height: 24)
                    }
                }
                .frame(height: 38)
                .showAlert($vm.fcAlert)
                .fullScreenCover(
                    isPresented: $vm.showCamera,
                    content: {
                        Camera(
                            selectedImage: $vm.selectedImage
                        )
                        .edgesIgnoringSafeArea(.all)
                    }
                )
            }
            
            HStack(alignment: .bottom, spacing: 0) {
                ZStack(alignment: .leading) {
                    ResizeableTextView(text: $message, height: $height)
                        .frame(height: self.height > 106 ? 106 : self.height)
                        .onReceive(keyboardPublisher) { val in
                            isKeyboardShowUp = val
                        }
                    
                    message.isEmpty
                    ? Text("Aa")
                        .fontTemplate(.pRegular)
                        .foregroundColor(Color.textHelper)
                        .padding(.leading, 4)
                    : nil
                }
                
                !message.isEmpty
                ? HStack(alignment: .center) {
                    if isMessageSending {
                        LottieView(lottieFile: "spinner.json")
                            .frame(width: 36)
                    } else {
                        IconButton(
                            icon: .sent,
                            color: Color.text,
                            action: { print("sent message") }
                        )
                    }
                }
                .frame(height: 36)
                : nil
            }
            .padding(.horizontal, 12)
            .background(Color.white)
            .cornerRadius(self.height > 38 ? 16 : 50)
            .overlay(
                  RoundedRectangle(cornerRadius: self.height > 38 ? 16 : 50)
                    .stroke(Color.surface2, lineWidth: 1)
            )
        }
        .padding(.horizontal, 16)
        .padding(.top, 8)
        .padding(.bottom, 11)
//        .padding(.bottom, self.keyboardHeight)
        .background(Color.background)
        .onAppear {
//            NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidShowNotification, object: nil, queue: .main) {
//                (data) in
//
//                let height1 = data.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
//
//                self.keyboardHeight = height1.cgRectValue.height
//            }
//            NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidHideNotification, object: nil, queue: .main) {
//                (data) in
//
//                let height1 = data.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
//
//                self.keyboardHeight = 0
//            }
        }
    }
}

struct MessageInputField_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            MessageInputField(vm: ChatRoomViewModel())
            
            MessageInputField(message: "testing", isKeyboardShowUp: true, vm: ChatRoomViewModel())
        }
    }
}

struct ResizeableTextView: UIViewRepresentable {
    
    @Binding var text: String
    
    @Binding var height: CGFloat
    
    @State var editing: Bool = false
        
    func makeUIView(
        context: Context
    ) -> UITextView {
        let textView = UITextView()
        textView.isEditable = true
        textView.isScrollEnabled = true
        textView.delegate = context.coordinator
        textView.textColor = UIColor(Color.text)
        textView.backgroundColor = UIColor(Color.white)
        textView.font = UIFont.systemFont(
            ofSize: 16,
            weight: .regular
        )
        return textView
    }
    
    func updateUIView(
        _
        textView: UITextView,
        context: Context
    ) {
        if self.text.isEmpty == true {
            textView.textColor =
                self.editing
                ? UIColor(Color.text)
                : UIColor(Color.textHelper)
        }
        
        DispatchQueue.main.async {
            self.height = textView.contentSize.height
        }
    }
    
    func makeCoordinator() -> Coordinator {
        ResizeableTextView.Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: ResizeableTextView
        
        init(_ params: ResizeableTextView) {
            self.parent = params
        }
        
        func textViewDidBeginEditing(
            _
            textView: UITextView
        ) {
            DispatchQueue.main.async {
               self.parent.editing = true
            }
        }
        
        func textViewDidEndEditing(
            _
            textView: UITextView
        ) {
            DispatchQueue.main.async {
               self.parent.editing = false
            }
        }
        
        func textViewDidChange(
            _
            textView: UITextView
        ) {
            DispatchQueue.main.async {
                self.parent.height = textView.contentSize.height
                self.parent.text = textView.text
            }
        }
    }
}

extension View {
    static func endEditing() {
//        UIApplication.shared.connectedScenes.first.forEach{$0.endEditing(false)}
//        UIApplication.shared.windows.forEach{$0.endEditing(false)}
    }
}
