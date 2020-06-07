//
//  MainScreenPresenter.swift
//  WeakifyAdapterExample
//
//  Created by Victor Kurinny on 30.04.2020.
//  Copyright © 2020 VictorKurinny. All rights reserved.
//

import Foundation

final class MainScreenPresenter: MainScreenPresentation {
    init(view: MainScreenViewable) {
        self.view = view
    }

    func viewDidAppear() {
        view.render(status: "Some status")
    }

    private let view: MainScreenViewable
}
