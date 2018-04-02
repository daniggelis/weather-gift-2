//
//  WeatherLocation.swift
//  Weather Gift
//
//  Created by Tiffany on 3/27/18.
//  Copyright © 2018 Tiffany. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class WeatherLocation {
    var name = ""
    var coordinates = ""
    var currentTemp = "--"
    
    func getWeather(completed: @escaping () -> ()){
        let weatherURL = urlBase + urlAPIKey + coordinates
        
        Alamofire.request(weatherURL).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let temperature = json["currently"]["temperature"].double {
                    print("temp:\(temperature)")
                    let roundedTemp = String(format: "%3.f", temperature)
                    self.currentTemp = roundedTemp + "°"
                }else{
                    print("couldn't get temperature")
                }
            case .failure(let error):
                print(error)
            }
            completed()
        }
    }
}
