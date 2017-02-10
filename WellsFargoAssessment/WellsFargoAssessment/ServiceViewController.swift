//
//  ServiceViewController.swift
//  WellsFargoAssessment
//
//  Created by Zhuoyu Li on 2/8/17.
//  Copyright © 2017 Joe. All rights reserved.
//

import UIKit

let MOTHERS_DAY = "http://4.bp.blogspot.com/--RiYejNPhr4/UYlfxbEV5xI/AAAAAAAAI-E/pKLiLSBCBvE/s640/Mother's-Day-Mini-Album-Titled.png"
let HOT_STONE = "https://calmholistictherapy.files.wordpress.com/2014/08/hot-stone.jpg"
let DEEP_TISSUE = "https://quantum-chiropractic.com/wp-content/uploads/2015/02/Massage.jpg"

class ServiceViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var serviceCollectionView: UICollectionView!
    
    @IBOutlet weak var serviceTableView: UITableView!

    @IBOutlet weak var pageControl: UIPageControl!
    
    var urlString: [String]?
    
    var imageCache = NSCache<AnyObject, AnyObject>()
    
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        urlString = [DEEP_TISSUE, MOTHERS_DAY, HOT_STONE, DEEP_TISSUE, MOTHERS_DAY]
        
        self.title = "SPA SERVICE"
        serviceCollectionView.dataSource = self
        serviceCollectionView.delegate = self
        serviceTableView.dataSource = self
        serviceTableView.delegate = self
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height - 82
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        serviceCollectionView!.collectionViewLayout = layout
        
        serviceTableView.layer.cornerRadius = 10.0
        
        //Set up a delay to change the second row according to the asynchoronized image downloading
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(changeRow), userInfo: nil, repeats: false)
    }
    
    @objc func changeRow() {
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: 1, section: 0)
            self.serviceCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
            self.timer?.invalidate()
            self.timer = nil
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func reserveBtn_tapped(_ sender: UIButton) {
        if sender.tag == 2 {
            let scheduelVc = self.storyboard?.instantiateViewController(withIdentifier: "ScheduelViewController") as? ScheduelViewController
            self.present(scheduelVc!, animated: true, completion: nil)
        }
    }
    
    //Find the correction paging and handle infinite scroll
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var pageIndex = Int(ceil(serviceCollectionView.contentOffset.x / serviceCollectionView.frame.size.width)) - 1
        if serviceCollectionView.contentOffset.x >  3 * serviceCollectionView.frame.size.width {
            let indexPath = IndexPath(row: 1, section: 0)
            serviceCollectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            pageIndex = 0
        }
        else if serviceCollectionView.contentOffset.x < serviceCollectionView.frame.size.width  {
            let indexPath = IndexPath(row: 3, section: 0)
            serviceCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
            pageIndex = 2
        }
        pageControl.currentPage = pageIndex
    }
}

extension ServiceViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    // Create an api call for downloading images from the internet
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "serviceCollectionCell", for: indexPath) as? ServiceCollectionViewCell
        let imageUrl = self.urlString![indexPath.row]
        
        if let image = imageCache.object(forKey:imageUrl as AnyObject)  {
            cell?.imgView.image = image as? UIImage
        }
        else {
            DispatchQueue.global(qos: .userInteractive).async {
                let session = URLSession(configuration: .default)
                session.dataTask(with: URL(string:imageUrl )!, completionHandler: { (data, response, error) in
                    let image = UIImage(data: data!)
                    self.imageCache.setObject(image!, forKey: imageUrl as AnyObject)
                    DispatchQueue.main.async {
                        cell?.imgView.image = image
                        if indexPath.row == 1 {
                            self.serviceCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
                        }
                    }
                }).resume()
            }
            
        }
        cell?.pageIndex = indexPath.row
        return cell!
    }
}

extension ServiceViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "serviceTableCell", for: indexPath)
        cell.selectionStyle = .none
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Swedish Massage"
        case 1:
            cell.textLabel?.text = "Deep Tissue Massage"
        case 2:
            cell.textLabel?.text = "Hot Stone Massage"
            cell.selectionStyle = .default
        case 3:
            cell.textLabel?.text = "Reflexology"
        case 4:
            cell.textLabel?.text = "Trigger Point Therapy"
        default:
            cell.textLabel?.text = "Trigger Point Therapy"
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2 {
            let scheduelVc = self.storyboard?.instantiateViewController(withIdentifier: "ScheduelViewController") as? ScheduelViewController
            self.present(scheduelVc!, animated: true, completion: nil)
        }
    }
}
