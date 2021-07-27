//
//  ViewController.swift
//  pet_prototype
//
//  Created by 예쁘고 비싼 thㅡ레기 on 2021/07/24.
//

import UIKit
import CalendarLib

class ViewController: UIViewController{

    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var myCalendar: MGCMonthPlannerView!    
    
    
    var selectDate1 :Date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        self.navigationController?.navigationBar.backgroundColor = UIColor.green
        
        myCalendar.dateFormat = "d"
        //
        self.navigationController?.navigationBar.barTintColor = UIColor.init(displayP3Red: 99/255, green: 197/255, blue: 148/255, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        
//        self.addGesture()
        
//       Label Touch
        let tap = UITapGestureRecognizer(target: self, action: #selector(clickActionHere))
        lblTitle.isUserInteractionEnabled = true
        lblTitle.addGestureRecognizer(tap)
        
        
        myCalendar.allowsSelection = true
        myCalendar.delegate = self
    
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "addSegue"){
            let vc = segue.destination as! AddViewController
            vc.hereDate = selectDate1
        }
    }
    
    @objc
       func clickActionHere(sender: UITapGestureRecognizer){
           print("HELLEJWALKDNvasdasd")
        /*
             Put some Method to Click Something
        */
     
       }
       
       
       @IBAction func AddAction(_ sender: UIButton) {
           print("ASDaslkjdh")
           
       }
    
    
    
//    func addGesture() {
//
//        let tap = UITapGestureRecognizer(target: self, action: #selector(self.labelTapped(_:)))
//           tap.numberOfTapsRequired = 1
//           self.lblTitle.isUserInteractionEnabled = true
//           self.lblTitle.addGestureRecognizer(tap)
//       }
//
//       @objc
//       func labelTapped(_ tap: UITapGestureRecognizer) {
//
//            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
//            let SecondVC = storyboard.instantiateViewController(withIdentifier: "AddViewController") as! AddViewController
//            self.navigationController?.pushViewController(SecondVC, animated: animated)
//
//
//       }


}

extension ViewController: MGCMonthPlannerViewDelegate{
    
    func monthPlannerView(_ view: MGCMonthPlannerView!, didSelectDayCellAt date: Date!)  {
        selectDate1 = date!
        
        
    
    }
    
}
