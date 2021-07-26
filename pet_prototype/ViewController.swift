//
//  ViewController.swift
//  pet_prototype
//
//  Created by 예쁘고 비싼 thㅡ레기 on 2021/07/24.
//

import UIKit
import CalendarLib

class ViewController: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var myCalendar: MGCMonthPlannerView!    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        self.navigationController?.navigationBar.backgroundColor = UIColor.green
        
        myCalendar.dateFormat = "d"
        //
        self.navigationController?.navigationBar.barTintColor = UIColor.init(displayP3Red: 99/255, green: 197/255, blue: 148/255, alpha: 1)
        
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
//        self.addGesture()
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

