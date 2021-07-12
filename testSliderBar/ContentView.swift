//
//  ContentView.swift
//  testSliderBar
//
//  Created by quang on 12/07/2021.
//

import SwiftUI
import Combine
import UIKit

struct ContentView: View {
    @State var isShowingDetailView = false
    @State private var menus = ["Fantasy", "Anime", "Flower"]
    @State var photos = [Hits]()
    
    let network = Network.shared
    var body: some View {
        
        NavigationView {
            List(menus, id: \.self) { titleMenu in
                
                NavigationLink(destination: DetailView(keyword: titleMenu)){
                        VStack{
                            Text(titleMenu.lowercased())
                        }
                    }
            }
            .listStyle(.sidebar)
        }
        .listStyle(.automatic)
        .navigationTitle(Text("Options"))
    }
}

struct DetailView: View {
    var keyword: String
    var gridItemLayout = [GridItem(.flexible()),
                          GridItem(.flexible()),
                          GridItem(.flexible()),
                          GridItem(.flexible())]
    
    @State var photos = [Hits]()
    let network = Network.shared
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridItemLayout, spacing: 20) {
                ForEach(photos, id: \.self) { url in
                    ImageView(url: url.previewURL!)
                }
            }
            .onAppear {
                network.getPhotos(keyword: keyword) { photos in
                    self.photos = photos
                }
            }.navigationTitle(keyword)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ImageView: View {
    var url: String
    var body: some View {
        let url = URL(string:url)
        AsyncImage(url: url)
            .cornerRadius(5)
            .onTapGesture {
                print(url?.absoluteString as Any)
            }
    }
}



