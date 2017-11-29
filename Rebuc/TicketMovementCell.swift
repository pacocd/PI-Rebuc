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
        guard let movement = movement else { return }
        switch movement.movementTagId {
        case 1:
            movementTagLabel.text = "Respuesta"
            backgroundColor = UIColor.greenSweet
        case 2:
            movementTagLabel.text = "Pregunta"
            backgroundColor = UIColor.graySweet
        case 3:
            movementTagLabel.text = "Cierre"
            backgroundColor = UIColor.redSweet
        default:
            movementTagLabel.text = ""
        }
        movementDescriptionLabel.text = movement.description
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        backgroundColor = UIColor.graySweet
        movementDescriptionLabel.text = ""
        movementTagLabel.text = ""
    }
}
