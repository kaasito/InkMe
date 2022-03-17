//
//  CalendarioViewController.swift
//  inkme_beta
//
//  Created by APPS2M on 17/3/22.
//

import UIKit
import FSCalendar
class CalendarioViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate {

    @IBOutlet weak var calendar: FSCalendar!
    override func viewDidLoad() {
        super.viewDidLoad()

        let calendar = FSCalendar(frame: CGRect(x: 0, y: 88, width: 414, height: 243))
        calendar.dataSource = self
        calendar.delegate = self
        view.addSubview(calendar)
        self.calendar = calendar
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
