//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by Chandra Rao on 14/11/19.
//  Copyright © 2019 Chandra Rao. All rights reserved.
//

import Foundation

struct WeatherResponse : Codable {
    let latitude : Double?
    let longitude : Double?
    let timezone : String?
    let currently : Currently?
    let minutely : Minutely?
    let hourly : Hourly?
    let daily : Daily?
    let flags : Flags?
    let offset : Double?

    enum CodingKeys: String, CodingKey {
        
        case latitude = "latitude"
        case longitude = "longitude"
        case timezone = "timezone"
        case currently = "currently"
        case minutely = "minutely"
        case hourly = "hourly"
        case daily = "daily"
        case flags = "flags"
        case offset = "offset"
    }
}

struct Currently : Codable {
    let time : Double?
    let summary : String?
    let icon : String?
    let nearestStormDistance : Double?
    let precipIntensity : Double?
    let precipIntensityError : Double?
    let precipProbability : Double?
    let precipType : String?
    let temperature : Double?
    let apparentTemperature : Double?
    let dewPoint : Double?
    let humidity : Double?
    let pressure : Double?
    let windSpeed : Double?
    let windGust : Double?
    let windBearing : Double?
    let cloudCover : Double?
    let uvIndex : Double?
    let visibility : Double?
    let ozone : Double?
    
    enum CodingKeys: String, CodingKey {
        
        case time = "time"
        case summary = "summary"
        case icon = "icon"
        case nearestStormDistance = "nearestStormDistance"
        case precipIntensity = "precipIntensity"
        case precipIntensityError = "precipIntensityError"
        case precipProbability = "precipProbability"
        case precipType = "precipType"
        case temperature = "temperature"
        case apparentTemperature = "apparentTemperature"
        case dewPoint = "dewPoint"
        case humidity = "humidity"
        case pressure = "pressure"
        case windSpeed = "windSpeed"
        case windGust = "windGust"
        case windBearing = "windBearing"
        case cloudCover = "cloudCover"
        case uvIndex = "uvIndex"
        case visibility = "visibility"
        case ozone = "ozone"
    }
}

struct Daily : Codable {
    let summary : String?
    let icon : String?
    let data : [WeatherData]?
    
    enum CodingKeys: String, CodingKey {
        
        case summary = "summary"
        case icon = "icon"
        case data = "data"
    }
    
}

struct WeatherData : Codable {
    let time : Double?
    let summary : String?
    let icon : String?
    let sunriseTime : Double?
    let sunsetTime : Double?
    let moonPhase : Double?
    let precipIntensity : Double?
    let precipIntensityMax : Double?
    let precipIntensityMaxTime : Double?
    let precipProbability : Double?
    let temperatureHigh : Double?
    let temperatureHighTime : Double?
    let temperatureLow : Double?
    let temperatureLowTime : Double?
    let apparentTemperatureHigh : Double?
    let apparentTemperatureHighTime : Double?
    let apparentTemperatureLow : Double?
    let apparentTemperatureLowTime : Double?
    let dewPoint : Double?
    let humidity : Double?
    let pressure : Double?
    let windSpeed : Double?
    let windGust : Double?
    let windGustTime : Double?
    let windBearing : Double?
    let cloudCover : Double?
    let uvIndex : Double?
    let uvIndexTime : Double?
    let visibility : Double?
    let ozone : Double?
    let temperatureMin : Double?
    let temperatureMinTime : Double?
    let temperatureMax : Double?
    let temperatureMaxTime : Double?
    let apparentTemperatureMin : Double?
    let apparentTemperatureMinTime : Double?
    let apparentTemperatureMax : Double?
    let apparentTemperatureMaxTime : Double?
    
    enum CodingKeys: String, CodingKey {
        
        case time = "time"
        case summary = "summary"
        case icon = "icon"
        case sunriseTime = "sunriseTime"
        case sunsetTime = "sunsetTime"
        case moonPhase = "moonPhase"
        case precipIntensity = "precipIntensity"
        case precipIntensityMax = "precipIntensityMax"
        case precipIntensityMaxTime = "precipIntensityMaxTime"
        case precipProbability = "precipProbability"
        case temperatureHigh = "temperatureHigh"
        case temperatureHighTime = "temperatureHighTime"
        case temperatureLow = "temperatureLow"
        case temperatureLowTime = "temperatureLowTime"
        case apparentTemperatureHigh = "apparentTemperatureHigh"
        case apparentTemperatureHighTime = "apparentTemperatureHighTime"
        case apparentTemperatureLow = "apparentTemperatureLow"
        case apparentTemperatureLowTime = "apparentTemperatureLowTime"
        case dewPoint = "dewPoint"
        case humidity = "humidity"
        case pressure = "pressure"
        case windSpeed = "windSpeed"
        case windGust = "windGust"
        case windGustTime = "windGustTime"
        case windBearing = "windBearing"
        case cloudCover = "cloudCover"
        case uvIndex = "uvIndex"
        case uvIndexTime = "uvIndexTime"
        case visibility = "visibility"
        case ozone = "ozone"
        case temperatureMin = "temperatureMin"
        case temperatureMinTime = "temperatureMinTime"
        case temperatureMax = "temperatureMax"
        case temperatureMaxTime = "temperatureMaxTime"
        case apparentTemperatureMin = "apparentTemperatureMin"
        case apparentTemperatureMinTime = "apparentTemperatureMinTime"
        case apparentTemperatureMax = "apparentTemperatureMax"
        case apparentTemperatureMaxTime = "apparentTemperatureMaxTime"
    }
}

struct Flags : Codable {
    let sources : [String]?
    let neareststation : Double?
    let units : String?
    
    enum CodingKeys: String, CodingKey {
        
        case sources = "sources"
        case neareststation = "nearest-station"
        case units = "units"
    }

}

struct Hourly : Codable {
    let summary : String?
    let icon : String?
    let data : [WeatherData]?
    
    enum CodingKeys: String, CodingKey {
        
        case summary = "summary"
        case icon = "icon"
        case data = "data"
    }
}

struct Minutely : Codable {
    let summary : String?
    let icon : String?
    let data : [WeatherData]?
    
    enum CodingKeys: String, CodingKey {
        
        case summary = "summary"
        case icon = "icon"
        case data = "data"
    }
}

struct City {
    let name : String?
    let lat : String?
    let long : String?
}
