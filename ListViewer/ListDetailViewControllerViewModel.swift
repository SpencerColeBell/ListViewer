//
//  ListDetailViewControllerViewModel.swift
//  ListViewer
//
//  Created by Spencer Bell on 1/5/23.
//

import Foundation

enum ListDetailViewControllerViewModelRowData {
    case listDetailCell(viewModel: ListDetailCellViewModelProtocol)
}


protocol ListDetailViewControllerViewModelProtocol: TableViewDataProvider {
    func getCellData(from indexPath: IndexPath) -> ListDetailViewControllerViewModelRowData?
}

struct ListDetailViewControllerViewModel: ListDetailViewControllerViewModelProtocol {
    typealias Row = ListDetailViewControllerViewModelRowData

    var listDetailData: ListDetailData
    
    init(listDetailData: ListDetailData) {
        self.listDetailData = listDetailData
    }
    
    var numberOfSections: Int {
        1
    }
    
    func numberOfRows(in section: TableViewSection) -> Int {
        section == 0 ? listDetailData.listItems.count : 0
    }
    
    func getCellData(from indexPath: IndexPath) -> ListDetailViewControllerViewModelRowData? {
        indexPath.section == 0
        ? .listDetailCell(viewModel: ListDetailCellViewModel(listItemLabelText: listDetailData.listItems[indexPath.row]))
        : nil
    }
    
    mutating func reloadData() { }
}
