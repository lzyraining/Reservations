//
//  CalendarCollectionViewCell.swift
//  WellsFargoAssessment
//
//  Created by Zhuoyu Li on 2/9/17.
//  Copyright © 2017 Joe. All rights reserved.
//

import UIKit
import IoniconsSwift

//TODO: Disable the cell when day is the past

class CalendarCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var weekdayLbl: UILabel!
    @IBOutlet weak var dateNumberLbl: UILabel!
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var calendarBtn: UIButton!
    
    var calendarCellData: CalendarCellData? {
        didSet {
            weekdayLbl.text = calendarCellData?.weekday
            dateNumberLbl.text = calendarCellData?.dayNumber
            borderView.layer.borderWidth = 1
            borderView.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    var btnTag: Int? {
        didSet {
            calendarBtn.tag = btnTag!
            calendarBtn.isSelected = false
            let image = Ionicons.iosCheckmarkOutline.image(min(self.bounds.size.width, self.bounds.size.height), color: UIColor.white)
            calendarBtn.setImage(image, for: .selected)
            borderView.backgroundColor = UIColor.white
        }
    }
}
