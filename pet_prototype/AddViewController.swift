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

//    @IBOutlet weak var tfContext: UITextField!
    @IBOutlet weak var tfContext: UITextView!
    
    
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
        
        let current_date_string = formatter(Date())
        let sqlite = SQLite()
        
        realTitle = tfTitle.text!
        realContext = tfContext.text!
        
        let viewController = ViewController()
        events.append(viewController.selectDateType!)
        
        let insertResult = sqlite.insert("",realContext, receiveDate, current_date_string)
        if insertResult{
            let resultAlert = UIAlertController(title: "Dogter", message: "+1 능력 상승 되었습니다.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "네, 알겠습니다.", style: .default, handler: {ACTION in
                self.navigationController?.popViewController(animated: true)
            })
            
            resultAlert.addAction(okAction)
            present(resultAlert, animated: true, completion: nil)
        }else{
            let resultAlert = UIAlertController(title: "Dogter", message: "등록 실패했습니다.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "네, 알겠습니다.", style: .default, handler: {ACTION in
                self.navigationController?.popViewController(animated: true)
            })
            
            resultAlert.addAction(okAction)
            present(resultAlert, animated: true, completion: nil)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func formatter(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dataString = dateFormatter.string(from: date)
        
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
