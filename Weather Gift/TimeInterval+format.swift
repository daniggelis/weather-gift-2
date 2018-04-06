//
//  TimeInterval+format.swift
//  Weather Gift
//
//  Created by Tiffany on 4/6/18.
//  Copyright © 2018 Tiffany. All rights reserved.
//

import Foundation

extension TimeInterval{
    
    func format(timeZone: String, dateFormatter: DateFormatter) -> String{
        let usableDate = Date(timeIntervalSince1970: self)
        dateFormatter.timeZone = TimeZone(identifier: timeZone)
        let dateString = dateFormatter.string(from: usableDate)
        return dateString
    }
}
