//
//  ViewController.swift
//  pet_prototype
//  Created by 예쁘고 비싼 thㅡ레기 on 2021/07/24.
//  Modified by GR on 21/07/29 : removed old Calendar, adjust FSCalendar

import UIKit
import FSCalendar

class ViewController: UIViewController{
   
    var selectDate1 :Date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.navigationController?.navigationBar.barTintColor = UIColor.init(displayP3Red: 99/255, green: 197/255, blue: 148/255, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "addSegue"){
            let vc = segue.destination as! AddViewController
            
        }
    }
    
}
