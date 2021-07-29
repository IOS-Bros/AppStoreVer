//
//  ViewController.swift
//  pet_prototype
//  Created by 예쁘고 비싼 thㅡ레기 on 2021/07/24.
//  Modified by GR on 21/07/29 : removed old Calendar, adjust FSCalendar

import UIKit
import FSCalendar

let formatter = DateFormatter()
var selectDate01 = ""
var events: Array<Date> = []

class ViewController: UIViewController{
    
    @IBOutlet weak var calendar: FSCalendar!
    
    @IBOutlet weak var lblSchedule: UILabel!
    
    
    var selectDateType = formatter.date(from: selectDate01)
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.navigationController?.navigationBar.barTintColor = UIColor.init(displayP3Red: 99/255, green: 197/255, blue: 148/255, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy-MM-dd"
        
        
        calendarTextcolor()
        encodingMonth()
        
        
        /*
            필요에 따라서 사용하기
            초기 세팅 >> 0.2 >> 1은 가장 선명하게
            // 년월에 흐릿하게 보이는 애들 없애기
            calendar.appearance.headerMinimumDissolvedAlpha = 0
        */
                
                // extension
        calendar.delegate = self
        calendar.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
           
            formatter.locale = Locale(identifier: "ko_KR")
            formatter.dateFormat = "yyyy-MM-dd"
    //        events.append(selectDateType!)
            print("Reload")
            if events.contains(selectDateType!){
                print(events[0])
            }else{
                print("No Data")
            }
            calendar.delegate = self
            calendar.dataSource = self
    //        calendar.setCurrentPage(selectDateType! + 2592000, animated: true)
            calendar.reloadData()
            
        }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addSegue" {
            let detail = segue.destination as! AddViewController
            detail.receiveDay(selectDate01)
            events.append(selectDateType!)
                    
                print(events[0])
        }
    }
        
    func calendarTextcolor(){
            // 달력의 평일 날짜 색깔
            calendar.appearance.titleDefaultColor = .black
            // 달력의 토,일 날짜 색깔
            calendar.appearance.titleWeekendColor = .red
            // 달력의 맨 위의 년도, 월의 색깔
            calendar.appearance.headerTitleColor = .systemPink
            // 달력의 요일 글자 색깔
            calendar.appearance.weekdayTextColor = .orange
        }
        
    func encodingMonth(){
        // 달력의 년월 글자 바꾸기
        calendar.appearance.headerDateFormat = "YYYY년 M월"
        // 달력의 요일 글자 바꾸는 방법 1
        calendar.locale = Locale(identifier: "ko_KR")
        // 달력의 요일 글자 바꾸는 방법 2
        //        calendar.calendarWeekdayView.weekdayLabels[0].text = "일"
        //        calendar.calendarWeekdayView.weekdayLabels[1].text = "월"
        //        calendar.calendarWeekdayView.weekdayLabels[2].text = "화"
        //        calendar.calendarWeekdayView.weekdayLabels[3].text = "수"
        //        calendar.calendarWeekdayView.weekdayLabels[4].text = "목"
        //        calendar.calendarWeekdayView.weekdayLabels[5].text = "금"
        //        calendar.calendarWeekdayView.weekdayLabels[6].text = "토"
            }
        
        
    func setUpEvents() {
                
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy-MM-dd"
            
        }
    
}
    
extension ViewController: FSCalendarDelegate,FSCalendarDataSource{
        
        func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            print(formatter.string(from: date) + " 선택됨")
            selectDate01 = formatter.string(from: date)
            selectDateType = formatter.date(from: selectDate01)
            lblSchedule.text = selectDate01
        }
        
        func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
            if events.contains(date) {
                return 1
            } else {
                return 0
            }
        }
        
        /* 특정 날짜에 텍스트 표시하기
        func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
                
                switch formatter.string(from: date) {
                case formatter.string(from: Date()):
                    return "오늘"
                case "2021-07-22":
                    return "출근"
                case "2021-08-23":
                    return "지각"
                case "2021-08-24":
                    return "결근"
                default:
                    return nil
                }
            }
        */

        
}

