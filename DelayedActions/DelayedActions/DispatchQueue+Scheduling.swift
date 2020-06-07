//
//  DispatchQueue+Scheduling.swift
//  DelayedActions
//
//  Created by Victor Kurinny on 07.06.2020.
//  Copyright © 2020 VictorKurinny. All rights reserved.
//

import Foundation

extension DispatchQueue: Scheduling {
    public func schedule(after delay: TimeInterval, block: @escaping () -> Void) {
        asyncAfter(deadline: .now() + delay, execute: block)
    }
}
