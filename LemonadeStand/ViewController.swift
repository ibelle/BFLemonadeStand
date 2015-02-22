//
//  ViewController.swift
//  LemonadeStand
//
//  Created by HUGE | Isaiah Belle on 2/20/15.
//  Copyright (c) 2015 IsaiahBelleDigital. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var lemonSupply:Int = 1
    var iceSupply:Int = 1
    var cashSupply:Int = 10
    
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
    var additionalLemonSupply:Int = 0
    var additionalIceSupply:Int = 0
    @IBOutlet weak var lemonSupplyStepper: UIStepper!
    @IBOutlet weak var iceSupplyStepper: UIStepper!
    @IBOutlet weak var lemonSupplyLabel: UILabel!
    @IBOutlet weak var iceSupplyLabel: UILabel!
   
    
    //Mix Outlets
    var lemonsToMix:Int = 0
    var iceToMix:Int = 0
    @IBOutlet weak var lemonMixLabel: UILabel!
    @IBOutlet weak var iceMixLabel: UILabel!
    @IBOutlet weak var lemonMixStepper: UIStepper!
    @IBOutlet weak var iceMixStepper: UIStepper!
    
    //Sales Outlets
    
    
    //Top Level Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.updateMainView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Supply Actions
    @IBAction func lemonSupplyValueChanged(sender: UIStepper) {
        self.additionalLemonSupply = Int(sender.value)
        //TODO:Update INVENTORY
        updateMainView()
    }

    @IBAction func iceSupplyValueChanged(sender: UIStepper) {
        self.additionalIceSupply = Int(sender.value)
        //TODO:Update INVENTORY
        updateMainView()

    }
 
    
    //Mix
    @IBAction func lemonMixValueChanged(sender: UIStepper) {
        self.lemonsToMix = Int(sender.value)
        
        updateMainView()
    }
 
    @IBAction func iceMixValueChanged(sender: UIStepper) {
        self.iceToMix = Int(sender.value)
        //TODO:Update INVENTORY
        updateMainView()
    }
    
    //Sell Action
    @IBAction func startDayPressed(sender: UIButton) {
    }
    
    
    
    //Misc
    func updateMainView () {
        //Update Inventory
        self.lemonInventoryLabel.text = "\(lemonSupply) Lemons"
        self.iceInventoryLabel.text = "\(iceSupply) Ice Cubes"
        self.availableCashLabel.text = "$ \(cashSupply)"
        self.availableCashLabel.sizeToFit()
        
        //Update Supply
        self.lemonSupplyLabel.text = "\(additionalLemonSupply)"
        self.iceSupplyLabel.text = "\(additionalIceSupply)"
        
        
        //Update Mix
        self.lemonMixLabel.text = "\(lemonsToMix)"
        self.iceMixLabel.text = "\(iceToMix)"
    }



}

