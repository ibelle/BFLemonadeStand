//
//  Supplies.swift
//  LemonadeStand
//
//  Created by Isaiah Belle on 10/4/15.
//  Copyright © 2015 IsaiahBelleDigital. All rights reserved.
//

import Foundation

struct Supplies{
    var lemonSupply = 0
    var iceSupply = 0
    var cashSupply  = 0

    //FOR LEARNING PURPOSES, THIS IS CREATED BY DEFAULT FOR STRUCTS
    init (aMoney:Int, aLemons:Int, aIcecubes:Int){
        cashSupply = aMoney
        iceSupply = aIcecubes
        lemonSupply = aLemons
    }
    
}