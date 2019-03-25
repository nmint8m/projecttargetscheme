//
//  RootVC.swift
//  DemoSettings
//
//  Created by Tam Nguyen M. on 3/25/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import UIKit

final class RootVC: UIViewController {

    @IBOutlet private weak var endpointLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        configObserver()
    }

    private func configObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(udChanged), name: UserDefaults.didChangeNotification, object: nil)
    }

    @objc private func udChanged() {
        if let endpoint = ud.string(forKey: SettingsBundleHelper.SettingsBundleKeys.kEndpoint) {
            endpointLabel.text = endpoint
        } else {
            endpointLabel.text = "Error!"
        }
    }
}
