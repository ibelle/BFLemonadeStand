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
    let price = Price()//XXXX
    let MAX_CUSTOMERS:Int = 10
    let PAYOUT:Int = 1
    
    
    
    //Supply Vars
    var supplies = Supplies(aMoney: 10, aLemons: 1, aIcecubes: 1)//XXX
    
    //Purchase Vars
    var lemonsToPurchase = 0
    var iceCubesToPurchase = 0
    
    //Mix Vars
    var lemonsToMix:Int = 0
    var iceToMix:Int = 0
    
    //Weather
    var weatherArray:[Weather]=[]
    var todaysWeather:Weather = Weather()
    
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
   
    
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!

    @IBOutlet weak var lemonMixLabel: UILabel!
    @IBOutlet weak var iceMixLabel: UILabel!
    @IBOutlet weak var addLemonToMixButton: UIButton!
    @IBOutlet weak var removeLemonFromMixButton: UIButton!
    
    @IBOutlet weak var addIceToMixButton: UIButton!
    @IBOutlet weak var removeIceFromMixButton: UIButton!

    
    //Top Level Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        simulateWeatherToday()
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
    @IBAction func lemonSupplyRemoved(sender: UIButton) {
        if(self.lemonsToPurchase > 0){
          self.lemonsToPurchase -= 1
          self.supplies.cashSupply += self.price.lemon
          self.supplies.lemonSupply -= 1
        }   else {
            showAlertWithText(message: "You don't have any lemons to return")
        }
        updateMainView()
    }
    
    @IBAction func lemonSupplyAdded(sender: UIButton) {
        if (self.supplies.cashSupply >= self.price.lemon ){
                self.lemonsToPurchase+=1
                self.supplies.lemonSupply += 1
                self.supplies.cashSupply -= self.price.lemon
                print("Purchased Lemons: Cash \(self.supplies.cashSupply), Lemons \(self.supplies.lemonSupply)")
            }else{
                showAlertWithText(message: "CAN NOT AFFORD ADDITIONAL LEMONS")
            }
        updateMainView()
    }
    
    
    @IBAction func iceSupplyAdded(sender: UIButton) {
  
        if (self.supplies.cashSupply >= self.price.iceCube) {
                self.iceCubesToPurchase += 1
                self.supplies.iceSupply += 1
                self.supplies.cashSupply -= self.price.iceCube
            }else{
                showAlertWithText(message:"CAN NOT AFFORD ADDITIONAL ICE CUBES")
            }
        
        updateMainView()
    }
    
    @IBAction func iceSupplyRemoved(sender: UIButton) {
        if(self.iceCubesToPurchase > 0){
            self.iceCubesToPurchase-=1
            self.supplies.iceSupply -= 1
            self.supplies.cashSupply += self.price.iceCube
        }else{
            showAlertWithText(message: "You don't have any ice to return")
        }
        updateMainView()
    }
    
    //Mix
    @IBAction func lemonAddedToMix(sender: UIButton) {
        if self.supplies.lemonSupply > 0 {
            self.lemonsToPurchase = 0
            self.supplies.lemonSupply--
            self.lemonsToMix++
           updateMainView()
        }
    }
    
    @IBAction func lemonRemovedFromMix(sender: UIButton) {
        if self.lemonsToMix > 0 {
            self.lemonsToPurchase = 0
            self.lemonsToMix--
            self.supplies.lemonSupply++
            updateMainView()
        }else{
             showAlertWithText(message: "You don't have anything to unmix")
        }
        
    }
    
    @IBAction func addIceToMix(sender: UIButton) {
        if self.supplies.iceSupply > 0 {
            self.iceToMix++
            self.supplies.iceSupply--
            self.iceCubesToPurchase=0
            updateMainView()
        }
        
    }
    
    @IBAction func removeIceFromMix(sender: UIButton) {
        if self.iceToMix > 0 {
            self.iceCubesToPurchase = 0
            self.iceToMix--
            self.supplies.iceSupply++
            updateMainView()
        }else{
             showAlertWithText(message: "You don't have anything to unmix")
        }
        
    }
    
    
    @IBAction func resetButtonPressed(sender: UIButton) {

        let resetAlertView = UIAlertController(title: "Are You Sure?", message: "If you continue, game will start over", preferredStyle: UIAlertControllerStyle.Alert)
        resetAlertView.addAction(UIAlertAction(title: "Reset", style: UIAlertActionStyle.Default, handler: { (alertAction) -> Void in
            self.resetView(true)
            self.updateMainView()
        }))
        resetAlertView.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        presentViewController(resetAlertView, animated: true, completion: nil)
        
    }
    
       //Start Action
    @IBAction func startDayPressed(sender: UIButton) {
      
        var totalSales:Int=0
        //Mix Lemonade
        if(lemonsToMix == 0 && iceToMix == 0){
            print("NOTHING TO MIX FOR LEMONADE. ADD MORE ITEMS TO MIX OR PURCHASE ADDITIONAL SUPPLIES")
            self.showAlertWithText("Nothing to Mix",message:"Nothing To Mix For Lemonade. Add More Items To Mix Or Purchase Additional Supplies")
            return
        }
        
            print("#######STARTING DAY########")
            //1. Create Lemonade, print LemonadeFlavorType
            let dailyLemonade:Lemonade = Lemonade(lemons: Double(supplies.lemonSupply), ice: Double(supplies.iceSupply))
            print("Lemonade Mixed for the Day:\(dailyLemonade)")
       
        //Generate a random nubmer of customers between 01 and 10
        //For each customer create a random taste preference(between 0 and 1)
        let dailyCustomers:[Customer] = self.generateCustomersForDay()
        print("1)\(dailyCustomers.count) Customers created for the Day:\(dailyCustomers)")
        
        
        //Call Customer.tasteLemonade() Function for each customer
        print("Tasting Lemonade ")
        for (customer) in dailyCustomers {
            if(customer.tasteLemonade(dailyLemonade)){
                totalSales+=self.PAYOUT
                print("SALE!! Customer \(customer.id) bought a glass of lemonade. Total Sales $\(totalSales)")
            }else{
                print("NO SALE!!! Customer \(customer.id) did not buy a glass of lemonade.")
            }
        }
       
       
        //TODO: RESET MIX TO PERMANENTLY DEPLETE FROM INVENTORY
        self.supplies.cashSupply += totalSales
        resetView()
  
        
           if(supplies.cashSupply==0 && (supplies.lemonSupply==0 || supplies.iceSupply == 0)){
           showAlertWithText("Game Over", message:"D'oh! You ran out of money and supplies 😢. Try Again!")
            print("GAME OVER 😢")
            resetView(true)
           }else{
            let numGlassesSold=totalSales/self.PAYOUT
            showAlertWithText("Day Results", message:"Day RESULTS: Customers: \(dailyCustomers.count) Sold: \(numGlassesSold) glasses of lemonade. No Purchase: \(dailyCustomers.count - numGlassesSold), Total Cash: \(self.supplies.cashSupply)")
        }
        simulateWeatherToday()
        updateMainView()
    }
    
   
    //Misc
    func createTastePref() -> Double {
        let rand = Double(arc4random() % (UInt32(RAND_MAX) + 1))
        return round( (rand / Double(RAND_MAX)) * 100) / 100 //Round to 2 Decimal Places
    }
    
    func generateCustomersForDay() -> [Customer] {
        let numCustomers = Int(arc4random_uniform(UInt32( ((MAX_CUSTOMERS + self.todaysWeather.influence) % MAX_CUSTOMERS) ))) + 1
        
        var customerCollection=[Customer]()
        for var i=0; i<numCustomers; i++ {
            customerCollection.append(Customer(id: i,tastePref: self.createTastePref()))
        }
        
        return customerCollection
    }
    
    func resetView(resetGame: Bool = false){
        self.lemonsToMix = 0
        self.iceToMix = 0
        lemonsToPurchase = 0
        iceCubesToPurchase = 0
        if resetGame {
            self.supplies = Supplies(aMoney: 10, aLemons: 1, aIcecubes: 1)
            simulateWeatherToday()
        }
    }
    

    func initWeather(){
        
        let coldWeather = Weather(name:"Cold", image: UIImage(named: "cold.png"), influence:-4, temp: 30)
        let mildWeather = Weather(name:"Mild", image: UIImage(named: "mild.png"), influence:0,temp: 70)
        let warmWeather = Weather(name:"Warm", image: UIImage(named: "warm.png"), influence:6,temp: 95)
    
        self.weatherArray = [coldWeather,mildWeather,warmWeather]
    }
    
    func simulateWeatherToday() {
        if(self.weatherArray.isEmpty){
            initWeather()
        }
        var nextWeather = Weather()
        repeat{
            let index = Int(arc4random_uniform((UInt32(weatherArray.count))))
             nextWeather = weatherArray[index]
        } while nextWeather.name == self.todaysWeather.name

        self.todaysWeather = nextWeather
        print("All Weather - \(self.weatherArray)")
        print ("Today's Weather is:\(self.todaysWeather) ")
    }
    
    func updateMainView () {
        //Update Inventory
        self.availableCashLabel.text = "$\(self.supplies.cashSupply)"
        self.lemonInventoryLabel.text = "\(self.supplies.lemonSupply) Lemons"
        self.iceInventoryLabel.text = "\(self.supplies.iceSupply) Ice Cubes"
        self.availableCashLabel.sizeToFit()
        
        //Update Purchase
        self.lemonPurchaseLabel.text = "\(self.lemonsToPurchase)"
        self.icePurchaseLabel.text = "\(self.iceCubesToPurchase)"
        
        //Update Mix
        self.lemonMixLabel.text = "\(lemonsToMix)"
        self.iceMixLabel.text = "\(iceToMix)"
      
        //update weatherImage & Label
        self.weatherImageView.image = self.todaysWeather.image
        self.weatherLabel.text = self.todaysWeather.name
        self.weatherLabel.sizeToFit()
    }
    
    func showAlertWithText(
        header: String = "Warning",
        message: String){
            
            let alert  = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
    }
}

