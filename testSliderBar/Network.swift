//
//  Network.swift
//  testSliderBar
//
//  Created by quang on 12/07/2021.
//

import Foundation

class Network: NSObject {
    let key_api = "10464551-1b433fcb67ed477973abbf66a"
    static let shared = Network()
    
    func getPhotos(keyword: String,
                   completion:@escaping ([Hits]) ->()) {
        guard let url = URL(string: "https://pixabay.com/api/?key=\(key_api)&q=\(keyword)&image_type=photo&pretty=true&per_page=30") else {return}
     
        let task = URLSession.shared.dataTask(with: url) { data, response, err in
            guard let data = data, err == nil else {
                print(err?.localizedDescription as Any)
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                let responseModel = try? jsonDecoder.decode(PhotoModel.self, from: data)
                if let _photos = responseModel,
                   let _hits = _photos.hits{
                    completion(_hits)
                }
            }
        }
        task.resume()
    }
    
}
