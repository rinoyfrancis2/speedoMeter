//
//  HistoryViewController.swift
//  speedoMeter
//
//  Created by Rinoy Francis on 29/10/20.
//

import UIKit

class HistoryViewController: UIViewController {

    var historyData : [Speedo] = []
    @IBOutlet weak var historyTableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        historyTableview.delegate = self
        historyTableview.dataSource = self
        CoredataManager.shared.retirveAllTripsFromLocal { (Speedos) in
            self.historyData = Speedos
            print(self.historyData.count)
            DispatchQueue.main.async {
                self.historyTableview.reloadData()
            }
        }
    }
    deinit {
        historyData = []
    }
    
    @IBAction func backActionButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}


extension HistoryViewController :UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = historyTableview.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as! HistoryTableViewCell
        cell.tripOptionImageView?.image = historyData[indexPath.row].getImage()
        cell.speedLabel?.text = historyData[indexPath.row].getTopSpeed()
        cell.averageSpeedlabel?.text = historyData[indexPath.row].getAverageSpeed()
        cell.timerlabel?.text = historyData[indexPath.row].timer
        cell.distanceLabel?.text = historyData[indexPath.row].getDistance()
        cell.dateLabel?.text = historyData[indexPath.row].date?.changeDateFormat()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presentTo(OptionViewController.DetailViewController, param: historyData[indexPath.row])
    }
}
