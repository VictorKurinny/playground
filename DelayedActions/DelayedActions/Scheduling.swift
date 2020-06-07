//
//  Scheduling.swift
//  DelayedActions
//
//  Created by Victor Kurinny on 07.06.2020.
//  Copyright © 2020 VictorKurinny. All rights reserved.
//

import Foundation

public protocol Scheduling {
    func schedule(after delay: TimeInterval, block: @escaping () -> Void)
}
