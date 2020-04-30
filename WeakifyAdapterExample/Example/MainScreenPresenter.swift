//
//  MainScreenPresenter.swift
//  WeakifyAdapterExample
//
//  Created by Victor Kurinny on 30.04.2020.
//  Copyright © 2020 VictorKurinny. All rights reserved.
//

import Foundation

final class MainScreenPresenter {
    weak var view: MainScreenViewController?

    func viewDidAppear() {
        view?.render(status: "Some status")
    }
}
