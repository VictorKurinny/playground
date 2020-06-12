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
        var callbackCalled = false

        sut.schedule(after: delay) {
            callbackCalled = true
        }

        sut
            .timeTravel(by: delay, before: {
                XCTAssertFalse(callbackCalled)
            }, after: {
                XCTAssertTrue(callbackCalled)
            })
    }

    func test_schedulesActionsByDelayOrder() {
        let delay1 = 2.0
        let delay2 = 5.0
        let sut = SchedulerMock()
        var events = [Int]()

        sut.schedule(after: delay2) {
            events.append(2)
        }

        sut.schedule(after: delay1) {
            events.append(1)
        }

        sut
            .timeTravel(by: delay1, before: {
                XCTAssertTrue(events.isEmpty)
            }, after: {
                XCTAssertEqual(events, [1])
            })
            .timeTravel(by: delay2 - delay1, before: {
                XCTAssertEqual(events, [1])
            }, after: {
                XCTAssertEqual(events, [1, 2])
            })
    }

    func test_schedulesActionInsideScheduledAction() {
        let delay1 = 4.0
        let delay2 = 6.0
        let sut = SchedulerMock()
        var callbackCalled = false

        sut.schedule(after: delay1) {
            sut.schedule(after: delay2) {
                callbackCalled = true
            }
        }

        sut
            .timeTravel(by: delay1 + delay2, before: {
                XCTAssertFalse(callbackCalled)
            }, after: {
                XCTAssertTrue(callbackCalled)
            })
    }
}
