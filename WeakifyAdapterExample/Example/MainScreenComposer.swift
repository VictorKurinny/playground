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
        let viewWeakifyAdapter = ViewWeakifyAdapter()
        let presenter = MainScreenPresenter(view: viewWeakifyAdapter)
        let viewController = MainScreenViewController(presenter: presenter)
        viewWeakifyAdapter.adaptee = viewController
        return viewController
    }
}

final private class ViewWeakifyAdapter: MainScreenViewable {
    weak var adaptee: (MainScreenViewable & AnyObject)?

    func render(status: String) {
        adaptee?.render(status: status)
    }
}
