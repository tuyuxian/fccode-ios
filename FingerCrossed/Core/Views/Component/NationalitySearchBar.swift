//
//  NationalitySearchBar.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/26/23.
//

import SwiftUI

struct NationalitySearchBar: View {
    
    @ObservedObject var vm: NationalityViewModel
    
    @Binding var nationalityList: [Nationality]
    
    @FocusState private var isSearchBarFocused
    
    @Binding var countryName: String
        
    @State var isDisplay: Bool = false
    
    @State var isSheet: Bool
    
    @State var test: String = ""
    
    var body: some View {
        ZStack(
            alignment: Alignment(
                horizontal: .leading,
                vertical: .top
            )
        ) {
            if nationalityList.count >= 1 {
                VStack(
                    alignment: .leading,
                    spacing: 0
                ) {
                    nationalityList.count >= 3
                    ? nil
                    : isDisplay
                        ? nil
                        : TextField("",
                              text: $countryName,
                              prompt: Text("Search")
                                        .foregroundColor(.textHelper)
                                        .font(
                                            Font.system(
                                                size: 16,
                                                weight: .regular
                                            )
                                        )
                        )
                        .fontTemplate(.pRegular)
                        .foregroundColor(Color.text)
                        .frame(height: 36)
                        .padding(.leading, 6) // 16 - 10
                        .padding(.trailing, 40) // 16 + 24
                        .focused($isSearchBarFocused)
                        .onAppear {
                            isSearchBarFocused = false
                        }
                    
                    nationalityList.count >= 3
                    ? nil
                    : isDisplay
                        ? nil
                        : Divider()
                            .overlay(Color.surface2)
                            .frame(height: 1)
                            .padding(.vertical, 9.5)
                    
                    if isSheet {
                        ScrollView(
                            .horizontal,
                            showsIndicators: false
                        ) {
                            HStack(
                                alignment: .center,
                                spacing: 10
                            ) {
                                ForEach(nationalityList) { selected in
                                    NationalityTag(
                                        nationality: selected,
                                        action: {
                                            nationalityList.removeAll(
                                                where: { $0 == selected }
                                            )
                                        }
                                    )
                                }
                            }
                        }
                        .mask(
                            HStack(spacing: 0) {
                                Rectangle().fill(Color.white)
                                LinearGradient(gradient:
                                   Gradient(
                                       colors: [Color.white, Color.white.opacity(0)]),
                                       startPoint: .leading, endPoint: .trailing
                                   )
                                   .frame(width: 50)
                            }
                        )
                    } else {
                        VStack(
                            alignment: .leading,
                            spacing: 10
                        ) {
                            ForEach(nationalityList) { selected in
                                NationalityTag(
                                    nationality: selected,
                                    action: {
                                        nationalityList.removeAll(
                                            where: { $0 == selected }
                                        )
                                    }
                                )
                            }
                        }
                    }
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 10)
            } else {
                HStack {
                    TextField(
                        "",
                        text: $countryName,
                        prompt: Text("Search")
                                    .foregroundColor(.textHelper)
                                    .font(
                                        Font.system(
                                            size: 16,
                                            weight: .regular
                                        )
                                    )
                    )
                    .fontTemplate(.pRegular)
                    .foregroundColor(Color.text)
                    .frame(height: 36)
                    .padding(.leading, 16)
                    .padding(.trailing, 40)
                    .focused($isSearchBarFocused)
                    .onAppear {
                        isSearchBarFocused = false
                    }
                }
            }
            
            nationalityList.count >= 3 && isSheet
            ? nil
            : HStack {
                Spacer()
                
                FCIcon.search
                    .foregroundColor(Color.text)
                    .frame(width: 24, height: 36)
            }
            .padding(.trailing, 16)
        }
        .frame(
            height:
                flexibleHeight(
                    count: nationalityList.count,
                    isSheet: isSheet
                )
        )
        .background(
            RoundedRectangle(
                cornerRadius: nationalityList.count >= 1
                ? isDisplay && nationalityList.count == 1
                    ? 50
                    : 26
                : 50
            )
            .stroke(Color.surface2, lineWidth: 1)
            .background(
                RoundedRectangle(
                    cornerRadius: nationalityList.count >= 1
                    ? isDisplay && nationalityList.count == 1
                        ? 50
                        : 26
                    : 50
                )
                .fill(Color.white)
            )
        )
    }
    
    private func flexibleHeight (
        count: Int,
        isSheet: Bool
    ) -> CGFloat {
        if isSheet {
            if count > 0 && count < 3 {
                return 112.0
            } else {
                return 56.0
            }
        } else {
            if count == 3 {
                return 148.0
            } else if count == 2 {
                return 102.0
            } else {
                return 56.0
            }
        }
    }
}

struct NationalitySearchBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            NationalitySearchBar(
                vm: NationalityViewModel(),
                nationalityList: .constant([]),
                countryName: .constant("Taiwan"),
                isSheet: true
            )
            NationalitySearchBar(
                vm: NationalityViewModel(),
                nationalityList: .constant([
                    Nationality(
                        name: "Taiwan",
                        code: "TW"
                    )
                ]),
                countryName: .constant(""),
                isSheet: true
            )
        }
        .padding(.horizontal, 24)
    }
}

extension NationalitySearchBar {
    
    struct NationalityTag: View {
        
        @State var nationality: Nationality

        var action: () -> Void = {}
        
        var body: some View {
            HStack(spacing: 8) {
                Text(nationality.name)
                    .fontTemplate(.pMedium)
                    .foregroundColor(Color.text)
                
                Button {
                    action()
                } label: {
                    FCIcon.closeCircleYellow
                        .resizable()
                        .frame(width: 24, height: 24)
                }
            }
            .padding(.horizontal, 10)
            .frame(height: 36)
            .background(
                RoundedRectangle(cornerRadius: 50)
                    .fill(Color.yellow20)
            )
        }
    }
    
}
