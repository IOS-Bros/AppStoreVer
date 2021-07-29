//
//  AddViewController.swift
//  pet_prototype
//
//  Created by 예쁘고 비싼 thㅡ레기 on 2021/07/25.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var selectDate: UILabel!
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var tfContext: UITextField!

    
    var realTitle: String!
    var realContext: String!

    var receiveDate: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
      receiveDay(receiveDate)
                
        selectDate.text = receiveDate
        
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.tintColor = UIColor.white
    
        
        
    }
    
    
    func receiveDay(_ date: String){
        receiveDate = date
    }

    @IBAction func btnSubmit(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        let current_date_string = formatter(Date())
//        print(current_date_string)
        
        let sqlite = SQLite()
        
        sqlite.createTable()
        
        
        realTitle = tfTitle.text!
        realContext = tfContext.text!
        
        
        let insertResult = sqlite.insert(realTitle,realContext, receiveDate, current_date_string)
        
        print(insertResult)
    }
    
    func formatter(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dataString = dateFormatter.string(from: date)
        

        self.navigationController?.popViewController(animated: true)
        
        
        return dataString
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
