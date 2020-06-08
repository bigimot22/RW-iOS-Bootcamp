//
//  AboutRGBViewController.swift
//  Pickasso
//
//  Created by Johandre Delgado  on 01.06.2020.
//  Copyright © 2020 Johandre Delgado . All rights reserved.
//

import UIKit
import WebKit

class AboutRGBViewController: UIViewController {
    @IBOutlet private weak var webview: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        showRGBInfo()
    }

    private func showRGBInfo() {
        if let url = URL(string: "https://en.wikipedia.org/wiki/RGB_color_model") {
            let request = URLRequest(url: url)
            webview.load(request)
        }
    }

    @IBAction private func didTapCloseButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
