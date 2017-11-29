//
//  TicketMovementCell.swift
//  Rebuc
//
//  Created by Paco Chacon de Dios on 28/11/17.
//  Copyright © 2017 Paco Chacon de Dios. All rights reserved.
//

import UIKit

class TicketMovementCell: UITableViewCell {

    @IBOutlet weak var movementTagLabel: UILabel!
    @IBOutlet weak var movementDescriptionLabel: UILabel!
    var movement: TicketMovement? {
        didSet {
            updateUI()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateUI() {

    }

    override func prepareForReuse() {
        super.prepareForReuse()
        backgroundColor = UIColor.graySweet
    }
}
