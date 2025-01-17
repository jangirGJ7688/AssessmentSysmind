//
//  ItemTableViewCell.swift
//  AssessmentSysmind
//
//  Created by Ganpat Jangir on 16/01/25.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlets.
    @IBOutlet weak var nameLbl: UILabel!

    //MARK: - Table Cell Methods.
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - Configure Cell Method.
    func configureCell(item: UserModel) {
        self.nameLbl.text = item.name
    }
    
}
