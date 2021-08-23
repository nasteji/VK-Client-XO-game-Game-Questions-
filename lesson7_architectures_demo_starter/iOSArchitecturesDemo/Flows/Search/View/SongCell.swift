//
//  SongCell.swift
//  iOSArchitecturesDemo
//
//  Created by Анастасия Живаева on 14.08.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

final class SongCell: UITableViewCell {
    
    // MARK: - Subviews
    
    private(set) lazy var songName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 16.0)
        return label
    }()
    
    private(set) lazy var artistName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .green
        label.font = UIFont.systemFont(ofSize: 18.0)
        return label
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureUI()
    }
    
    // MARK: - Methods
    
    func configure(with cellModel: SongCellModel) {
        self.artistName.text = cellModel.artistName
        self.songName.text = cellModel.songName
    }
    
    // MARK: - UI
    
    override func prepareForReuse() {
        [self.artistName, self.songName].forEach { $0.text = nil }
    }
    
    private func configureUI() {
        self.addSongName()
        self.addArtistName()
    }
    
    private func addSongName() {
        self.contentView.addSubview(self.songName)
        NSLayoutConstraint.activate([
            self.songName.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8.0),
            self.songName.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 12.0),
            self.songName.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -40.0)
            ])
    }
    
    private func addArtistName() {
        self.contentView.addSubview(self.artistName)
        NSLayoutConstraint.activate([
            self.artistName.topAnchor.constraint(equalTo: self.songName.bottomAnchor, constant: 4.0),
            self.artistName.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 12.0),
            self.artistName.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -40.0)
            ])
    }
    
}
