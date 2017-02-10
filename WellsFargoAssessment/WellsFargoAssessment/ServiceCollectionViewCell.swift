//
//  ServiceCollectionViewCell.swift
//  WellsFargoAssessment
//
//  Created by Zhuoyu Li on 2/8/17.
//  Copyright © 2017 Joe. All rights reserved.
//

import UIKit

class ServiceCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var lbl1: UILabel!
    
    @IBOutlet weak var lbl2: UILabel!
    
    @IBOutlet weak var lbl3: UILabel!
    
    @IBOutlet weak var lbl4: UILabel!
    
    @IBOutlet weak var reserveBtn: UIButton!
    
    var pageIndex: Int? {
        didSet {
            switch pageIndex! {
            case 1:
                lbl1.text = "$50 OFF"
                lbl2.text = "Mother's Day"
                lbl3.text = "MASSAGE"
                lbl4.text = "AVAILABLE MAY 1 - 15"
                reserveBtn.tag = pageIndex!
            case 2:
                lbl1.text = "20% OFF"
                lbl2.text = "Hot Stone"
                lbl3.text = "MASSAGE"
                lbl4.text = "AVAILABLE MAY 1 - 16"
                reserveBtn.tag = pageIndex!
            case 3:
                lbl1.text = "10% OFF"
                lbl2.text = "Deep Tissue"
                lbl3.text = "MASSAGE"
                lbl4.text = "AVAILABLE APRIL 10 - 28"
                reserveBtn.tag = pageIndex!
            default:
                break
            }
        }
    }
}
