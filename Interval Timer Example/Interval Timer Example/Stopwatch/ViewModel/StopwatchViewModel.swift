//
//  StopwatchViewModel.swift
//  Interval Timer Example
//
//  Created by 김명유 on 2019/11/24.
//  Copyright © 2019 myungyu Kim. All rights reserved.
//

import Foundation

enum StopwatchState: Int {
    case stopped = 0
    case running
    case paused
}

protocol StopwatchViewModelDelegate {
    func didUpdateTimer(mainTimeString: String?, lapTimeString: String?)
    func didInsertLap(at indexPath: IndexPath?)
    func didReset(state: StopwatchState, mainTimeString: String?)
    func didPause(state: StopwatchState)
    func didRun(state: StopwatchState)
}

class StopwatchViewModel {
    
    //MARK: - Constants
    
    let timeInterval: UInt = 10 // millisec
    
    //MARK: - Properties
    
    var lapList: Array<StopwatchTime> = []
    var stopwatchTime: StopwatchTime = StopwatchTime(time: 0)
    var stopwatchState: StopwatchState = .stopped
    var timer = Timer()
    
    var delegate: StopwatchViewModelDelegate?
}

extension StopwatchViewModel {
    
    //MARK: - Private Methods
    
    @objc private func updateTimer() {
        stopwatchTime.time += timeInterval
        lapList[0].time += timeInterval
        
        delegate?.didUpdateTimer(mainTimeString: stopwatchTime.timeString, lapTimeString: lapList[0].timeString)
    }
    
    //MARK: - Public Methods
    
    public func insertLap() {
        lapList.insert(StopwatchTime(time: 0), at: 0)
        
        delegate?.didInsertLap(at: IndexPath(row: 0, section: 0))
    }
    
    public func reset() {
        stopwatchTime.time = 0
        lapList.removeAll()
        stopwatchState = .stopped
        
        delegate?.didReset(state: stopwatchState, mainTimeString: stopwatchTime.timeString)
    }
    
    public func pause() {
        timer.invalidate()
        stopwatchState = .paused
        
        delegate?.didPause(state: stopwatchState)
    }
    
    public func run() {
        stopwatchState = .running
        
        delegate?.didRun(state: stopwatchState)

        timer = Timer.init(timeInterval: (0.001 * Double(timeInterval)),
                           target: self,
                           selector: #selector(StopwatchViewModel.updateTimer),
                           userInfo: nil,
                           repeats: true)

        RunLoop.current.add(timer, forMode: .common)
        timer.tolerance = 0.1
    }
}
