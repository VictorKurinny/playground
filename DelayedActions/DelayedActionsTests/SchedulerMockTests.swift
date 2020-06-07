//
//  SchedulerMockTests.swift
//  DelayedActionsTests
//
//  Created by Victor Kurinny on 07.06.2020.
//  Copyright © 2020 VictorKurinny. All rights reserved.
//

import XCTest
import DelayedActions

final class SchedulerMockTests: XCTestCase {
    func test_schedulesActionAfterDelay() {
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

    func test_schedulesActionInsideScheduledAction() {
        let delay = 4.0
        let sut = SchedulerMock()
        var callbackCalled = false

        sut.schedule(after: delay) {
            sut.schedule(after: delay) {
                callbackCalled = true
            }
        }

        sut.timeTravel(by: 2 * delay - accuracy)
        XCTAssertFalse(callbackCalled)
        sut.timeTravel(by: 2 * accuracy)
        XCTAssertTrue(callbackCalled)
    }
}

extension SchedulerMockTests {
    private var accuracy: TimeInterval {
        return 1e-6
    }
}
