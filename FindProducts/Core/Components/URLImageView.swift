//
//  URLImageView.swift
//  FindProducts
//
//  Created by Hilario Cuervo on 08/02/2024.
//

import SwiftUI

struct URLImageView: View {
    
    var urlString: String?
    
    var body: some View {
        
        let correctUrlString: String = .scheme + (urlString?.dropFirst(4) ?? "")
        let url = URL(string: correctUrlString)
        
        AsyncImage(url: url) { phase in
            switch phase {
                
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                
            case .failure(let error):
                
                if error.localizedDescription == "cancelled" {
                    URLImageView(urlString: urlString)
                } else {
                    Image(systemName: .failImageIcon)
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.primaryColor)
                        .padding(40)
                }
                
            case .empty:
                Image(systemName: .emptyImageIcon)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.primaryColor)
                    .padding(40)
                
            @unknown default:
                Image(systemName: .failImageIcon)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.primaryColor)
                    .padding(40)
            }
        }
    }
}

struct URLImageView_Previews: PreviewProvider {
    static var previews: some View {
        URLImageView(urlString: "http://http2.mlstatic.com/D_724385-MLA74331925070_022024-I.jpg")
    }
}
