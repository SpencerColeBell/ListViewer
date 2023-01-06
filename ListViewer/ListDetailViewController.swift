//
//  ListDetailViewController.swift
//  ListViewer
//
//  Created by Spencer Bell on 1/5/23.
//

import UIKit

class ListDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var viewModel: ListDetailViewControllerViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
    }
    
    func registerCells() {
        tableView.register(UINib(nibName: "ListDetailCell", bundle: nil) , forCellReuseIdentifier: "ListDetailCell")
    }
}

extension ListDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel?.numberOfSections ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.numberOfRows(in: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let rowData = viewModel?.getCellData(from: indexPath) else { return UITableViewCell() }
        
        switch rowData {
        case .listDetailCell(let viewModel):
            let cell = tableView.dequeueReusableCell(withIdentifier: "ListDetailCell", for: indexPath) as! ListDetailCell
            cell.configure(with: viewModel)
            return cell
        }
    }
}

extension ListDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
