//
//  DetailViewController.swift
//  pet_prototype
//
//  Created by SeungYeon on 2021/07/30.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var lblTargetDate: UILabel!
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var tvContent: UITextView!
    
    var receiveNo:String!
    var receiveTitle:String!
    var receiveContent:String!
    var receiveTargetDate:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        receiveData(receiveNo, receiveTitle, receiveContent, receiveTargetDate)
        
        lblTargetDate.text = receiveTargetDate
        tfTitle.text = receiveTitle
        tvContent.text = receiveContent

        // Do any additional setup after loading the view.
    }
    
    func receiveData(_ no: String, _ title:String, _ content:String, _ targetDate:String){
        receiveNo = no
        receiveTitle = title
        receiveContent = content
        receiveTargetDate = targetDate
    }
    
    @IBAction func btnModify(_ sender: UIButton) {
        let sqlite = SQLite()
        
        guard tfTitle.text?.isEmpty != true else {alter(message: "제목을 입력해주세요!", value: false); return}
        
        receiveTitle = tfTitle.text!
        receiveContent = tvContent.text!
        receiveTargetDate = lblTargetDate.text!
        
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

