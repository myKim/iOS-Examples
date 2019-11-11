//
//  StopWatchViewController.swift
//  Interval Timer Example
//
//  Created by 김명유 on 2019/11/10.
//  Copyright © 2019 myungyu Kim. All rights reserved.
//

import UIKit

enum StopWatchState: Int {
    case stopped = 0
    case running
    case paused
}

class StopWatchViewController: UIViewController {

    //MARK: - Properties
    @IBOutlet weak var timeLabel: UILabel! {
        didSet {
            timeLabel.font = UIFont.monospacedDigitSystemFont(ofSize: timeLabel.font.pointSize, weight: .thin)
        }
    }
    @IBOutlet weak var lapResetButton: UIButton!
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var stopWatchState: StopWatchState = .stopped
    var lapList: Array<String> = []
    var timer = Timer()
    var time: UInt = 0
    
    let timeInterval: UInt = 10 // millisec
    
    //MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        changeButtonState(.stopped)
    }
    
    //MARK: - IBAction
    @IBAction func onClickLapResetButton(_ sender: UIButton) {
        switch stopWatchState {
        case .stopped: // 비활성화 상태로 누를 수 없음
            break
        case .running: // 랩타임을 기록한다.
            recordLap()
        case .paused: // 리셋시킨다. -> stopped
            stopWatchState = .stopped
            changeButtonState(.stopped)
            
            time = 0
            timeLabel.text = stringFromTime(time)
        }
    }
    
    @IBAction func onClickStartStopButton(_ sender: UIButton) {
        switch stopWatchState {
        case .stopped: // 시작한다. -> running
            stopWatchState = .running
            changeButtonState(.running)
            
            timer = Timer.scheduledTimer(timeInterval: (0.001 * Double(timeInterval)),
                                         target: self,
                                         selector: #selector(StopWatchViewController.updateTimer),
                                         userInfo: nil,
                                         repeats: true)
            RunLoop.current.add(timer, forMode: .common)
            timer.tolerance = 0.1
        case .running: // 포즈한다. -> puased
            stopWatchState = .paused
            changeButtonState(.paused)
            
            timer.invalidate()
        case .paused: // 재시작한다. -> running
            stopWatchState = .running
            changeButtonState(.running)
            
            timer = Timer.scheduledTimer(timeInterval: (0.001 * Double(timeInterval)),
                                         target: self,
                                         selector: #selector(StopWatchViewController.updateTimer),
                                         userInfo: nil,
                                         repeats: true)
            RunLoop.current.add(timer, forMode: .common)
            timer.tolerance = 0.1
        }
    }
    
    //MARK: - Private Methods
    @objc private func updateTimer() {
        time += timeInterval
        timeLabel.text = stringFromTime(time)
    }
    
    private func recordLap() {
        
    }
    
    private func changeButtonState(_ state: StopWatchState) {
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

extension StopWatchViewController: UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lapList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "랩 \(indexPath.row + 1)"
        cell.detailTextLabel?.text = lapList[indexPath.row];
        
        return cell
    }
}

extension StopWatchViewController {
    
    //MARK: - Time convertor
    private func stringFromTime(_ time: UInt) -> String? {
        var result = "00:00.00"
        var tempTime = time
        
        let milliseconds = tempTime % 1000
        tempTime /= 1000
        let fractions = milliseconds / 10
        
        let seconds = tempTime % 60
        tempTime /= 60
        
        let minutes = tempTime % 60
        tempTime /= 60
        
        let hours = tempTime % 60
        
        if hours > 0 {
            result = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        }
        else {
            result = String(format: "%02d:%02d.%02d", minutes, seconds, fractions)
        }
        return result
    }
}