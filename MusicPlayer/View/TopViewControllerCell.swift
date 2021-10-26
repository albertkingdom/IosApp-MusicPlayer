//
//  topViewControllerCell.swift
//  MusicPlayer
//
//  Created by 林煜凱 on 10/25/21.
//

import Foundation
import UIKit

class TopViewControllerCell: UICollectionViewCell {
    var cellData: SongData? {
        didSet {
            guard let albumImage = UIImage(named: cellData!.albumImage) else { return }
            albumImageView.image = albumImage
            title.text = cellData?.songTitle
        }
    }
    
    lazy var albumImageView: UIImageView = {
       

        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let title: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        layer.cornerRadius = 5
        layer.masksToBounds = true
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout(){
        addSubview(albumImageView)
        addSubview(title)
        NSLayoutConstraint.activate([
            albumImageView.topAnchor.constraint(equalTo: topAnchor),
            albumImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            albumImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/3),
            albumImageView.heightAnchor.constraint(equalTo: heightAnchor)
        ])
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor),
            title.leadingAnchor.constraint(equalTo: albumImageView.trailingAnchor, constant: 5),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 5),
            title.heightAnchor.constraint(equalTo: heightAnchor)
        ])
        title.adjustsFontSizeToFitWidth = true
        
    }
}
