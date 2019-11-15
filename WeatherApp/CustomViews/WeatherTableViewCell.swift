//
//  WeatherTableViewCell.swift
//  WeatherApp
//
//  Created by Chandra Rao on 14/11/19.
//  Copyright © 2019 Chandra Rao. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var innerView: UIView!

    @IBOutlet weak var labelCityName: UILabel!
    @IBOutlet weak var labelTemprature: UILabel!
    @IBOutlet weak var labelWethearDetails: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func populateWeatherData(withData data: WeatherResponse, andCity city: City) {
        populateCityName(withData: data, andCity: city)
        populateTemprature(withData: data, andCity: city)
        calculateHumidityAndRainPercentagePercentage(withData: data, andCity: city)
    }
    
    private func populateCityName(withData data: WeatherResponse, andCity city: City) {
        self.labelCityName.text = city.name
    }
    
    private func populateTemprature(withData data: WeatherResponse, andCity city: City) {
        self.labelTemprature.text = String(format: "\(data.currently?.temperature ?? 0) %@F", "\u{00B0}")
    }
    
    private func calculateHumidityAndRainPercentagePercentage(withData data: WeatherResponse, andCity city: City) {
        var humidityPercentage = ""
        var rainPercentage = ""
        
        if let humidity = data.currently?.humidity {
            humidityPercentage = "\((humidity * 100))% Humidity"
        } else {
            humidityPercentage = "0% Humidity"
        }
        
        if let dailyData = data.daily?.data, dailyData.count > 0, let rain = dailyData[0] .precipProbability {
            rainPercentage = "\((rain * 100))% Chances of Rain"
        } else {
            rainPercentage = "0% Chances of Rain"
        }
        
        self.labelWethearDetails.text = humidityPercentage + ", " + rainPercentage
    }
    
}
