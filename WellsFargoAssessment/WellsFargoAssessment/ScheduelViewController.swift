//
//  ScheduelViewController.swift
//  WellsFargoAssessment
//
//  Created by Zhuoyu Li on 2/8/17.
//  Copyright © 2017 Joe. All rights reserved.
//

import UIKit
import IoniconsSwift
import CoreData

class ScheduelViewController: UIViewController, UICollectionViewDelegateFlowLayout, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var currentMonthLbl: UILabel!
    @IBOutlet weak var calenderCollectionView: UICollectionView!
    @IBOutlet weak var timeCollectionView: UICollectionView!
    @IBOutlet weak var serviceView: UIView!
    @IBOutlet weak var reserveBtn: UIButton!
    @IBOutlet weak var partySizeLbl: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var pickerParentView: UIView!
    
    var calendarCellData: [CalendarCellData]?
    private var isDateSelected: Bool?
    private var isTimeSelected: Bool?
    private var pickerViewDataSource = [Int]()
    private var partySize = 1 {
        didSet {
            partySizeLbl.text = "\(partySize)"
        }
    }
    private var tempPartySize = 1
    private var reservation = ReservationData()
    private var appdelegate: AppDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let image = Ionicons.chevronLeft.image(40, color: UIColor.white)
        backBtn.setImage(image, for: .normal)
        self.imgView.image = UIImage(named: "hotstone")
        serviceView.layer.borderWidth = 1
        serviceView.layer.borderColor = UIColor.lightGray.cgColor
        
        calenderCollectionView.dataSource = self
        calenderCollectionView.delegate = self
        timeCollectionView.dataSource = self
        timeCollectionView.delegate = self
        pickerView.dataSource = self
        pickerView.delegate = self
        
        //Get Current Month Day Infor
        let calendarCellHepler = CalendarCellHepler()
        let startDayTuple = calendarCellHepler.getCurrentMonthDayAndWeekday()
        calendarCellData = calendarCellHepler.prepareCalendarCellData(startDate: startDayTuple)
        currentMonthLbl.text = calendarCellHepler.getCurrentMonth()
        
        //Validate the reservation btn
        isDateSelected = false
        isTimeSelected = false
        validateReserveBtn()
        
        partySizeLbl.layer.borderWidth = 1
        partySizeLbl.layer.borderColor = UIColor.black.cgColor
        partySizeLbl.layer.cornerRadius = 3
        pickerParentView.isHidden = true
        pickerViewDataSource = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
        
        reservation.service = "Hot Stone Massage"
        reservation.month = currentMonthLbl.text
        reservation.reservationID = randomString(length: 16)
    }

    //Generate random reservationID for More Implemetiaon in future, e.g. delete or reschedule reservation
    func randomString(length: Int) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backBtn_tapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func calendarBtn_tapped(_ sender: Any) {
        let btn = sender as? UIButton
        if let data = calendarCellData {
            for i in 0..<data.count {
                let indexPath = IndexPath(row: i, section: 0)
                let cell = calenderCollectionView.cellForItem(at: indexPath) as? CalendarCollectionViewCell
                if i == btn?.tag {
                    cell!.calendarBtn.isSelected = !cell!.calendarBtn!.isSelected
                    if cell!.calendarBtn.isSelected {
                        cell?.borderView.backgroundColor = UIColor.init(red: 166/255, green: 200/255, blue: 236/255, alpha: 1)
                        isDateSelected = true
                        validateReserveBtn()
                        reservation.day = cell?.calendarCellData?.dayNumber
                        reservation.weekday = cell?.calendarCellData?.weekday
                    }
                    else {
                        cell!.borderView.backgroundColor = UIColor.white
                        isDateSelected = false
                        validateReserveBtn()
                        reservation.day = nil
                        reservation.weekday = nil
                    }
                }
                else {
                    cell?.calendarBtn.isSelected = false
                    cell?.borderView.backgroundColor = UIColor.white
                }
            }
        }
    }
    
    @IBAction func timeBtn_tapped(_ sender: Any) {
        let btn = sender as? UIButton
        for i in 0..<12 {
            let tuple = (i / 3, i % 3)
            let indexPath = IndexPath(row: tuple.1, section: tuple.0)
            let cell = timeCollectionView.cellForItem(at: indexPath) as? TimeCollectionViewCell
            if i == btn!.tag {
                cell!.timeBtn.isSelected = !cell!.timeBtn.isSelected
                if cell!.timeBtn.isSelected {
                    cell?.timeLbl.backgroundColor = UIColor.init(red: 166/255, green: 200/255, blue: 236/255, alpha: 1)
                    isTimeSelected = true
                    validateReserveBtn()
                    reservation.time = cell?.getTimeLablString(section: tuple.0, row: tuple.1)
                }
                else {
                    cell!.timeLbl.backgroundColor = UIColor.white
                    isTimeSelected = false
                    validateReserveBtn()
                    reservation.time = nil
                }
            }
            else {
                cell?.timeBtn.isSelected = false
                cell?.timeLbl.backgroundColor = UIColor.white
            }
        }
    }
    
    private func validateReserveBtn() {
        if isDateSelected! && isTimeSelected! {
            reserveBtn.isEnabled = true
        }
        else {
            reserveBtn.isEnabled = false
        }
        
        if reserveBtn.isEnabled {
            reserveBtn.backgroundColor = UIColor.init(red: 0/255, green: 99/255, blue: 288/255, alpha: 1)
        }
        else {
            reserveBtn.backgroundColor = UIColor.init(red: 123/255, green: 177/255, blue: 222/255, alpha: 1)
        }
    }
    
    @IBAction func reservationBtn_tapped(_ sender: Any) {
        reservation.partySize = "\(partySize)"
        saveReservationInCoreData(reservation)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "baseView")
        self.present(vc!, animated: true, completion: nil)
    }
    
    private func saveReservationInCoreData(_ reservation: ReservationData) {
        appdelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appdelegate?.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "Reservation", in: context!)
        let reservationToSave = NSManagedObject(entity: entity!, insertInto: context!) as? Reservation
        reservationToSave?.reversationID = reservation.reservationID
        reservationToSave?.service = reservation.service
        reservationToSave?.month = reservation.month
        reservationToSave?.day = reservation.day
        reservationToSave?.weekday = reservation.weekday
        reservationToSave?.time = reservation.time
        reservationToSave?.partySize = reservation.partySize
        do {
            try context?.save()
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func partySizeBtn_tapped(_ sender: Any) {
        let btn = sender as? UIButton
        btn!.isSelected = !btn!.isSelected
        if btn!.isSelected {
            pickerParentView.isHidden = false
        }
        else {
            pickerParentView.isHidden = true
        }
        
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerViewDataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(pickerViewDataSource[row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        tempPartySize = pickerViewDataSource[row]
    }
    
    @IBAction func doneBtn_tapped(_ sender: Any) {
        partySize = tempPartySize
        pickerParentView.isHidden = true
    }
    
    @IBAction func cancelBtn_tapped(_ sender: Any) {
        pickerParentView.isHidden = true
    }
}

extension ScheduelViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == calenderCollectionView {
            if let data = calendarCellData {
                return data.count
            }
            return 0
        }
        else {
            return 3
        }
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == calenderCollectionView {
            return 1
        }
        else {
            return 4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == calenderCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calendarCell", for: indexPath) as? CalendarCollectionViewCell
            cell?.calendarCellData = calendarCellData?[indexPath.row]
            cell?.btnTag = indexPath.row
            return cell!
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "timeCell", for: indexPath) as? TimeCollectionViewCell
            cell?.timeCellTuple = (indexPath.section, indexPath.row)
            return cell!
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == calenderCollectionView {
            return CGSize(width: 56, height: collectionView.frame.size.height)
        }
        else {
            return CGSize(width: collectionView.frame.size.width/3 - 10, height: collectionView.frame.size.height/3 - 8)
        }
    }
}
