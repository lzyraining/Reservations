//
//  TimeCollectionViewCell.swift
//  WellsFargoAssessment
//
//  Created by Zhuoyu Li on 2/9/17.
//  Copyright © 2017 Joe. All rights reserved.
//

import UIKit
import IoniconsSwift

class TimeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var timeBtn: UIButton!
    @IBOutlet weak var borderView: UIView!
    
    var timeCellTuple: (Int, Int)? {
        didSet {
            borderView.layer.borderWidth = 1
            borderView.layer.borderColor = UIColor.lightGray.cgColor
            timeLbl.text = getTimeLablString(section: timeCellTuple!.0, row: timeCellTuple!.1)
            timeLbl.backgroundColor = UIColor.white
            timeBtn.tag = timeCellTuple!.0 * 3 + timeCellTuple!.1
            timeBtn.isSelected = false
            let image = Ionicons.iosCheckmarkOutline.image(min(self.bounds.size.width, self.bounds.size.height), color: UIColor.white)
            timeBtn.setImage(image, for: .selected)
        }
    }
    
    func getTimeLablString(section: Int, row: Int) -> String {
        switch section {
        case 0:
            switch row {
            case 0:
                return "09:00 AM"
            case 1:
                return "10:00 AM"
            case 2:
                return "11:00 AM"
            default:
                break
            }
        case 1:
            switch row {
            case 0:
                return "12:00 PM"
            case 1:
                return "01:00 PM"
            case 2:
                return "02:00 PM"
            default:
                break
            }
        case 2:
            switch row {
            case 0:
                return "03:00 PM"
            case 1:
                return "04:00 PM"
            case 2:
                return "05:00 PM"
            default:
                break
            }
        case 3:
            switch row {
            case 0:
                return "06:00 PM"
            case 1:
                return "07:00 PM"
            case 2:
                return "08:00 PM"
            default:
                break
            }
        default:
            break
        }
        return ""
    }
}
