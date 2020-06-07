//
//  SchedulerMockTests.swift
//  DelayedActionsTests
//
//  Created by Victor Kurinny on 07.06.2020.
//  Copyright © 2020 VictorKurinny. All rights reserved.
//

import XCTest
@testable import DelayedActions

final class SchedulerMock {
    init() {

    }

    func schedule(after delay: TimeInterval, block: @escaping () -> Void) {
        let action = Action(block: block, time: now + delay)
        actions.append(action)
        actions.sort { $0.time < $1.time }
    }

    func timeTravel(by delay: TimeInterval) {
        now += delay

        while let action = actions.first, action.time <= now {
            action.block()
            actions.removeFirst()
        }
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

final class SchedulerMockTests: XCTestCase {
    func test_schedulesActionAfterDelay() {
        let accuracy = 1e-6
        let delay = 4.0
        let sut = SchedulerMock()
        var events = [Int]()

        sut.schedule(after: delay) {
            events.append(1)
        }

        sut.timeTravel(by: delay - accuracy)
        XCTAssertTrue(events.isEmpty)
        sut.timeTravel(by: 2 * accuracy)
        XCTAssertEqual(events, [1])
    }

    func test_schedulesActionsByDelayOrder() {
        let sut = SchedulerMock()
        var events = [Int]()

        sut.schedule(after: 5.0) {
            events.append(2)
        }

        sut.schedule(after: 2.0) {
            events.append(1)
        }

        sut.timeTravel(by: 6.0)

        XCTAssertEqual(events, [1, 2])
    }
}
