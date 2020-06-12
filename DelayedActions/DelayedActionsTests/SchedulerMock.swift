//
//  SchedulerMock.swift
//  DelayedActionsTests
//
//  Created by Victor Kurinny on 07.06.2020.
//  Copyright © 2020 VictorKurinny. All rights reserved.
//

import DelayedActions

final class SchedulerMock: Scheduling {
    func schedule(after delay: TimeInterval, block: @escaping () -> Void) {
        let action = Action(block: block, time: now + delay)
        actions.append(action)
        actions.sort { $0.time < $1.time }
    }

    func timeTravel(by delay: TimeInterval, action: (() -> Void)? = nil) {
        precondition(delay >= 0)
        let targetNow = now + delay

        while let action = actions.first, action.time <= targetNow {
            now = action.time
            action.block()
            actions.removeFirst()
        }

        now = targetNow
        action?()
    }

    @discardableResult
    func timeTravel(by delay: TimeInterval, before: () -> Void, after: () -> Void) -> SchedulerMock {
        if needsDeltaBeforeChaining {
            timeTravel(by: delta)
            needsDeltaBeforeChaining = false
        }

        timeTravel(by: delay - 2 * delta)
        before()
        timeTravel(by: 2 * delta)
        after()

        return self
    }

    private let delta = 1e-9
    private var now: TimeInterval = 0.0
    private var actions = [Action]()
    private var needsDeltaBeforeChaining = true
}

extension SchedulerMock {
    private struct Action {
        let block: () -> Void
        let time: TimeInterval
    }
}
