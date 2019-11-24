//
//  StopWatchViewController.swift
//  Interval Timer Example
//
//  Created by 김명유 on 2019/11/10.
//  Copyright © 2019 myungyu Kim. All rights reserved.
//

import UIKit

class StopwatchViewController: UIViewController {

    //MARK: - Properties
    
    var viewModel: StopwatchViewModel = StopwatchViewModel()
    var timer = Timer()
    let timeInterval: UInt = 10 // millisec
    
    //MARK: IBOutlet
    
    @IBOutlet weak var timeLabel: UILabel! {
        didSet {
            timeLabel.font = UIFont.monospacedDigitSystemFont(ofSize: timeLabel.font.pointSize, weight: .thin)
        }
    }
    @IBOutlet weak var lapResetButton: UIButton!
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        changeButtonState(.stopped)
    }
    
    //MARK: - IBAction
    
    @IBAction func onClickLapResetButton(_ sender: UIButton) {
        switch viewModel.stopwatchState {
        case .stopped: // 비활성화 상태로 누를 수 없음
            break
        case .running: // 랩타임을 기록한다.
            insertLap()
        case .paused: // 리셋시킨다. -> stopped
            reset()
        }
    }
    
    @IBAction func onClickStartStopButton(_ sender: UIButton) {
        switch viewModel.stopwatchState {
        case .stopped: // 시작한다. -> running
            insertLap()
            run()
        case .running: // 포즈한다. -> puased
            pause()
        case .paused: // 재시작한다. -> running
            run()
        }
    }
    
    //MARK: - Private Methods
    
    @objc private func updateTimer() {
        viewModel.stopwatchTime.time += timeInterval
        viewModel.lapList[0].time += timeInterval
        
        timeLabel.text = viewModel.stopwatchTime.timeString
        
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        cell?.detailTextLabel?.text = viewModel.lapList[0].timeString;
    }
    
    private func insertLap() {
        viewModel.lapList.insert(StopwatchTime(time: 0), at: 0)
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        self.tableView.endUpdates()
    }
    
    private func reset() {
        viewModel.stopwatchState = .stopped
        changeButtonState(.stopped)
        
        viewModel.stopwatchTime.time = 0
        timeLabel.text = viewModel.stopwatchTime.timeString
        
        viewModel.lapList.removeAll()
        tableView.reloadData()
    }
    
    private func pause() {
        viewModel.stopwatchState = .paused
        changeButtonState(.paused)
        
        timer.invalidate()
    }
    
    private func run() {
        viewModel.stopwatchState = .running
        changeButtonState(.running)

        timer = Timer.init(timeInterval: (0.001 * Double(timeInterval)),
                           target: self,
                           selector: #selector(StopwatchViewController.updateTimer),
                           userInfo: nil,
                           repeats: true)

        RunLoop.current.add(timer, forMode: .common)
        timer.tolerance = 0.1
    }
    
    private func changeButtonState(_ state: StopwatchState) {
        switch state {
        case .stopped:
            lapResetButton.isEnabled = false
            lapResetButton.setTitle("랩", for: .normal)
            
            startStopButton.isEnabled = true
            startStopButton.tintColor = #colorLiteral(red: 0, green: 0.8188403845, blue: 0.3101151586, alpha: 0.2031517551)
            startStopButton.setTitle("시작", for: .normal)
            startStopButton.setTitleColor(#colorLiteral(red: 0.1953718066, green: 0.8167234063, blue: 0.3457654119, alpha: 1), for: .normal)
        case .running:
            lapResetButton.isEnabled = true
            lapResetButton.setTitle("랩", for: .normal)
            
            startStopButton.isEnabled = true
            startStopButton.tintColor = #colorLiteral(red: 0.7554287314, green: 0.2796246409, blue: 0.2439345419, alpha: 0.1989511986)
            startStopButton.setTitle("중단", for: .normal)
            startStopButton.setTitleColor(#colorLiteral(red: 0.9620538354, green: 0.2590582371, blue: 0.2211914957, alpha: 1), for: .normal)
            
        case .paused:
            lapResetButton.isEnabled = true
            lapResetButton.setTitle("재설정", for: .normal)
            
            startStopButton.isEnabled = true
            startStopButton.tintColor = #colorLiteral(red: 0, green: 0.8188403845, blue: 0.3101151586, alpha: 0.2031517551)
            startStopButton.setTitle("시작", for: .normal)
            startStopButton.setTitleColor(#colorLiteral(red: 0.1953718066, green: 0.8167234063, blue: 0.3457654119, alpha: 1), for: .normal)
        }
    }
}

extension StopwatchViewController: UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.lapList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.detailTextLabel?.font = UIFont.monospacedDigitSystemFont(ofSize: cell.detailTextLabel?.font.pointSize ?? 17, weight: .regular)
        cell.textLabel?.text = "랩 \(viewModel.lapList.count - indexPath.row)"
        cell.detailTextLabel?.text = viewModel.lapList[indexPath.row].timeString;
        
        return cell
    }
}
