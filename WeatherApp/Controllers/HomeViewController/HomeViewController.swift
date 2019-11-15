//
//  HomeViewController.swift
//  WeatherApp
//
//  Created by Chandra Rao on 14/11/19.
//  Copyright © 2019 Chandra Rao. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    var arrayCitiesWeather: [[String: Any]]? = nil
    
    @IBOutlet weak var btnAddCity: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        addTableBackGroundView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppRouter.sharedInstance.setCentreNavigationController(centreNavigationController: self.navigationController ?? UINavigationController())
        APIManager.sharedInstance.conformToWeatherProtocol(withDelegate: self)
        setUpDataSource()
    }
    
    func setUpDataSource() {
        DispatchQueue.main.async {
            self.tableView.estimatedRowHeight = 42.0
            self.tableView.rowHeight = UITableView.automaticDimension
        }
    }
    
    func addTableBackGroundView() {
        DispatchQueue.main.async {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: self.tableView.frame.size.height))
            label.numberOfLines = 0
            label.text = "Please Click on + Button to Add City"
            label.font = UIFont.systemFont(ofSize: 35)
            label.textAlignment = .center
            self.tableView.backgroundView = label            
        }
    }
    
    func removeTableBackGroundView() {
        DispatchQueue.main.async {
            if let _ = self.tableView.backgroundView as? UILabel {
                self.tableView.backgroundView = nil
            }
        }
    }
    
    @IBAction func btnAddCityClicked(_ sender: Any) {
        gotoCityListVC()
    }
    
    func gotoCityListVC() {
        let cityListVC = UIStoryboard(name: .main).instantiateViewController(withIdentifier: "CityListViewController") as! CityListViewController
        cityListVC.delegate = self
        AppRouter.sharedInstance.presentController(fromViewController: self, toViewController: cityListVC)
    }
    
    func loaderAnimation(isAnimating animation: Bool) {
        DispatchQueue.main.async {
            if animation {
                self.loader.startAnimating()
            } else {
                self.loader.stopAnimating()
            }
            self.loader.isHidden = !animation
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let dataArray = self.arrayCitiesWeather {
            return dataArray.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for: indexPath) as? WeatherTableViewCell {
            if let dataArray = self.arrayCitiesWeather, let city = dataArray[indexPath.row]["City"] as? City, let weatherData = dataArray[indexPath.row]["Data"] as? WeatherResponse {
                cell.populateWeatherData(withData: weatherData, andCity: city)
            }
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
}

extension HomeViewController: WeatherDataProtocol {
    func refreshWeatherDataResponse(withData weatherResponse: WeatherResponse?, forCity city: City?, withError error: Error?) {
        DispatchQueue.main.async {
            self.removeTableBackGroundView()
            self.loaderAnimation(isAnimating: false)
            if let weatherData = weatherResponse {
                if let arrData = self.arrayCitiesWeather, let cityWeather = city, arrData.count > 0 {
                    for (index, dict) in arrData.enumerated() {
                        if (dict["City"] as? City)?.name == cityWeather.name {
                            self.arrayCitiesWeather?[index] = [
                                "City": cityWeather,
                                "Data": weatherData
                            ]
                            self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                            break
                        }
                    }
                }
            } else {
                print("No RESPONSE")
            }
        }
    }
    
    func didReceiveWeatherDataResponse(withData weatherResponse: WeatherResponse?, forCity city: City?, withError error: Error?) {
        self.removeTableBackGroundView()
        self.loaderAnimation(isAnimating: false)
        if let weatherData = weatherResponse {
            if let arrData = self.arrayCitiesWeather, let cityWeather = city, arrData.count > 0 {
                self.arrayCitiesWeather?.append([
                    "City": cityWeather,
                    "Data": weatherData
                    ])
            } else if let cityWeather = city {
                self.arrayCitiesWeather = []
                self.arrayCitiesWeather?.append([
                    "City": cityWeather,
                    "Data": weatherData
                    ])
            } else {
                
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } else {
            print("No RESPONSE")
        }
    }
    
}

extension HomeViewController: SelectedCity {
    func selectedCity(withCityData city: City?) {
        if let selectedCity = city {
            DispatchQueue.main.async {
                self.loaderAnimation(isAnimating: true)
                if let dataArray = self.arrayCitiesWeather {
                    let array = dataArray.filter({ (dict) -> Bool in
                        (dict["City"] as? City)?.name == city?.name
                    })
                    if array.count > 0 {
                        // Data Exist
                        APIManager.sharedInstance.callWeatherReportAPI(forCity: selectedCity, isRefreshRequired: true)
                    } else {
                        APIManager.sharedInstance.callWeatherReportAPI(forCity: selectedCity, isRefreshRequired: false)
                    }
                } else {
                    APIManager.sharedInstance.callWeatherReportAPI(forCity: selectedCity, isRefreshRequired: false)
                }
            }
        }
    }
}

