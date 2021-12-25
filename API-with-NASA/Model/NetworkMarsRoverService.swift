//
//  NetworkMarsRoverService.swift
//  API-with-NASA
//
//  Created by Denny on 23.12.2021.
//

import Foundation


class NetworkMarsRoverService {
    
    
    func fetchMarsInfo(at date: String, complitionHandler: @escaping (MarsPhoto) -> Void) {
        // 1
        let urlString = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?earth_date=\(date)&api_key=\(apiKey)"
        print(urlString)
        
        // 2
        guard let url = URL(string: urlString) else {
            return
        }
        
        // 3
        let session = URLSession(configuration: .default)
        
        // 4
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                if let marsData = self.parseJSON(with: data) {
                    complitionHandler(marsData)
                }
            }
        }
        task.resume()
    }
    
    func parseJSON(with data: Data) -> MarsPhoto? {
        let decoder = JSONDecoder()
        do {
            let photoData = try decoder.decode(PhotoData.self, from: data)
            guard let marsPhoto = MarsPhoto(currentPhotoData: photoData) else {
                return nil
            }
            return marsPhoto
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
}
