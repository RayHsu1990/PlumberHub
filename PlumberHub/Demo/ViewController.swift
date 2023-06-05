//
//  ViewController.swift
//  Demo
//
//  Created by Ray Hsu on 2023/6/5.
//

import UIKit
import GoogleMobileAds

class ViewController: UIViewController {
    private var adId: String {
        "ca-app-pub-2674122388531161/8214736945"
    }
    
    private lazy var banner: GADBannerView = {
        let banner = GADBannerView()
        banner.adUnitID = adId
        banner.rootViewController = self
        banner.delegate = self
        banner.backgroundColor = .systemPink
        banner.load(GADRequest())
        return banner
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(banner)
        banner.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            banner.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            banner.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            banner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            banner.heightAnchor.constraint(equalToConstant: 50)
        ])

    }

}

extension ViewController: GADBannerViewDelegate {
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
        //
    }
    
    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
        print(error.localizedDescription)
    }
}

