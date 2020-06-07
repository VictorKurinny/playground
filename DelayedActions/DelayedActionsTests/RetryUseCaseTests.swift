//
//  RetryUseCaseTests.swift
//  SchedulerMockTests
//
//  Created by Victor Kurinny on 07.06.2020.
//  Copyright © 2020 VictorKurinny. All rights reserved.
//

import XCTest
import DelayedActions

class RetryUseCaseTests: XCTestCase {
    func test_retriesAfterDelay() {
        var callbackCalled = false
        let schedulerMock = SchedulerMock()
        let sut = RetryUseCase(scheduler: schedulerMock) {
            callbackCalled = true
        }

        sut.scheduleRetry()
        schedulerMock.timeTravel(by: 6.0)

        XCTAssertTrue(callbackCalled)
    }
}
