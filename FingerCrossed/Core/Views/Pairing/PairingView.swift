//
//  PairingView.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/16/23.
//

import SwiftUI

struct PairingView: View {
    @State var candidates: [CandidateModel] = CandidateModel.MockCandidates
    @State var currentCandidate = 0
    
    @StateObject private var vm = PairingViewModel()
    
    var body: some View {
        ZStack {
            if vm.state == .loading || candidates.isEmpty {
                CandidateShimmer()
            } else {
                VStack(spacing: 0) {
                    GeometryReader { geometry in
                        withAnimation(.interactiveSpring()) {
                            TabView(selection: $currentCandidate) {
                                ForEach(
                                    candidates,
                                    id: \.self.id
                                ) { candidate in
                                    
                                    CandidateView(
                                        candidate: candidate
                                    )
                                    .rotationEffect(.init(degrees: -90))
                                    .frame(width: geometry.size.width, height: geometry.size.height)
                                    .ignoresSafeArea(.all, edges: .top)
                                    .tag(candidates.firstIndex(where: { $0 == candidate })!)
                                    .id(candidate.id)
                                }
                            }
                            .frame(width: geometry.size.height)
                            .rotationEffect(.init(degrees: 90))
                            .tabViewStyle(.page(indexDisplayMode: .never))
                            .frame(width: geometry.size.width)
                            .onTapGesture(count: 2) {
                                withAnimation {
                                    currentCandidate += 1
                                }
                            }
                        }
                    }
                    .ignoresSafeArea(.all, edges: .top)
                }
                .background(Color.surface4)
            }
            
            vm.isNewUser
            ? Instruction(step: vm.instructionStep)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    Color.surface4.opacity(0.8)
                )
                .onTapGesture {
                    if vm.instructionStep < 3 {
                        vm.instructionStep += 1
                    } else {
                        vm.isNewUser = false
                    }
                }
            : nil
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation(.spring()) {
                    vm.state = .complete
                }
            }
        }
    }
}

struct PairingView_Previews: PreviewProvider {
    static var previews: some View {
        PairingView()
    }
}

extension PairingView {
    
    struct Instruction: View {
        
        var step: Int
        
        var body: some View {
            switch step {
            case 1:
                PairingView.InstructionSwipLeftRight()
            case 2:
                PairingView.InstructionSwipUp()
            case 3:
                PairingView.InstructionDoubleTap()
            default:
                PairingView.InstructionDefaultItem()
            }
        }
    }
    
    struct InstructionSwipLeftRight: View {
        var body: some View {
            VStack {
                HStack {
                    LottieView(lottieFile: "swipeLeft.json")
                        .frame(width: 160, height: 160)
                    
                    LottieView(lottieFile: "swipeRight.json")
                        .frame(width: 160, height: 160)
                }
                .padding(.bottom, 100)
                
                Text("Swipe Left/Right to See Photos")
                    .fontTemplate(.h3Bold)
                    .foregroundColor(Color.white)
                
                Text("(Tap to continue)")
                    .fontTemplate(.h4Medium)
                    .foregroundColor(Color.white)
            }
        }
    }
    
    struct InstructionSwipUp: View {
        var body: some View {
            VStack {
                LottieView(lottieFile: "swipeUp.json")
                    .frame(width: 160, height: 160)
                    .padding(.bottom, 100)
                
                Text("Swipe Up to Dislike")
                    .fontTemplate(.h3Bold)
                    .foregroundColor(Color.white)
                
                Text("(Tap to continue)")
                    .fontTemplate(.h4Medium)
                    .foregroundColor(Color.white)
            }
        }
    }
    
    struct InstructionDoubleTap: View {
        var body: some View {
            VStack {
                LottieView(lottieFile: "doubleTap.json")
                    .frame(width: 160, height: 160)
                    .padding(.bottom, 100)
                
                Text("Double Tap to Like a Person")
                    .fontTemplate(.h3Bold)
                    .foregroundColor(Color.white)
                
                Text("(Tap to continue)")
                    .fontTemplate(.h4Medium)
                    .foregroundColor(Color.white)
            }
        }
    }
    
    struct InstructionDefaultItem: View {
        var body: some View {
            VStack {
                LottieView(lottieFile: "spinner.json")
                    .frame(width: 160, height: 160)
                    .padding(.bottom, 100)
                
                Text("Hold on, we're working on it")
                    .fontTemplate(.h3Bold)
                    .foregroundColor(Color.white)
            }
        }
    }
}

extension PairingView {
    
    struct CandidateShimmer: View {
        var body: some View {
            VStack(spacing: 0) {
                Spacer()
                
                VStack(alignment: .leading, spacing: 10) {
                    Shimmer(
                        primaryColor: Color.text,
                        size: CGSize(width: 115, height: 30)
                    )
                    Shimmer(
                        primaryColor: Color.text,
                        size: CGSize(width: 200, height: 20)
                    )
                    Shimmer(
                        primaryColor: Color.text,
                        size: CGSize(width: 332, height: 20)
                    )
                }
                .padding(.bottom, 34)
            }
            .frame(width: UIScreen.main.bounds.width)
            .background(Color.surface4)
            .edgesIgnoringSafeArea(.all)
        }
    }
    
}
