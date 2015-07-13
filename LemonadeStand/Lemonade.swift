//
//  Lemonade.swift
//  LemonadeStand
//
//  Created by HUGE | Isaiah Belle on 2/22/15.
//  Copyright (c) 2015 IsaiahBelleDigital. All rights reserved.
//

import Foundation
struct Lemonade : Printable {
    var lemonAmt:Double = 1.0
    var iceAmt:Double  = 1.0
    var acidity:Double {
        get {
            if(iceAmt > 0.0 ){
                return lemonAmt / iceAmt
            }
            return 1.0
        }
    }
    var flavor:LemonadeFlavorType {
        let acidAmt =  self.acidity
            if acidAmt > 1.0 {
                return LemonadeFlavorType.ACIDIC
            }else if acidAmt == 1.0 {
                return LemonadeFlavorType.BALANCED
            }else{
                return LemonadeFlavorType.DILUTED
            }
    }
    var description: String {
        return "Lemonade: Lemons::Ice::Acidity \(lemonAmt)::\(iceAmt)::\(acidity)"
    }

    
    init(){}
    init(lemons:Double, ice:Double){
        self.lemonAmt = lemons
        self.iceAmt = ice
    }
    
}


enum LemonadeFlavorType: Double{
    case ACIDIC = 1.1
    case BALANCED = 1.0
    case DILUTED = 0.9
    func description () -> String {
        switch self {
        case ACIDIC:
            return "ACIDIC"
        case BALANCED:
            return "BALANCED"
        case DILUTED:
            return "DILUTED"        }
    }
    
}