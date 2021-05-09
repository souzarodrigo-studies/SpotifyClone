//
//  AlbumTrackCollectionViewCell.swift
//  SpotifyClone
//
//  Created by Rodrigo Santos on 05/05/21.
//

import UIKit

class AlbumTrackCollectionViewCell: UICollectionViewCell {
    static let identifier = "AlbumTrackCollectionViewCell"

    private let trackNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
        
    private let createNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .thin)
        label.numberOfLines = 0
        return label
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondarySystemBackground
        contentView.backgroundColor = .secondarySystemBackground
        
        contentView.addSubview(trackNameLabel)
        contentView.addSubview(createNameLabel)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        trackNameLabel.frame = CGRect(
            x: 10,
            y: 0,
            width: contentView.width - 15,
            height: contentView.height / 2
        )
        createNameLabel.frame = CGRect(
            x: 10,
            y: contentView.height / 2,
            width: contentView.width - 15,
            height: contentView.height / 2
        )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        trackNameLabel.text = nil
        createNameLabel.text = nil
    }
    
    func configure(with viewModel: AlbumCollectionCellViewModel) {
        
        trackNameLabel.text = viewModel.name
        createNameLabel.text = viewModel.artistName
    }
}
