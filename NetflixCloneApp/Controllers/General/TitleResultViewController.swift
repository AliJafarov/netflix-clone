//
//  TitleResultViewController.swift
//  NetflixCloneApp
//
//  Created by Ali Jafarov on 14.04.22.
//

import UIKit
import WebKit

class TitleResultViewController: UIViewController {
    
    private let downloadButton: UIButton = {
       let button = UIButton()
       button.translatesAutoresizingMaskIntoConstraints = false
       button.backgroundColor = .red
       button.setTitle("Download", for: .normal)
       button.setTitleColor(.white, for: .normal)
       button.layer.cornerRadius = 8
       button.clipsToBounds = true
       return button
    }()
    
    private let overViewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 10
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 3
        return label
    }()
    
    private let webView: WKWebView = {
       let view = WKWebView()
       view.translatesAutoresizingMaskIntoConstraints = false
       return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(webView)
        view.addSubview(titleLabel)
        view.addSubview(overViewLabel)
        view.addSubview(downloadButton)
        applyConstraints()
    }
    
    private func applyConstraints() {
        let webViewContraints = [
            webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.widthAnchor.constraint(equalTo: view.widthAnchor),
            webView.heightAnchor.constraint(equalToConstant: 250)
        ]
        NSLayoutConstraint.activate(webViewContraints)
        
        let titleLabelCOnstraint = [
            titleLabel.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35)
        ]
        NSLayoutConstraint.activate(titleLabelCOnstraint)
        
        let overHeadConstraints = [
            overViewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            overViewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            overViewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25)
        ]
        NSLayoutConstraint.activate(overHeadConstraints)
        
        let downloadButtonContraints = [
            downloadButton.topAnchor.constraint(equalTo: overViewLabel.bottomAnchor, constant: 20),
            downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadButton.widthAnchor.constraint(equalToConstant: 120),
            downloadButton.heightAnchor.constraint(equalToConstant: 45),
        ]
        NSLayoutConstraint.activate(downloadButtonContraints)
    }
    
    func configure(with model: TitlePreviewViewModel) {
        titleLabel.text = model.title
        overViewLabel.text = model.titleOverview
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.youtubeView.id.videoId)") else {return}
        webView.load(URLRequest(url: url))
    }
    


}
