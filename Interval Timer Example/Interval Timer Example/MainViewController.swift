//
//  MainViewController.swift
//  Interval Timer Example
//
//  Created by 김명유 on 2019/11/10.
//  Copyright © 2019 myungyu Kim. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Constants
    static let appTitle = "Timers"
    static let tagStandardTimer = "Standard Timer"
    static let tagTimerUsingRx = "Timer using Rx"
    static let tagIntervalTimer = "Interval Timer"
    
    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    let array: Array<String> = [tagStandardTimer, tagTimerUsingRx, tagIntervalTimer]
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewController()
    }
    
    //MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = array[indexPath.row]
        
        return cell
    }
    
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch array[indexPath.row] {
        case MainViewController.tagStandardTimer:
            self.performSegue(withIdentifier: "StandardTimerSegue", sender: self)
        case MainViewController.tagTimerUsingRx:
            self.performSegue(withIdentifier: "TimerUsingRxSegue", sender: self)
        case MainViewController.tagIntervalTimer:
            self.performSegue(withIdentifier: "IntervalTimerSegue", sender: self)
        default:
            return
        }
    }
    
    //MARK: - Private Methods
    func setupViewController() {
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        
        self.navigationItem.title = MainViewController.appTitle
    }
}

