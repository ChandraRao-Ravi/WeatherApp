//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Chandra Rao on 14/11/19.
//  Copyright © 2019 Chandra Rao. All rights reserved.
//

import XCTest
@testable import WeatherApp

class WeatherAppTests: XCTestCase {
    
    var homeVC: HomeViewController!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: HomeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        homeVC = vc
        _ = homeVC.view
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDidReceiveWeatherDataResponse() {
        if let response = self.loadJson(filename: "WeatherResponseMock") {
            self.homeVC.didReceiveWeatherDataResponse(withData: response, forCity: City(name: "London", lat: "51.5074", long: "0.1278"), withError: nil)
            
            if let arrData = self.homeVC.arrayCitiesWeather {
                XCTAssertTrue(arrData.count == 1, "The City Weather Data Should be added")
            }
            
            if let arrData = self.homeVC.arrayCitiesWeather, arrData.count > 0, let citydata = arrData[0]["City"] as? City {
                XCTAssertTrue(citydata.name == "London", "The City name be London")
            }
            
        } else {
            XCTAssertNil(nil, "Unable To Parse Response")
        }
    }
    
    func loadJson(filename fileName: String) -> WeatherResponse? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(WeatherResponse.self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
