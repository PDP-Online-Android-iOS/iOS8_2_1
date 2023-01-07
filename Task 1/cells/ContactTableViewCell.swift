//
//  ContactTableViewCell.swift
//  Task 1
//
//  Created by Ogabek Matyakubov on 06/01/23.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var tvName: UILabel!
    @IBOutlet weak var tvNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
