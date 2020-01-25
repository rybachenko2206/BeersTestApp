//
//  Beer.swift
//  BeersTestApp
//
//  Created by Roman Rybachenko on 24.01.2020.
//  Copyright © 2020 Roman Rybachenko. All rights reserved.
//

import Foundation

struct Beer: Decodable {
    let id: Int
    let name: String
    let tagline: String?
    let description: String?
    let imageUrl: URL?
    
    enum CodingKeys: String, CodingKey {
        case id, name, tagline, description
        case imageUrl = "image_url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.tagline = try? container.decode(String.self, forKey: .tagline)
        self.description = try? container.decode(String.self, forKey: .description)
    
        let urlStr = try? container.decode(String.self, forKey: .imageUrl)
        self.imageUrl = URL(string: urlStr ?? "")
    }
}


struct GetBeersParameters {
    let page: Int
    let countPerPage: Int
    
    struct Keys {
        static let kPage = "page"
        static let kCountPerPage = "per_page"
    }
    
    var queryItems: [URLQueryItem] {
        return [
             URLQueryItem(name: Keys.kPage, value: page.description),
             URLQueryItem(name: Keys.kCountPerPage, value: countPerPage.description)
        ]
    }
}
