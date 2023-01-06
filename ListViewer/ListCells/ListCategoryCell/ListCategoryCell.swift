//
//  ListCategoryCell.swift
//  ListViewer
//
//  Created by Spencer Bell on 1/4/23.
//

import UIKit

class ListCategoryCell: UITableViewCell {
    @IBOutlet private weak var categoryLabel: UILabel!
    @IBOutlet private weak var categoryLabelBackgroundView: UIView!

    func configure(with viewModel: ListCategoryCellViewModelProtocol) {
        categoryLabel.text = viewModel.categoryLabelText
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryLabelBackgroundView.layer.cornerRadius = 16
        categoryLabelBackgroundView.layer.borderColor = UIColor.label.cgColor
        categoryLabelBackgroundView.layer.borderWidth = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            categoryLabel.textColor = UIColor.systemBackground
            categoryLabelBackgroundView.backgroundColor = UIColor.label
        } else {
            categoryLabel.textColor = UIColor.label
            categoryLabelBackgroundView.backgroundColor = UIColor.systemBackground
        }
    }
}
