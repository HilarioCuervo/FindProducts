//
//  SearchBar.swift
//  FindProducts
//
//  Created by Hilario Cuervo on 05/02/2024.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var searchedText: String
    @State var showSearchBar: Bool = false
    
    var height: CGFloat
    var width: CGFloat
    var iconSize: CGFloat
    
    var onSearch: () -> Void

    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke(lineWidth: 3)
                    .foregroundColor(.primaryColor)
                HStack(spacing: 25) {
                    Image(systemName: .searchIcon)
                        .foregroundColor(.primaryColor)
                        .font(.system(size: iconSize, weight: .medium))
                        .offset(x: showSearchBar ? 10 : 16 )
                        .frame(width: height * 0.75, height: height)
                        .onTapGesture {
                            showSearchBar = true
                    }
                    TextField(String.textFieldPlaceholder.toLocalizedStringKey(), text: $searchedText)
                        .font(.system(size: iconSize * 0.8, weight: .regular))
                        .foregroundColor(.black)
                        .opacity(showSearchBar ? 1 : 0)
                        .padding(.trailing, 8)
                        .submitLabel(.search)
                        .onSubmit(onSearch)
                }
            }
            .frame(width: showSearchBar ? width : height, height: height)
            .offset(x: showSearchBar ? 0 : 30)
            .foregroundColor(.white)
            .animation(.spring(response: 0.6, dampingFraction: 0.9, blendDuration: 0), value: showSearchBar)
            
            ZStack {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .frame(width: height, height: height)
                    .foregroundColor(.primaryColor)
                Image(systemName: .closingCrossIcon)
                    .foregroundColor(.white)
                    .font(.system(size: iconSize, weight: .medium))
            }
            .offset(x: showSearchBar ? 0 : 1000)
            .animation(.spring(response: 0.5, dampingFraction: 0.9, blendDuration: 0), value: showSearchBar)
            .onTapGesture {
                searchedText = .emptyText
            }
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(searchedText: .constant(.emptyText), height: 45, width: 300, iconSize: 22, onSearch: { return })
    }
}
