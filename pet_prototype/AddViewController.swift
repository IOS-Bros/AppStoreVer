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
        
        guard tfTitle.text?.isEmpty != true else {alter(message: "제목을 입력해주세요!", value: false); return}
        
        realTitle = tfTitle.text!
        realContext = tfContext.text!
        
        let viewController = ViewController()
        events.append(viewController.selectDateType!)
        
        let insertResult = sqlite.insert(realTitle, realContext, receiveDate, current_date_string)
        if insertResult{
            alter(message: "+1 능력 상승 되었습니다.", value: true)
        }else{
            alter(message: "등록 실패 했습니다.", value: true)
        }
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

extension UIViewController{
    func alter(message: String, value: Bool) {
        let resultAlert = UIAlertController(title: "Dogter", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {ACTION in
            if value{
                self.navigationController?.popViewController(animated: true)
            }
        })
        
        resultAlert.addAction(okAction)
        present(resultAlert, animated: true, completion: nil)
    }
}
