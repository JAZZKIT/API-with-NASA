//
//  data.swift
//  API-with-NASA
//
//  Created by Denny on 23.12.2021.
//

import Foundation


// TODO: Refresh knowledge tomorrow
// https://stackoverflow.com/questions/35700281/date-format-in-swift
extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
