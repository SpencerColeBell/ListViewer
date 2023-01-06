//
//  ListDetailCell.swift
//  ListViewer
//
//  Created by Spencer Bell on 1/5/23.
//

import UIKit

class ListDetailCell: UITableViewCell {
    @IBOutlet private weak var listItemLabel: UILabel!
    
    func configure(with viewModel: ListDetailCellViewModelProtocol) {
        listItemLabel.text = viewModel.listItemLabelText
    }
}
