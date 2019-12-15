//
//  StopwatchViewModel.swift
//  Interval Timer Example
//
//  Created by 김명유 on 2019/11/24.
//  Copyright © 2019 myungyu Kim. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

enum StopwatchState: Int {
    case stopped = 0
    case running
    case paused
}

class StopwatchModel: ReactiveCompatible {
    private let behaviorRelay: BehaviorRelay<StopwatchState> = BehaviorRelay(value: .stopped)
    
    var stopwatchState: StopwatchState {
        get { behaviorRelay.value }
        set { behaviorRelay.accept(newValue) }
    }
    
    func asObservable() -> Observable<StopwatchState> {
        behaviorRelay.asObservable()
    }
}

class StopwatchTimeModel: ReactiveCompatible {
    private let behaviorRelay: BehaviorRelay<StopwatchTime> = BehaviorRelay(value: StopwatchTime.null)
    
    var stopwatchTime: StopwatchTime {
        get { behaviorRelay.value }
        set {
            behaviorRelay.accept(newValue)
        }
    }
    
    func asObservable() -> Observable<StopwatchTime> {
        behaviorRelay.asObservable()
    }
    
    func asObserver() -> AnyObserver<StopwatchTime> {
        Binder(self) { (model, stopwatchTime) in
            model.stopwatchTime = stopwatchTime
        }.asObserver()
    }
}

protocol StopwatchViewModelDelegate {
    
    func didUpdateTimer(mainTimeString: String?, lapTimeString: String?)
    func didInsertLap(at indexPath: IndexPath?)
    func didReset(state: StopwatchState, mainTimeString: String?)
}

class StopwatchViewModel {
    
    //MARK: - Constants
    let timeInterval: UInt = 10 // millisec
    
    //MARK: - Properties
    private let disposeBag = DisposeBag()
    
    var stopwatchTime = StopwatchTimeModel()
    
    var lapList: Array<StopwatchTime> = []
//    var stopwatchTime = StopwatchTime(time: 0)
    var stopwatch = StopwatchModel()
    
    var timer = Timer()
    
    var delegate: StopwatchViewModelDelegate?
}

extension StopwatchViewModel {
    
    //MARK: - Private Methods
    @objc private func updateTimer() {
//        stopwatchTime.stopwatchTime.time += timeInterval
        stopwatchTime.stopwatchTime.test += 1
        lapList[0].time += timeInterval
        
//        delegate?.didUpdateTimer(mainTimeString: stopwatchTime.stopwatchTime.description, lapTimeString: lapList[0].description)
    }
    
    //MARK: - Public Methods
    public func insertLap() {
        lapList.insert(StopwatchTime(time: 0, test: 0), at: 0)
        
        delegate?.didInsertLap(at: IndexPath(row: 0, section: 0))
    }
    
    public func reset() {
        stopwatchTime.stopwatchTime.time = 0
        lapList.removeAll()
        stopwatch.stopwatchState = .stopped
        
        delegate?.didReset(state: stopwatch.stopwatchState, mainTimeString: stopwatchTime.stopwatchTime.description)
    }
    
    public func pause() {
        timer.invalidate()
        stopwatch.stopwatchState = .paused
    }
    
    public func run() {
        stopwatch.stopwatchState = .running

        timer = Timer.init(timeInterval: (0.001 * Double(timeInterval)),
                           target: self,
                           selector: #selector(StopwatchViewModel.updateTimer),
                           userInfo: nil,
                           repeats: true)

        RunLoop.current.add(timer, forMode: .common)
        timer.tolerance = 0.1
    }
}

extension Reactive where Base: StopwatchTimeModel {
    
    var stopwatchTime: Observable<StopwatchTime> {
        base.asObservable()
    }
}

extension Reactive where Base: StopwatchModel {
    
    var stopwatchState: Observable<StopwatchState> {
        base.asObservable()
    }
}
