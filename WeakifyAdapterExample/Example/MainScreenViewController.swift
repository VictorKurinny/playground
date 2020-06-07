//
//  MainScreenViewController.swift
//  WeakifyAdapterExample
//
//  Created by Victor Kurinny on 30.04.2020.
//  Copyright © 2020 VictorKurinny. All rights reserved.
//

import UIKit

final class MainScreenViewController: UIViewController, MainScreenViewable {
    required init(presenter: MainScreenPresentation) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidAppear()
    }

    func render(status: String) {
        //some logic
    }

    private let presenter: MainScreenPresentation
}
