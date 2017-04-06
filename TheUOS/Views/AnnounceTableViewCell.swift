//
//  AnnounceTableViewCell.swift
//  TheUOS
//
//  Created by MJ on 2017. 3. 26..
//  Copyright © 2017년 uoscs09. All rights reserved.
//

import UIKit

class AnnounceTableViewCell: UITableViewCell {
    @IBOutlet weak var label: UILabel! {
        didSet{
            label.lineBreakMode = .byWordWrapping
            label.numberOfLines = 3;
        }
    }
}
