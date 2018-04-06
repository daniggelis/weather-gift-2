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
    
    struct DailyForecast{
        var dailyMaxTemp: Double
        var dailyMinTemp: Double
        var dailyDate: Double
        var dailyIcon: String
        var dailySummary: String
    }
    
    var name = ""
    var coordinates = ""
    var currentTemp = "--"
    var currentSummary = ""
    var currentIcon = ""
    var currentTime = 0.0
    var timeZone = ""
    var dailyForecastArray = [DailyForecast]()
    
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
                //daily summary
                if let summary = json["daily"]["summary"].string {
                    self.currentSummary = summary
                    print("The summary for \(self.name) is \(self.currentSummary).")
                }else{
                    print("couldn't get summary")
                }
                //current icon
                if let icon = json["currently"]["icon"].string {
                    self.currentIcon = icon
                    print("The summary for \(self.name) is \(self.currentSummary).")
                }else{
                    print("couldn't get icon")
                }
                //current timeZone
                if let timeZone = json["timezone"].string {
                    self.timeZone = timeZone
                    print("Timezone for \(self.name) is \(self.timeZone).")
                }else{
                    print("couldn't get timeZone")
                }
                //current time
                if let time = json["currently"]["time"].double {
                    self.currentTime = time
                    print("Time for \(self.name) is \(time).")
                }else{
                    print("couldn't get timeZone")
                }
                let dailyDataArray = json["daily"]["data"]
                self.dailyForecastArray = []
                for day in 1...dailyDataArray.count-1{
                    let maxTemp = json["daily"]["data"][day]["temperatureHigh"].doubleValue
                    let minTemp = json["daily"]["data"][day]["temperatureLow"].doubleValue
                    let dateValue = json["daily"]["data"][day]["time"].doubleValue
                    let icon = json["daily"]["data"][day]["icon"].stringValue
                    let dailySummary = json["daily"]["data"][day]["summary"].stringValue
                    let newDailyForecast = DailyForecast(dailyMaxTemp: maxTemp, dailyMinTemp: minTemp, dailyDate: dateValue, dailyIcon: icon, dailySummary: dailySummary)
                    self.dailyForecastArray.append(newDailyForecast)
                }
            case .failure(let error):
                print(error)
            }
            completed()
        }
    }
}
