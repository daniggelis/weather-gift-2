//
//  WeatherLocation.swift
//  Weather Gift
//
//  Created by Tiffany on 4/7/18.
//  Copyright © 2018 Tiffany. All rights reserved.
//

import Foundation

class WeatherLocation: Codable{
    var name: String
    var coordinates: String
    
    init(name: String, coordinates: String){
        self.name = name
        self.coordinates = coordinates
    }
}

