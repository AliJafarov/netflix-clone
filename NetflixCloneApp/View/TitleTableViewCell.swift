//
//  TitleTableViewCell.swift
//  NetflixCloneApp
//
//  Created by Ali Jafarov on 11.04.22.
//

import UIKit
import SDWebImage

class TitleTableViewCell: UITableViewCell {

    static let identifier = "TitleTableViewCell"
    
    private let playTitlebutton: UIButton = {
       let button = UIButton()
       let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
       button.setImage(image, for: .normal)
       button.translatesAutoresizingMaskIntoConstraints = false
       button.tintColor = .white
       return button
    }()
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let posterLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style , reuseIdentifier: reuseIdentifier)
        contentView.addSubview(posterImageView)
        contentView.addSubview(posterLabel)
        contentView.addSubview(playTitlebutton)
        applyConstraint()
    }
    
    private func applyConstraint() {
        let posterImageViewConstraint = [
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            posterImageView.widthAnchor.constraint(equalToConstant: 100)
        ]
        NSLayoutConstraint.activate(posterImageViewConstraint)
        
        let posterLabelConstraint = [
            posterLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 20),
            posterLabel.trailingAnchor.constraint(equalTo: playTitlebutton.leadingAnchor, constant: -80),
            posterLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            posterLabel.widthAnchor.constraint(equalToConstant: 150)
        ]
        NSLayoutConstraint.activate(posterLabelConstraint)
        
        let playTitleButtonConstraints = [
                   playTitlebutton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                   playTitlebutton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
               ]
        NSLayoutConstraint.activate(playTitleButtonConstraints)
    }
    
    public func getData(with model: TitleViewModel) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(model.posterURL)") else {return}
        posterImageView.sd_setImage(with: url, completed: nil)
        posterLabel.text = model.titleName
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
    
}
