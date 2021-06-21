//
//  AllNewsCell.swift
//  VK Client
//
//  Created by Анастасия Живаева on 31.05.2021.
//

import UIKit

class AllNewsCell: UITableViewCell {
    
    static let reuseId = "AllNewsCell"
    
    @IBOutlet weak var textNewsLabel: UILabel!
    @IBOutlet weak var imageNewsView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
