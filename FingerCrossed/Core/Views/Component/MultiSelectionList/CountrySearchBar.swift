//
//  CountrySearchBar.swift
//  FingerCrossed
//
//  Created by Lawrence on 4/26/23.
//

import SwiftUI

struct CountrySearchBar: View {
    @State var countryViewModel: CountryViewModel = CountryViewModel()
    @ObservedObject var countrySelectionList: CountrySelectionList
    @Binding var countryName: String
    @FocusState private var isSearchBarFocused
    @State var isDisplay = false
    
    var body: some View {
        HStack(
            alignment: .top,
            spacing: 0
        ) {
            if countrySelectionList.countrySelections.count >= 1 {
                VStack(
                    alignment: .leading,
                    spacing: 10
                ) {
                    if countrySelectionList.countrySelections.contains(where: { $0.name == "Open to all" }) {
                        HStack(spacing: 8) {
                            Text("Open to all")
                                .padding(.leading, 10)
                                .padding(.vertical, 6)
                            
                            Button {
                                countrySelectionList.countrySelections.removeAll()
                            } label: {
                                Image("CloseCircle")
                                    .resizable()
                                    .frame(
                                        width: 24,
                                        height: 24
                                    )
                            }
                            .padding(.trailing, 10)
                            .padding(.vertical, 6)
                        }
                        .frame(height: 36)
                        .background(
                            RoundedRectangle(cornerRadius: 50)
                                .fill(Color.yellow20)
                        )
                    }
                    else {
                        countrySelectionList.countrySelections.count >= 3
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
                            .frame(height: 24)
                            .padding(.leading, 8)
                            .padding(.bottom, 0)
                            .focused($isSearchBarFocused)
                            .onAppear {
                                isSearchBarFocused = false
                            }
                        
                        VStack(
                            alignment: .leading,
                            spacing: 10
                        ) {
                            countrySelectionList.countrySelections.count >= 3
                            ? nil
                            : isDisplay ? nil : Divider()
                            
                            ForEach(countrySelectionList.countrySelections) { countryselected in
                                
                                HStack(spacing: 8) {
                                    Text(countryselected.name)
                                        .padding(.leading, 10)
                                        .padding(.vertical, 6)
                                    
                                    Button {
                                        countrySelectionList.countrySelections.removeAll(
                                            where: { $0 == countryselected }
                                        )
                                    } label: {
                                        Image("CloseCircle")
                                            .resizable()
                                            .frame(
                                                width: 24,
                                                height: 24
                                            )
                                    }
                                    .padding(.trailing, 10)
                                    .padding(.vertical, 6)
                                }
                                .frame(height: 36)
                                .background(
                                    RoundedRectangle(cornerRadius: 50)
                                        .fill(Color.yellow20)
                                )
                            }
                        }
                    }
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            } else {
                HStack {
                    HStack(spacing: 8.0) {
                        ForEach(countrySelectionList.countrySelections) { countryselected in
                            
                            HStack(spacing: 8.0) {
                                Text(countryselected.name)
                                    .padding(.leading, 10)
                                    .padding(.vertical, 6)
                                
                                Button {
                                    countrySelectionList.countrySelections.removeAll(
                                        where: { $0 == countryselected }
                                    )
                                } label: {
                                    Image("CloseCircle")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                }
                                .padding(.trailing, 10)
                                .padding(.vertical, 6)
                            }
                            .frame(height: 36)
                            .background(
                                RoundedRectangle(cornerRadius: 50)
                                    .fill(Color.yellow20)
                            )
                        }
                    }
                    
                    TextField("",
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
                    .focused($isSearchBarFocused)
                    .onAppear {
                        isSearchBarFocused = false
                    }
                }
            }
            
            Image(systemName: "magnifyingglass").foregroundColor(Color.text)
                .padding(.top, 5)
        }
        .environmentObject(countrySelectionList)
        .frame(maxWidth: .infinity)
        .frame(
            height:
                flexibleHeight(
                    count: countrySelectionList.countrySelections.count,
                    isDisplay: isDisplay
                )
        )
        .padding(.horizontal, 16)
        .background(
            RoundedRectangle(cornerRadius: countrySelectionList.countrySelections.count >= 1 ? 26 : 50)
                .stroke(Color.surface2, lineWidth: 1)
                .background(
                    RoundedRectangle(
                        cornerRadius: countrySelectionList.countrySelections.count >= 1 ? 26 : 50
                    )
                    .fill(Color.white)
                )
        )
    }
    
    func flexibleHeight (count: Int, isDisplay: Bool) -> CGFloat {
        if count >= 3 {
            return 160.0
        } else if count >= 2 {
            return isDisplay ? 108.0 : 160.0
        } else if count >= 1 {
            return isDisplay ? 56.0 : 108.0
        } else {
            return 56.0
        }
    }
}

private var value: Binding<String> {
    Binding.constant("Value")
}

struct CountrySearchBar_Previews: PreviewProvider {
    static var previews: some View {
        CountrySearchBar(
            countrySelectionList: CountrySelectionList(countrySelections: [CountryModel]()),
            countryName: value
        )
    }
}
