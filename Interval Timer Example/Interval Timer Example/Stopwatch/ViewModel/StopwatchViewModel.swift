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

class StopwatchViewModel {
    
    //MARK: - Properties
    
    var lapList: Array<StopwatchTime> = []
    var stopwatchTime: StopwatchTime = StopwatchTime(time: 0)
    var stopwatchState: StopwatchState = .stopped
}
