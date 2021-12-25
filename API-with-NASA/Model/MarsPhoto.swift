//
//  MarsPhoto.swift
//  API-with-NASA
//
//  Created by Denny on 24.12.2021.
//

import Foundation

struct MarsPhoto: Codable {
    let name: String
    let imageURL: String
    
    init?(currentPhotoData: PhotoData) {
        guard let photoData = currentPhotoData.photos.first else {
            return nil
        }
        name = photoData.rover.name
        
        imageURL = photoData.imageScr
    }
}
