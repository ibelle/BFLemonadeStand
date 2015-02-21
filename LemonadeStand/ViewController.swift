//
//  ViewController.swift
//  LemonadeStand
//
//  Created by HUGE | Isaiah Belle on 2/20/15.
//  Copyright (c) 2015 IsaiahBelleDigital. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var numLemons:Int = 1
    var numIceCubes:Int = 1
    var cashOnHand:Double = 10.00
    //Containers
    @IBOutlet weak var suppliesContainerView: UIView!
    @IBOutlet weak var inventoryContinerView: UIView!
    @IBOutlet weak var mixContainerView: UIView!
    @IBOutlet weak var salesContainerView: UIView!
    
    //Inventory Outlets
    @IBOutlet weak var availableCashLabel: UILabel!
    @IBOutlet weak var lemonInventoryLabel: UILabel!
    @IBOutlet weak var iceInventoryLabel: UILabel!
    
    
    //Supply Outlets
    @IBOutlet weak var addRemoveLemons: UIStepper!
    @IBOutlet weak var addRemoveIce: UIStepper!
    
    //Mix Outlets
    
    
    
    //Sales Outlets
    
    
    //Top Level Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Supply Actions
    @IBAction func addRemoveLemonsValueChanged(sender: AnyObject) {
    }

    @IBAction func addRemoveIceValueChanged(sender: UIStepper) {
    }
    


}

