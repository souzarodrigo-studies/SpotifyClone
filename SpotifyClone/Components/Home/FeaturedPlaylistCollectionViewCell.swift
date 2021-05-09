//
//  FeaturedPlaylistCollectionViewCell.swift
//  SpotifyClone
//
//  Created by Rodrigo Santos on 30/04/21.
//

import UIKit
import SDWebImage

class FeaturedPlaylistCollectionViewCell: UICollectionViewCell {
    static let identifier = "FeaturedPlaylistCollectionViewCell"
        
    private let playlistCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private let playlistNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
        
    private let createNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .thin)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        contentView.backgroundColor = .secondarySystemBackground
        
        contentView.addSubview(playlistCoverImageView)
        contentView.addSubview(playlistNameLabel)
        contentView.addSubview(createNameLabel)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        createNameLabel.frame = CGRect(
            x: 3,
            y: contentView.height - 30,
            width: contentView.width - 6,
            height: 30
        )
        
        playlistNameLabel.frame = CGRect(
            x: 3,
            y: contentView.height - 60,
            width: contentView.width - 6,
            height: 30
        )
        
        let imageSize = contentView.height - 70
        playlistCoverImageView.frame = CGRect(
            x: (contentView.width - imageSize) / 2,
            y: 3,
            width: imageSize,
            height: imageSize
        )
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        playlistNameLabel.text = nil
        createNameLabel.text = nil
        playlistCoverImageView.image = nil
    }
    
    func configure(with viewModel: FeaturedPlaylistCellViewModel) {
        
        playlistNameLabel.text = viewModel.name
        createNameLabel.text = viewModel.creatorName
        playlistCoverImageView.sd_setImage(with: viewModel.artworkURL, completed: nil)
    }
}
