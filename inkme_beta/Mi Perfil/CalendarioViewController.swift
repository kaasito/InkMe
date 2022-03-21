//
//  CalendarioViewController.swift
//  inkme_beta
//
//  Created by APPS2M on 17/3/22.
//

import UIKit
import FSCalendar
class CalendarioViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate {

    @IBOutlet weak var segmented: UISegmentedControl!
    @IBOutlet weak var vistaPendientes: UIView!
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var vistaAceptadas: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let calendar = FSCalendar(frame: CGRect(x: 0, y: 88, width: 414, height: 243))
        calendar.dataSource = self
        calendar.delegate = self
        view.addSubview(calendar)
        self.calendar = calendar
    }
    

    @IBAction func segmented(_ sender: UISegmentedControl) {
     
            if sender.selectedSegmentIndex == 0{
                vistaAceptadas.alpha = 1
                vistaPendientes.alpha = 0
                vistaPendientes.isHidden = true
                vistaAceptadas.isHidden = false
                
            }else{
                vistaAceptadas.alpha = 0
                vistaPendientes.alpha = 1
                vistaPendientes.isHidden = false
                vistaAceptadas.isHidden = true
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
