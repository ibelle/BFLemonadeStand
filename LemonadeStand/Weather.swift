//
//  Weather.swift
//  LemonadeStand
//
//  Created by Isaiah Belle on 10/4/15.
//  Copyright © 2015 IsaiahBelleDigital. All rights reserved.
//

import Foundation
import UIKit
struct Weather: CustomStringConvertible {
    var name = ""
    var image = UIImage(named:"")
    var influence:Int = 0
    
    var description: String {
        return "Weather: Name-\(name), Image-\(image), Incluence-\(influence)"
    }
}