//
//  Quake.swift
//  QuakeDecode
//
//  Created by Tomohiro Tashiro on 7/30/17.
//  Copyright © 2017 test. All rights reserved.
//

import Foundation

struct QuakeList: Decodable {
    let list: [Quake]
    private enum CodingKeys: String, CodingKey {
        case list = "quake"
    }
}

struct Quake: Decodable {
    let name: String
    let spot: String
    let cell_atime: String
    let atimeString: String
    let latlon: String
    let magnitude: String
    let depth: String
    let maxclass: String
    let wave: String
    let points: String
    let image: String
}

class QuakeLoader {
    static let api = "https://gist.githubusercontent.com/tashiro-wni/b9f66b5841edacd77cae02eb8c8fd329/raw/5659624003751ea9ceed561bf7fc743ffb93a545/quake.json"
    
    class func get(completion: @escaping (_ quakeList: [Quake]?) -> Void) {
        guard let url = URL(string: api) else {
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                print("http get error")
                completion(nil)
                return
            }
            
            guard let list = try? JSONDecoder().decode(QuakeList.self, from: data) else {
                print("json decode error")
                completion(nil)
                return
            }
                
            completion(list.list)
        }
        task.resume()
    }
}
