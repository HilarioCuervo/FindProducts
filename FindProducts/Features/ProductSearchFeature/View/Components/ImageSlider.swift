//
//  ImageSlider.swift
//  FindProducts
//
//  Created by Hilario Cuervo on 11/02/2024.
//

import SwiftUI

struct ImageSlider: View {
    
    var pictures: [Picture]
    
    init(pictures: [Picture]) {
        self.pictures = pictures
        
        UIPageControl.appearance().currentPageIndicatorTintColor = .black.withAlphaComponent(0.8)
        UIPageControl.appearance().pageIndicatorTintColor = .black.withAlphaComponent(0.2)
    }
    
    var body: some View {
        TabView {
            ForEach(pictures) { picture in
                URLImageView(urlString: picture.url)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

struct ImageSlider_Previews: PreviewProvider {
    static var previews: some View {
        ImageSlider(pictures: [Picture(id: "724385-MLA74331925070_022024", url: "http://http2.mlstatic.com/D_724385-MLA74331925070_022024-O.jpg"),
                              Picture(id: "852838-MLA74331915162_022024", url: "http://http2.mlstatic.com/D_852838-MLA74331915162_022024-O.jpg"),
                              Picture(id: "746586-MLA74331895288_022024", url: "http://http2.mlstatic.com/D_746586-MLA74331895288_022024-O.jpg"),
                              Picture(id: "826554-MLA74331895292_022024", url: "http://http2.mlstatic.com/D_826554-MLA74331895292_022024-O.jpg")])
    }
}
