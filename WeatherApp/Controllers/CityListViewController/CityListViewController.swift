//
//  CityListViewController.swift
//  WeatherApp
//
//  Created by Chandra Rao on 14/11/19.
//  Copyright © 2019 Chandra Rao. All rights reserved.
//

import UIKit

protocol SelectedCity: NSObject {
    func selectedCity(withCityData city: City?)
}

class CityListViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    var arrayCities: [City]? = nil
    
    @IBOutlet weak var btnCancel: UIBarButtonItem!
    weak var delegate: SelectedCity? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setViewbackgroundColor()
        setUpDataSource()
    }
    
    func setUpDataSource() {
        DispatchQueue.main.async {
            self.arrayCities = [
                City(name: "London", lat: "51.5074", long: "0.1278"),
                City(name: "Paris", lat: "48.8566", long: "2.3522"),
                City(name: "New York", lat: "40.7128", long: "74.0060"),
                City(name: "Los Angeles", lat: "34.0522", long: "118.2437"),
                City(name: "Tokyo", lat: "35.6762", long: "139.6503"),
            ]
            self.tableView.estimatedRowHeight = 33.0
            self.tableView.rowHeight = UITableView.automaticDimension
            
            self.tableView.reloadData()
        }
    }
    
    @IBAction func btnCancelClicked(_ sender: Any) {
        self.dismiss(animated: true) {
            
        }
    }
}

extension CityListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let dataArray = self.arrayCities {
            return dataArray.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for: indexPath) as? WeatherTableViewCell {
            if let dataArray = self.arrayCities, let city = dataArray[indexPath.row] as? City {
                cell.labelCityName.text = city.name
            }
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let dataArray = self.arrayCities, let city = dataArray[indexPath.row] as? City {
            DispatchQueue.main.async {
                if let del = self.delegate {
                    self.dismiss(animated: true) {
                        del.selectedCity(withCityData: city)
                    }                    
                }
            }
        }
    }
}
