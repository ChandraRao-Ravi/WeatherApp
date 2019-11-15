//
//  APIManager.swift
//  WeatherApp
//
//  Created by Chandra Rao on 18/02/19.
//  Copyright © 2019 Chandra Rao. All rights reserved.
//

import Foundation

protocol WeatherDataProtocol {
    func didReceiveWeatherDataResponse(withData weatherResponse: WeatherResponse?, forCity city: City?, withError error: Error?)
    func refreshWeatherDataResponse(withData weatherResponse: WeatherResponse?, forCity city: City?, withError error: Error?)
}

class APIManager: NSObject {

    var weatherDelegate: WeatherDataProtocol?
    
    static let sharedInstance: APIManager = {
        let instance = APIManager()
        // setup code
        return instance
    }()
    
    // MARK: - Initialization Method
    
    override init() {
        super.init()
    }
    
    func conformToWeatherProtocol(withDelegate delegateReceived: WeatherDataProtocol?) {
        if let delegate = delegateReceived {
            self.weatherDelegate = delegate
        }
    }
    
    func callWeatherReportAPI(forCity city: City, isRefreshRequired refreshStatus: Bool) {
        if NetworkConnection.sharedInstance.isConnectedToInternet {
            APIHelper.sharedInstance.makeGetApiCallWithMethod(withMethod: "\(city.lat ?? ""),\(city.long ?? "")", successHandler: { (data, error) in
                if let delegate = self.weatherDelegate {
                    do {
                        let jsonDecoder = JSONDecoder()
                        let responseModel = try jsonDecoder.decode(WeatherResponse.self, from: data!)
                        if refreshStatus {
                            delegate.refreshWeatherDataResponse(withData: responseModel, forCity: city, withError: nil)
                        } else {
                            delegate.didReceiveWeatherDataResponse(withData: responseModel, forCity: city, withError: nil)
                        }
                    } catch let err {
                        if refreshStatus {
                            delegate.refreshWeatherDataResponse(withData: nil, forCity: city, withError: nil)
                        } else {
                            delegate.didReceiveWeatherDataResponse(withData: nil, forCity: city, withError: nil)
                        }
                    }
                } else {
                    fatalError("Please Confirm to WeatherDataProtocol")
                }
            }) { (message, error) in
                if let delegate = self.weatherDelegate {
                    if refreshStatus {
                        delegate.refreshWeatherDataResponse(withData: nil, forCity: city, withError: nil)
                    } else {
                        delegate.didReceiveWeatherDataResponse(withData: nil, forCity: city, withError: nil)
                    }
                } else {
                    fatalError("Please Confirm to WeatherDataProtocol")
                }
            }
        } else {
            AppRouter.sharedInstance.showAlertOnCentreController(withMessage: "No Network Connection")
            if let delegate = self.weatherDelegate {
                if refreshStatus {
                    delegate.refreshWeatherDataResponse(withData: nil, forCity: city, withError: nil)
                } else {
                    delegate.didReceiveWeatherDataResponse(withData: nil, forCity: city, withError: nil)
                }
            } else {
                fatalError("Please Confirm to WeatherDataProtocol")
            }
        }
    }
}

