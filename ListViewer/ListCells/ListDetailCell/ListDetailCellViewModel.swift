//
//  ListDetailCellViewModel.swift
//  ListViewer
//
//  Created by Spencer Bell on 1/5/23.
//

import Foundation

protocol ListDetailCellViewModelProtocol {
    var listItemLabelText: String? { get }
}

struct ListDetailCellViewModel: ListDetailCellViewModelProtocol {
    let listItemLabelText: String?

    // protocol is an optional String to match the .text property of a label; some APIs (combine in paritcular) need
    // optionality of type to match and won't work with an unwrapped string.
    init(listItemLabelText: String) {
        self.listItemLabelText = listItemLabelText
    }
}
