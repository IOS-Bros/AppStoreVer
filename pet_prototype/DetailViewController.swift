//
//  DetailViewController.swift
//  pet_prototype
//
//  Created by SeungYeon on 2021/07/30.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var tvContent: UITextView!
    @IBOutlet weak var detailDatePicker: UIDatePicker!
    
    var receiveNo:String!
    var receiveTitle:String!
    var receiveContent:String!
    var receiveTargetDate:String!
    
    var changeDate : Date!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        receiveData(receiveNo, receiveTitle, receiveContent, receiveTargetDate)
        
        tfTitle.text = receiveTitle
        tvContent.text = receiveContent
        tvContent.placeholder = "내용을 입력해주세요!"
        // Do any additional setup after loading the view.
        
        detailDatePicker.setDate(changeDate, animated: true)
    }
    
    func receiveData(_ no: String, _ title:String, _ content:String, _ targetDate:String){
        receiveNo = no
        receiveTitle = title
        receiveContent = content
        receiveTargetDate = targetDate
        
        // 날짜로 변경
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        changeDate = dateFormatter.date(from: receiveTargetDate)!
    }
    
    @IBAction func changeDatePicker(_ sender: UIDatePicker) {
        let datePickerView = sender
        receiveTargetDate = stringFormatter(datePickerView.date)
    }
    
    
    @IBAction func barBtnModify(_ sender: UIBarButtonItem) {
        let sqlite = SQLite()
        
        guard tfTitle.text?.isEmpty != true else {alter(message: "제목을 입력해주세요!", value: false); return}
        
        receiveTitle = tfTitle.text!
        receiveContent = tvContent.text!
        
        let viewController = ViewController()
        events.append(viewController.selectDateType!)
        
        let updateResult = sqlite.update(receiveNo, receiveTitle, receiveContent, receiveTargetDate)
        if updateResult{
            alter(message: "+1 능력 수정 되었습니다.", value: true)
        }else{
            alter(message: "수정 실패 했습니다.", value: true)
        }
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

