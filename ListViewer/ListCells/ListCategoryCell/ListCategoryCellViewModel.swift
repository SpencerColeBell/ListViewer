//
//  ListCategoryCellViewModel.swift
//  ListViewer
//
//  Created by Spencer Bell on 1/4/23.
//

import Foundation


protocol ListCategoryCellViewModelProtocol {
    var categoryLabelText: String? { get }
    var endpoint: APIListCallerEndpoint { get }
}

struct ListCategoryCellViewModel: ListCategoryCellViewModelProtocol {
    let categoryLabelText: String?
    let endpoint: APIListCallerEndpoint
    
    init(categoryText: String, endpoint: APIListCallerEndpoint) {
        self.categoryLabelText = categoryText
        self.endpoint = endpoint
    }
}
