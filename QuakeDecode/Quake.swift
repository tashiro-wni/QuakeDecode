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
        let task = URLSession.shared.dataTask(with: URL(string: api)!) { (data, response, error) in
            guard let data = data else {
                print("http get error")
                completion(nil)
                return
            }
            
            do {
                let list = try JSONDecoder().decode(QuakeList.self, from: data)
                completion(list.list)
            } catch {
                print("json decode error")
                completion(nil)
            }
        }
        task.resume()
    }
}
