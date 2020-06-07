//
//  SchedulerMock.swift
//  DelayedActionsTests
//
//  Created by Victor Kurinny on 07.06.2020.
//  Copyright © 2020 VictorKurinny. All rights reserved.
//

import Foundation

final class SchedulerMock {
    func schedule(after delay: TimeInterval, block: @escaping () -> Void) {
        let action = Action(block: block, time: now + delay)
        actions.append(action)
        actions.sort { $0.time < $1.time }
    }

    func timeTravel(by delay: TimeInterval) {
        let targetNow = now + delay

        while let action = actions.first, action.time <= targetNow {
            now = action.time
            action.block()
            actions.removeFirst()
        }

        now = targetNow
    }

    private var now: TimeInterval = 0.0
    private var actions = [Action]()
}

extension SchedulerMock {
    private struct Action {
        let block: () -> Void
        let time: TimeInterval
    }
}
