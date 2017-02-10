//
//  ViewController.swift
//  WellsFargoAssessment
//
//  Created by Zhuoyu Li on 2/8/17.
//  Copyright © 2017 Joe. All rights reserved.
//

import UIKit
import CoreData
import IoniconsSwift

class ViewController: UIViewController {

    var appdelegate: AppDelegate?
    
    @IBOutlet weak var reservaionTbView: UITableView!
    @IBOutlet weak var addReservationBtn: UIButton!
    var reservations: [ReservationData]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        appdelegate = UIApplication.shared.delegate as? AppDelegate
        
        reservaionTbView.delegate = self
        reservaionTbView.dataSource = self
        
        let image = Ionicons.androidAdd.image(40, color: UIColor.white)
        addReservationBtn.setImage(image, for: .normal)
        
        reservations = [ReservationData]()
        
        fetchReservationDataFromCoreData()
        
        
    }

    private func fetchReservationDataFromCoreData() {
        DispatchQueue.global(qos: .userInteractive).async {
            self.appdelegate = UIApplication.shared.delegate as? AppDelegate
            let context = self.appdelegate?.managedObjectContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Reservation")
            do {
                let array = try context?.fetch(fetchRequest) as? [Reservation]
                if let reservation = array {
                    for reser in reservation {
                        let reservationData = ReservationData()
                        reservationData.reservationID = reser.reversationID
                        reservationData.service = reser.service
                        reservationData.month = reser.month
                        reservationData.time = reser.time
                        reservationData.weekday = reser.weekday
                        reservationData.partySize = reser.partySize
                        reservationData.day = reser.day
                        self.reservations?.append(reservationData)
                        DispatchQueue.main.async {
                            self.reservaionTbView.reloadData()
                        }
                    }
                }
            }
            catch{
                print(error.localizedDescription)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addReservations(_ sender: Any) {
        let serviceVc = self.storyboard?.instantiateViewController(withIdentifier: "ServiceViewController") as? ServiceViewController
        self.present(serviceVc!, animated: true, completion: nil)
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    // Given a static cell as template in section - 1, dynamic show the reservations from user in section - 2
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else if section == 1 {
            if let reservations = reservations {
                return reservations.count
            }
            return 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as? ReservationTableViewCell
        if indexPath.section == 1 {
            cell?.reservation = reservations?[indexPath.row]
        }
        return cell!
    }
}

