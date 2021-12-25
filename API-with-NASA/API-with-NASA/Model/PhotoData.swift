//
//  PhotoData.swift
//  API-with-NASA
//
//  Created by Denny on 23.12.2021.
//

import Foundation

struct PhotoData: Codable {
    let photos: [Photo]
}

struct Photo: Codable {
    let rover: Rover
    let imageScr: String
    
    enum CodingKeys: String, CodingKey {
        case rover, imageScr = "img_src"
    }
}

struct Rover: Codable {
    let name: String
}
