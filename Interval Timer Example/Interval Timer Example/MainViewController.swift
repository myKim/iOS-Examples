//
//  MainViewController.swift
//  Interval Timer Example
//
//  Created by 김명유 on 2019/11/10.
//  Copyright © 2019 myungyu Kim. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    let array: Array<String> = ["Timer", "Timer using Rx", "Interval Timer"]
    
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
    }
    
    //MARK: - Private Methods
    func setupViewController() {
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        
        self.navigationItem.title = "Timers"
    }
}

