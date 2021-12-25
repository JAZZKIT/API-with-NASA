//
//  ViewController.swift
//  API-with-NASA
//
//  Created by Denny on 23.12.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var lableName: UILabel!
    @IBOutlet weak var dataPicker: UIDatePicker!
    
    var networkMarsRoverService = NetworkMarsRoverService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        networkMarsRoverService.delegate = self
    }
    
    @IBAction func searchPressed(_ sender: Any) {
        let date = dataPicker.date.getFormattedDate(format: "yyyy-MM-dd")
        print(date)
        networkMarsRoverService.fetchMarsInfo(at: date)
        
    }
    
    @IBAction func changeDate(_ sender: UIDatePicker) {
        print(sender.date)
    }
}

extension ViewController: NetworkMarsRoverServiceDelegate {
    func didFetchMarsInfo(_: NetworkMarsRoverService, with marsPhoto: MarsPhoto) {
        let url = URL(string: marsPhoto.imageURL)!
        do{
            let data = try Data(contentsOf: url)
            DispatchQueue.main.async {
                self.lableName.text = marsPhoto.name
                self.image.image = UIImage(data: data)
            }
        } catch let error as NSError{
            print(error)
        }
    }
}

