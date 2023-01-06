//
//  ViewControllerViewModel.swift
//  ListViewer
//
//  Created by Spencer Bell on 1/4/23.
//

import Foundation

typealias TableViewSection = Int

enum ViewControllerViewModelRowData {
    case listCategoryCell(viewModel: ListCategoryCellViewModelProtocol)
}

protocol TableViewDataProvider {
    var numberOfSections: Int { get }
    
    func numberOfRows(in section: TableViewSection) -> Int
    mutating func reloadData()
}

protocol ViewControllerViewModelProtocol: TableViewDataProvider {
    var delegate: NetworkingDelegate? { get set }
    
    func getCellData(from indexPath: IndexPath) -> ViewControllerViewModelRowData?
    func getListData(from indexPath: IndexPath, completion: @escaping (ListDetailData?, Error?) -> Void)
}

struct ViewControllerViewModel: ViewControllerViewModelProtocol {
    typealias Row = ViewControllerViewModelRowData
    var apiCaller: APIListCallerProtocol
    var cellData: [Row] = []
    // doesn't need to be weak since this is a struct, but there's no harm either. 
    weak var delegate: NetworkingDelegate?
    
    init(apiCaller: APIListCallerProtocol = APIListCaller()) {
        self.apiCaller = apiCaller
        self.cellData = reconfiguredCellData()
    }
    
    var numberOfSections: Int {
        1
    }
    
    func numberOfRows(in section: TableViewSection) -> Int {
        section == 0 ? cellData.count : 0
    }
    
    func getCellData(from indexPath: IndexPath) -> ViewControllerViewModelRowData? {        
        indexPath.section == 0 ? cellData[indexPath.row] : nil
    }
    
    func reconfiguredCellData() -> [Row] {
        let rows: [Row] =
        [
            .listCategoryCell(viewModel: ListCategoryCellViewModel(categoryText: "Cat Breeds", endpoint: .catBreeds)),
            .listCategoryCell(viewModel: ListCategoryCellViewModel(categoryText: "Cat Facts", endpoint: .catFacts))
        ]
        
        return rows
    }
    
    func getListData(from indexPath: IndexPath, completion: @escaping (ListDetailData?, Error?) -> Void) {
        guard indexPath.section == 0 else {
            completion(nil, NSError())
            return
        }
        switch cellData[indexPath.row] {
        case .listCategoryCell(viewModel: let viewModel):
            guard let url = viewModel.endpoint.url else {
                completion(nil, NSError())
                return
            }
            delegate?.startNetworkCall()
            switch viewModel.endpoint {
            case .catBreeds:
                apiCaller.fetchListDetailData(
                    rawDataType: CatBreedsData.self,
                    url: url) { (catBreedsData: CatBreedsData?, error: Error?) in
                        guard let catBreedsData = catBreedsData else {
                            delegate?.networkCallCompleted()
                            completion(nil, error)
                            return
                        }
                        delegate?.networkCallCompleted()
                        completion(ListDetailData(catBreedsData: catBreedsData), error)
                    }
            case .catFacts:
                apiCaller.fetchListDetailData(
                    rawDataType: CatFactsData.self,
                    url: url) { (catFactsData: CatFactsData?, error: Error?) in
                        guard let catFactsData = catFactsData else {
                            delegate?.networkCallCompleted()
                            completion(nil, error)
                            return
                        }
                        delegate?.networkCallCompleted()
                        completion(ListDetailData(catFactsData: catFactsData), error)
                    }
            }
        }
    }

    mutating func reloadData() {
        self.cellData = reconfiguredCellData()
    }
}


// networking protocol
protocol NetworkingDelegate: AnyObject {
    func startNetworkCall()
    func networkCallCompleted()
}
