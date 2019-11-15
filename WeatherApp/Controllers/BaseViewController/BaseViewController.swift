//
//  BaseViewController.swift
//  WeatherApp
//
//  Created by Chandra Rao on 14/11/19.
//  Copyright © 2019 Chandra Rao. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func setViewbackgroundColor() {
        self.view.backgroundColor = UIColor(hexString: "30334C")
    }
    
    func navigationBarIsHidden(_ isHidden: Bool) {
        self.navigationController?.navigationBar.isHidden = isHidden
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
