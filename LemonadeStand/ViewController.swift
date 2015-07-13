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
    let LEMON_SUPPLY_DEFAULT:Int =  1
    let ICE_SUPPLY_DEFAULT:Int = 1
    let CASH_DEFAULT:Int = 10
    
    //Supply Vars
    var lemonSupply:Int = 0
    var iceSupply:Int = 0
    var cashSupply:Int = 0
    
    
    //Calculated Properties
    var purchasedLemonSupply:Int {
        let additionalSupplyValue = lemonSupply - self.LEMON_SUPPLY_DEFAULT
        if additionalSupplyValue >= 0 {
            return additionalSupplyValue
        }else {
            return 0
        }
    }
    
    var purchasedIceSupply:Int {
        let additionalSupplyValue = iceSupply - self.ICE_SUPPLY_DEFAULT
        if additionalSupplyValue >= 0 {
            return additionalSupplyValue
        }else {
            return 0
        }
    }
    
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
    @IBOutlet weak var addLemonSupplyButton: UIButton!
    @IBOutlet weak var removeLemonSupplyButton: UIButton!
    @IBOutlet weak var lemonSupplyLabel: UILabel!
    
    @IBOutlet weak var addIceSuppluButton: UIButton!
    @IBOutlet weak var removeIceSupplyButton: UIButton!
    @IBOutlet weak var iceSupplyLabel: UILabel!
   
    
    //Mix Outlets
    var lemonsToMix:Int = 0
    var iceToMix:Int = 0
    @IBOutlet weak var lemonMixLabel: UILabel!
    @IBOutlet weak var iceMixLabel: UILabel!
    @IBOutlet weak var addLemonToMixButton: UIButton!
    @IBOutlet weak var removeLemonFromMixButton: UIButton!
    
    @IBOutlet weak var addIceToMixButton: UIButton!
    @IBOutlet weak var removeIceFromMixButton: UIButton!
    
    
    
    //Sales Outlets
    
    
    //Top Level Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.lemonSupply = self.LEMON_SUPPLY_DEFAULT
        self.iceSupply = self.ICE_SUPPLY_DEFAULT
        self.cashSupply = self.CASH_DEFAULT
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
    @IBAction func lemonSupplyRemoved(sender: UIButton) {
        if(self.lemonSupply > self.LEMON_SUPPLY_DEFAULT){
            //Update Lemons
            self.lemonSupply -= 1
            
            //update cash
            self.cashSupply += self.LEMON_PRICE
        }
        //Alert HERE OR SET ERROR MESSAGE
        println("NO MORE LEMONS TO UNPURCHASE")
        updateMainView()
    }
    
    @IBAction func lemonSupplyAdded(sender: UIButton) {
        if (self.cashSupply > 0  && self.LEMON_PRICE  <= cashSupply){
             println("YO IM BUYING LEMONS DUDE!")
                //Update Lemons
                self.lemonSupply += 1
                
                //update cash
                self.cashSupply -= self.LEMON_PRICE
            
            println("Cash \(cashSupply), Lemons \(lemonSupply)")

            }else{
                //Alert HERE OR SET ERROR MESSAGE
                println("CAN NOT AFFORD ADDITIONAL LEMON")
            }
        updateMainView()
    }
    
    
    @IBAction func iceSupplyAdded(sender: UIButton) {
  
        if (self.cashSupply > 0 && self.ICE_PRICE  <= cashSupply) {
                //Update Lemons
                self.iceSupply += 1
                
                //Update cash
                self.cashSupply -= self.ICE_PRICE
            }else{
                //Alert HERE OR SET ERROR MESSAGE
                println("CAN NOT AFFORD ADDITIONAL ICE CUBE")
            }
        
        updateMainView()
    }
    
    @IBAction func iceSupplyRemoved(sender: UIButton) {
       
        if(self.iceSupply > self.ICE_SUPPLY_DEFAULT){
            //Update IceCubes
            self.iceSupply -= 1
            
            //Update cash
            self.cashSupply += self.ICE_PRICE
        }
        
        //Alert HERE OR SET ERROR MESSAGE
        println("NO MORE ICE TO UNPURCHASE")
        updateMainView()
    }
    
    //Mix
    @IBAction func lemonAddedToMix(sender: UIButton) {
        if self.lemonSupply > 0 {
            self.lemonsToMix++
            self.lemonSupply--
        }
        updateMainView()
    }
    
    @IBAction func lemonRemovedFromMix(sender: UIButton) {
        if self.lemonsToMix > 0 {
            self.lemonsToMix--
            self.lemonSupply++
        }
        updateMainView()
    }
    
    @IBAction func addIceToMix(sender: UIButton) {
        if self.iceSupply > 0 {
            self.iceToMix++
            self.iceSupply--
        }
        updateMainView()
    }
    
    @IBAction func removeIceFromMix(sender: UIButton) {
        if self.iceToMix > 0 {
            self.iceToMix--
            self.iceSupply++
        }
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
        self.lemonSupplyLabel.text = "\(self.purchasedLemonSupply)"
        self.iceSupplyLabel.text = "\(self.purchasedIceSupply)"
        
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

