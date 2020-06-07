//
//  RetryUseCase.swift
//  DelayedActions
//
//  Created by Victor Kurinny on 07.06.2020.
//  Copyright © 2020 VictorKurinny. All rights reserved.
//

import Foundation

final public class RetryUseCase {
    public init(onRetry: @escaping () -> Void) {
        self.onRetry = onRetry
    }

    public func scheduleRetry() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            guard let self = self else { return }

            self.onRetry()
        }
    }

    private let onRetry: () -> Void
}
