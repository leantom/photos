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
    @State private var menus = ["Home", "Fantasy", "Anime", "Flower"]
    @State var photos = [Hits]()
    @State var selectedMenu: String?
    
    let network = Network.shared
    var body: some View {
        
        NavigationView {
            
            HStack(alignment: .top, spacing: 20) {
                List(selection: $selectedMenu) {
                    ForEach(menus, id:\.self) { titleMenu in
                        NavigationLink(destination: DetailView(keyword: titleMenu), tag: titleMenu, selection: self.$selectedMenu) {
                            VStack{
                                Text(titleMenu)
                            }
                        }
                    }
                }
                .listStyle(.sidebar)
                .onAppear {
                    self.selectedMenu = "Home"
                }
            }
           
        }
        .listStyle(.grouped)
        .navigationTitle(Text("Options"))
    
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
        AsyncImage(url: url) { image in
            image
                .resizable()
                .scaledToFit()
                .cornerRadius(10)
                
        } placeholder: {
            ProgressView()
        }
            
    }
}



