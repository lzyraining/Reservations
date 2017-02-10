//
//  ReservationTableViewCell.swift
//  WellsFargoAssessment
//
//  Created by Zhuoyu Li on 2/10/17.
//  Copyright © 2017 Joe. All rights reserved.
//

import UIKit

class ReservationTableViewCell: UITableViewCell {

    @IBOutlet weak var borderView: UIView!
    
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var serviceLbl: UILabel!
    @IBOutlet weak var partySizeLbl: UILabel!
    @IBOutlet weak var peroidLbl: UILabel!
    @IBOutlet weak var descripLbl: UILabel!
    
    
    var reservation: ReservationData? {
        didSet {
            descripLbl.text = "Massage focused on the deepest layer of muscles to target knots and release chronic muscle tension."
            peroidLbl.text = "1H"
            partySizeLbl.text = reservation?.partySize
            serviceLbl.text = reservation?.service
            timeLbl.text = reservation?.time
            dateLbl.text = getDayLabelInfo(weekday: reservation!.weekday!, month: reservation!.month!, day: reservation!.day!)
        }
    }
    
    private func getDayLabelInfo(weekday: String, month: String, day: String) -> String {
        return "\(getWeekDayFullString(weekday: weekday)), \(month) \(day), 2017"
    }
    
    private func getWeekDayFullString(weekday: String) -> String {
        switch weekday {
        case "MON":
            return "MONDAY"
        case "TUE":
            return "TUESDAY"
        case "WED":
            return "TUESDAY"
        case "THU":
            return "THURSDAY"
        case "FRI":
            return "FRIDAY"
        case "SAT":
            return "SATURDAY"
        case "SUN":
            return "SUNDAY"
        default:
            break
        }
        return ""
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        borderView.layer.borderWidth = 1
        borderView.layer.borderColor = UIColor.lightGray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
}
