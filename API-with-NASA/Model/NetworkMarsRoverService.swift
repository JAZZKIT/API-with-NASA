//
//  NetworkMarsRoverService.swift
//  API-with-NASA
//
//  Created by Denny on 23.12.2021.
//

import Foundation

protocol NetworkMarsRoverServiceDelegate: AnyObject {
    func didFetchMarsInfo(_: NetworkMarsRoverService, with marsPhoto: MarsPhoto)
}

class NetworkMarsRoverService {
    
    weak var delegate: NetworkMarsRoverServiceDelegate?
    
    func fetchMarsInfo(at date: String) {
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
                    self.delegate?.didFetchMarsInfo(self, with: marsData)
                    print(marsData.name)
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
