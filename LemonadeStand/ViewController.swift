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
    let MAX_CUSTOMERS:Int = 10
    let PAYOUT:Int = 1
    
    //Supply Vars
    var lemonSupply:Int = 0
    var iceSupply:Int = 0
    var cashSupply:Int = 0
    
    //Daily Vars
    var gameStarted:Bool = false

    //Calculated Properties
    var purchasedLemonSupply:Int {
        if( self.gameStarted){
            return lemonSupply
        }
        let additionalSupplyValue = lemonSupply - self.LEMON_SUPPLY_DEFAULT
        if additionalSupplyValue >= 0 {
            return additionalSupplyValue
        }else {
            return 0
        }
    }
    
    var purchasedIceSupply:Int {
        if( self.gameStarted){
            return iceSupply
        }

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
    
    
    //Purchase Outlets
    @IBOutlet weak var addLemonSupplyButton: UIButton!
    @IBOutlet weak var removeLemonSupplyButton: UIButton!
    @IBOutlet weak var lemonPurchaseLabel: UILabel!
    
    @IBOutlet weak var addIceSuppluButton: UIButton!
    @IBOutlet weak var removeIceSupplyButton: UIButton!
    @IBOutlet weak var icePurchaseLabel: UILabel!
   
    
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
      self.initGame()
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
        if(self.lemonSupply > 0){
            //Update Lemons
            self.lemonSupply -= 1
            
            //update cash
            self.cashSupply += self.LEMON_PRICE
        }
        //Alert HERE OR SET ERROR MESSAGE
        print("NO MORE LEMONS TO UNPURCHASE")
        updateMainView()
    }
    
    @IBAction func lemonSupplyAdded(sender: UIButton) {
        if (self.cashSupply > 0  && self.LEMON_PRICE  <= cashSupply){
                //Update Lemons
                self.lemonSupply += 1
                
                //update cash
                self.cashSupply -= self.LEMON_PRICE
            
            print("Cash \(cashSupply), Lemons \(lemonSupply)")

            }else{
                //Alert HERE OR SET ERROR MESSAGE
                print("CAN NOT AFFORD ADDITIONAL LEMON")
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
                print("CAN NOT AFFORD ADDITIONAL ICE CUBE")
            }
        
        updateMainView()
    }
    
    @IBAction func iceSupplyRemoved(sender: UIButton) {
        if(self.iceSupply > 0){
            //Update IceCubes
            self.iceSupply -= 1
            
            //Update cash
            self.cashSupply += self.ICE_PRICE
        }
        
        //Alert HERE OR SET ERROR MESSAGE
        print("NO MORE ICE TO UNPURCHASE")
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
    
    
    func mixLemonadeForDay(lemons:Int, ice:Int) -> Lemonade {
        return Lemonade(lemons: Double(lemons), ice: Double(ice))
    }
    
    
    func createTastePref() -> Double{
        let rand = Double(arc4random() % (UInt32(RAND_MAX) + 1))
        return round( (rand / Double(RAND_MAX)) * 100) / 100 //Round to 2 Decimal Places
    }
    
    func generateCustomersForDay() -> [Customer] {
        let numCustomers = Int(arc4random_uniform(UInt32(MAX_CUSTOMERS))) + 1
        var customerCollection=[Customer]()
        for var i=0; i<numCustomers; i++ {
            customerCollection.append(Customer(id: i,tastePref: self.createTastePref()))
        }
        
        return customerCollection
    }
    
    //Sell Action
    @IBAction func startDayPressed(sender: UIButton) {
        var totalSales:Int=0
        if(lemonsToMix == 0 && iceToMix == 0){
            print("NOTHING TO MIX FOR LEMONADE. ADD MORE ITEMS TO MIX OR PURCHASE ADDITIONAL SUPPLIES")
            self.showOkAlertWithText("Nothing to Mix",message:"Nothing To Mix For Lemonade. Add More Items To Mix Or Purchase Additional Supplies")
            return
        }
        print("#######STARTING DAY########")
        //1. Create Lemonade, print LemonadeFlavorType
        let dailyLemonade:Lemonade = self.mixLemonadeForDay(lemonsToMix, ice: iceToMix)
        print("1) Lemonade Mixed for the Day:\(dailyLemonade)")
        
        //2. Generate a random nubmer of customers between 01 and 10
        //2a. For each customer create a random taste preference(between 0 and 1)
        let dailyCustomers:[Customer] = self.generateCustomersForDay()
        print("2) \(dailyCustomers.count) Customers created for the Day:\(dailyCustomers)")
        
        //3. Call Customer.tasteLemonade() Function for each customer
        print("3) Tasing Lemonade ")
        for (customer) in dailyCustomers {
            if(customer.tasteLemonade(dailyLemonade)){
                totalSales+=self.PAYOUT
                print("SALE!! Customer \(customer.id) bought a glass of lemonade. Total Sales $\(totalSales)")
            }else{
                print("NO SALE!!! Customer \(customer.id) did not buy a glass of lemonade.")
            }
        }
       
       
        //TODO: RESET MIX TO PERMANENTLY DEPLETE FROM INVENTORY
        self.cashSupply += totalSales
        self.lemonsToMix = 0
        self.iceToMix = 0
        
        let numGlassesSold=totalSales/self.PAYOUT
        print("4)RESULTS: Sold: \(numGlassesSold) glasses of lemonade. No Sales: \(dailyCustomers.count - numGlassesSold), Total Cash: \(self.cashSupply)")
        print("#######DAY OVER########")
        if !self.gameStarted {
            self.gameStarted = true
        }
        if(cashSupply==0){
           self.endGame()
        }else{
            print("PLAY AGAIN!!!")
        }
        updateMainView()
    }
    
    func initGame(){
        self.lemonSupply = self.LEMON_SUPPLY_DEFAULT
        self.iceSupply = self.ICE_SUPPLY_DEFAULT
        self.cashSupply = self.CASH_DEFAULT
        self.lemonsToMix = 0
        self.iceToMix = 0
        
    }
    
    func endGame(){
        print("GAME OVER")
        self.initGame()
    }
    
    //Misc
    func updateMainView () {
        //Update Inventory
        self.lemonInventoryLabel.text = "\(lemonSupply) Lemons"
        self.iceInventoryLabel.text = "\(iceSupply) Ice Cubes"
        self.availableCashLabel.text = "$\(cashSupply)"
        self.availableCashLabel.sizeToFit()
        
        //Update Supply
        self.lemonPurchaseLabel.text = "\(self.purchasedLemonSupply)"
        self.icePurchaseLabel.text = "\(self.purchasedIceSupply)"
        
        //Update Mix
        self.lemonMixLabel.text = "\(lemonsToMix)"
        self.iceMixLabel.text = "\(iceToMix)"
      
    }
    
    func showOkAlertWithText(
        header: String = "Warning",
        message: String,
        handler: ((UIAlertAction!) -> Void)? = nil,
        completion: (() -> Void)? = nil){
            
            let alert  = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: handler))
            self.presentViewController(alert, animated: true, completion: completion)
    }
}

