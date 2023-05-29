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
                    spacing: 10
                ) {
                    if nationalityList.contains(where: { $0.name == "Open to all" }) {
                        HStack(spacing: 8) {
                            Text("Open to all")
                                .fontTemplate(.pMedium)
                                .foregroundColor(Color.text)
                            
                            Button {
                                nationalityList.removeAll()
                            } label: {
                                Image("CloseCircle")
                                    .resizable()
                                    .frame(
                                        width: 24,
                                        height: 24
                                    )
                            }
                        }
                        .padding(.vertical, 6)
                        .frame(height: 36)
                        .background(
                            RoundedRectangle(cornerRadius: 50)
                                .fill(Color.yellow20)
                        )
                    } else {
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
                            .focused($isSearchBarFocused)
                            .onAppear {
                                isSearchBarFocused = false
                            }
                        
                        nationalityList.count >= 3
                        ? nil
                        : isDisplay ? nil : Divider().overlay(Color.surface2)
                        
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
                    .focused($isSearchBarFocused)
                    .onAppear {
                        isSearchBarFocused = false
                    }
                }
            }
            
            Image("search")
                .foregroundColor(Color.text)
                .frame(height: 36)
                .frame(
                    maxWidth: .infinity,
                    alignment: .trailing
                )
        }
        .frame(
            height:
                flexibleHeight(
                    count: nationalityList.count,
                    isDisplay: isDisplay
                )
        )
        .padding(.horizontal, 16)
        .background(
            RoundedRectangle(
                cornerRadius: nationalityList.count >= 1
                ? isDisplay && nationalityList.count == 1
                    ? 50
                    : 16
                : 50
            )
            .stroke(Color.surface2, lineWidth: 1)
            .background(
                RoundedRectangle(
                    cornerRadius: nationalityList.count >= 1
                    ? isDisplay && nationalityList.count == 1
                        ? 50
                        : 16
                    : 50
                )
                .fill(Color.white)
            )
        )
    }
    
    private func flexibleHeight (count: Int, isDisplay: Bool) -> CGFloat {
        if count >= 3 && count < 200 {
            return 160.0
        } else if count >= 2 && count < 200 {
            return isDisplay ? 108.0 : 160.0
        } else if count >= 1 && count < 200 {
            return isDisplay ? 56.0 : 108.0
        } else {
            return 54.0
        }
    }
}

struct NationalitySearchBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            NationalitySearchBar(
                vm: NationalityViewModel(),
                nationalityList: .constant([]),
                countryName: .constant("Taiwan")
            )
            NationalitySearchBar(
                vm: NationalityViewModel(),
                nationalityList: .constant([
                    Nationality(
                        name: "Taiwan",
                        code: "TW"
                    )
                ]),
                countryName: .constant("")
            )
        }
        .padding(.horizontal, 24)
    }
}
