//
//  StopwatchTime.swift
//  Interval Timer Example
//
//  Created by 김명유 on 2019/11/24.
//  Copyright © 2019 myungyu Kim. All rights reserved.
//

import Foundation

struct StopwatchTime {
    var time: UInt
    var test: Int
    
    static let null: StopwatchTime = StopwatchTime(time: 0, test: 0)
}

extension StopwatchTime {
    private static func stringFromTime(_ time: UInt) -> String {
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

func ==(lhs: StopwatchTime, rhs: StopwatchTime) -> Bool {
    return lhs.time == rhs.time
}

extension StopwatchTime: CustomStringConvertible {
    var description: String { return StopwatchTime.stringFromTime(time) }
}
