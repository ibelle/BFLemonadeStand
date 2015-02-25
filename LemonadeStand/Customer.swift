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
    var tastePreference:Double = 0
    var description: String {
        return "Customoer: ID\(id)::TasePref\(tastePreference)"
    }

    
    init(id: Int, tastePref:Double){
        self.id = id
        self.tastePreference = tastePref
    }
    
    func tasteLemonade(drink: Lemonade) -> Bool{
    
        return false
    }
    
}