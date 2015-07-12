//
//  ViewController.swift
//  LemonadeStand
//
//  Created by HUGE | Isaiah Belle on 2/20/15.
//  Copyright (c) 2015 IsaiahBelleDigital. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //Constants
    let LEMON_PRICE:Int = 2
    let ICE_PRICE:Int = 1
    
    //Supply Vars
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
        let inputLemonValue = Int(sender.value)
        var doUpdateLemonSupply = false
        
        
        if inputLemonValue > self.additionalLemonSupply && self.cashSupply > 0 {
           doUpdateLemonSupply = purchaseLemon()
        }else if inputLemonValue < self.additionalLemonSupply{
            doUpdateLemonSupply = unPurchaseLemon()
        }
        if(doUpdateLemonSupply) {
            self.additionalLemonSupply = inputLemonValue
        }else {
            sender.value = Double(additionalLemonSupply)
        }
        
        updateMainView()
    }

    @IBAction func iceSupplyValueChanged(sender: UIStepper) {
        let inputIceCubeValue = Int(sender.value)
        var doUpdateIceSupply = false
        
        if inputIceCubeValue > self.additionalIceSupply && self.cashSupply > 0{
            doUpdateIceSupply = purchaseIceCube()
        }else if inputIceCubeValue < self.additionalIceSupply{
            doUpdateIceSupply = unPurchaseIceCube()
        }

        
        if(doUpdateIceSupply){
            self.additionalIceSupply = Int(sender.value)
        }else{
            sender.value = Double(additionalIceSupply)
        }
        
        updateMainView()
    }
    
    func purchaseLemon() -> Bool {
            if self.LEMON_PRICE  <= cashSupply {
                //Update Lemons
                self.lemonSupply += 1
                
                //update cash
                self.cashSupply -= self.LEMON_PRICE
                return true
            }else{
                //Alert HERE OR SET ERROR MESSAGE
                println("CAN NOT AFFORD ADDITIONAL LEMON")
            }
        return false
    }
    
    func unPurchaseLemon() ->Bool {
            if(self.lemonSupply > 1){
                //Update Lemons
                self.lemonSupply -= 1
                
                //update cash
                self.cashSupply += self.LEMON_PRICE
                
                return true
            }
        //Alert HERE OR SET ERROR MESSAGE
        println("NO MORE LEMONS TO UNPURCHASE")
        return false
    }
    
    
    func purchaseIceCube() -> Bool {
        if self.ICE_PRICE  <= cashSupply {
            //Update Lemons
            self.iceSupply += 1
            
            //Update cash
            self.cashSupply -= self.ICE_PRICE
            
            return true
        }else{
            //Alert HERE OR SET ERROR MESSAGE
            println("CAN NOT AFFORD ADDITIONAL ICE CUBE")
        }
        return false
    }
    
    func unPurchaseIceCube() -> Bool{
        if(self.iceSupply > 1){
            //Update IceCubes
            self.iceSupply -= 1
            
            //Update cash
            self.cashSupply += self.ICE_PRICE
            
            return true
        }
        //Alert HERE OR SET ERROR MESSAGE
        println("NO MORE ICE TO UNPURCHASE")
        
        return false
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
    
    
    
    func mixLemonade(lemons:Int, ice:Int) -> Lemonade {
        return Lemonade(lemons: Double(lemons), ice: Double(ice))
    }
    
    //Sell Action
    @IBAction func startDayPressed(sender: UIButton) {
        //1. Create Lemonade, print LemonadeFlavorType
        
        //2. Generate a random nubmer of customers between 01 and 10
            //2a. For each customer create a random taste preference(between 0 and 1)
        //3. Call CompareTastePrefrences Function (etiher defined here OR in Customer)
        
        
    }
    
    
    
    //Misc
    func updateMainView () {
        //Update Inventory
        self.lemonInventoryLabel.text = "\(lemonSupply) Lemons"
        self.iceInventoryLabel.text = "\(iceSupply) Ice Cubes"
        self.availableCashLabel.text = "$\(cashSupply)"
        self.availableCashLabel.sizeToFit()
        
        //Update Supply
        self.lemonSupplyLabel.text = "\(additionalLemonSupply)"
        self.iceSupplyLabel.text = "\(additionalIceSupply)"
        
        
        //Update Mix
        self.lemonMixLabel.text = "\(lemonsToMix)"
        self.iceMixLabel.text = "\(iceToMix)"
    }
    
    func showAlertWithText(
        header: String = "Warning",
        message: String,
        handler: ((UIAlertAction!) -> Void)? = nil,
        completion: (() -> Void)? = nil){
            
            var alert  = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: handler))
            self.presentViewController(alert, animated: true, completion: completion)
    }



}

