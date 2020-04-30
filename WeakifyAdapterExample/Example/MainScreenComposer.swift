//
//  MainScreenComposer.swift
//  WeakifyAdapterExample
//
//  Created by Victor Kurinny on 30.04.2020.
//  Copyright © 2020 VictorKurinny. All rights reserved.
//

import UIKit

final class MainScreenComposer {
    func composeMainScreen() -> UIViewController {
        let presenter = MainScreenPresenter()
        let viewController = MainScreenViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }
}
