//
//  SongCellModel.swift
//  iOSArchitecturesDemo
//
//  Created by Анастасия Живаева on 14.08.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import Foundation

struct SongCellModel {
    let songName: String
    let artistName: String?
}

final class SongCellModelFactory {
    
    static func cellModel(from model: ITunesSong) -> SongCellModel {
        return SongCellModel(songName: model.trackName, artistName: model.artistName)
    }
}
