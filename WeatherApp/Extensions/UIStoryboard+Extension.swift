//
//  UIStoryboard+Extension.swift
//  WeatherApp
//
//  Created by Chandra Rao on 11/09/18.
//  Copyright © 2018 Chandra Rao. All rights reserved.
//

import Foundation
import UIKit

enum StoryName: String {
    case main = "Main"
}

extension UIStoryboard{
    
    convenience init(name:StoryName, bundle:Bundle? = nil) {
        self.init(name:name.rawValue, bundle: bundle)
    }
}
