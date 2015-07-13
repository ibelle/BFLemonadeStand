//
//  Customer.swift
//  LemonadeStand
//
//  Created by HUGE | Isaiah Belle on 2/22/15.
//  Copyright (c) 2015 IsaiahBelleDigital. All rights reserved.
//

import Foundation
class Customer : Printable {
    var id:Int = 0
    var tastePreference:Double = 0.0
    var description: String {
        return "Customoer: ID=\(id)::TastePref=\(tastePreference)::LemonadeTastePref= \(lemonadeTastePreference.description())"
    }
    
    var lemonadeTastePreference:LemonadeFlavorType {
        switch self.tastePreference {
        case 0.0...0.4:
            return LemonadeFlavorType.ACIDIC
        case 0.4...0.6:
            return LemonadeFlavorType.BALANCED
        case 0.6...1.0:
            return LemonadeFlavorType.DILUTED
        default:
            return LemonadeFlavorType.BALANCED
        }
    }

    
    
    init(id: Int, tastePref:Double){
        self.id = id
        self.tastePreference = tastePref
    }
    
    
    func tasteLemonade(sample:Lemonade) -> Bool{
        if sample.flavor == self.lemonadeTastePreference {
            return true
        }
        return false
    }
    
    
}