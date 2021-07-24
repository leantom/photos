//
//  PhotoView.swift
//  PhotoView
//
//  Created by quang on 24/07/2021.
//

import SwiftUI

struct PhotoView: View {
   @Binding var url: String
    var body: some View {
        let urlAbsolute = URL(string:url)
        ZStack(alignment: .bottomLeading) {
            AsyncImage(url: urlAbsolute) { image in
                image
                    .resizable()
                    .scaledToFit().overlay(Text("❤️"), alignment: .bottomLeading)
            } placeholder: {
                ProgressView()
            }.padding()
                .onTapGesture {
                    print(urlAbsolute?.absoluteString as Any)
                }
           
        }
        
        
    }
   
}


