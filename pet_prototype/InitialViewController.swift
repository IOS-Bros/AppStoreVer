//
//  InitialViewController.swift
//  pet_prototype
//
//  Created by 윤재필 on 2021/07/28.
//

import UIKit

class InitialViewController: UIViewController {

    @IBOutlet weak var ivLogo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sqlite = SQLite()
        
        sqlite.createTable()
        
        let time = DispatchTime.now() + .seconds(2)
        ivLogo.alpha = 0
        
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {
            self.ivLogo.alpha = 1.0
        })
        DispatchQueue.main.asyncAfter(deadline: time, execute: self.moveToMain)
    } //viewDidLoad
    
    func moveToMain(){
      let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "main")
        mainVC?.modalPresentationStyle = .fullScreen
        self.present(mainVC!, animated: true, completion: nil)
        self.navigationController?.popViewController(animated: false)
    } //moveToMain
} //InitialViewController
