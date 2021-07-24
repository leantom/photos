//
//  DetailView.swift
//  DetailView
//
//  Created by quang on 24/07/2021.
//

import Foundation
import SwiftUI

struct DetailView: View {
    var keyword: String
    var gridItemLayout = [GridItem(.flexible()),
                          GridItem(.flexible()),
                          GridItem(.flexible()),
                          GridItem(.flexible())]
    @State var photos = [Hits]()
    @State private var showingSheet = false
    @State var photoURLSelected = ""
    
    let network = Network.shared
    var body: some View {
        
        if self.showingSheet {
            PhotoView(url: $photoURLSelected)
        } else {
            ScrollView {
                LazyVGrid(columns: gridItemLayout, spacing: 20) {
                    ForEach(photos, id: \.self) { url in
                        ImageView(url: url.previewURL!)
                            .onTapGesture {
                                self.photoURLSelected = url.largeImageURL!
                                self.showingSheet.toggle()
                            }
                            .onAppear {
                                if url == photos.last {
                                    print("last object")
                                }
                            }
                        
                    }
                }
                .padding()
                .onAppear {
                    network.getPhotos(keyword: keyword) { photos in
                        self.photos = photos
                    }
                }.navigationTitle(keyword)
            }
        }
        
    }
}
