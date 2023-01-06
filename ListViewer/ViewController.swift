//
//  ViewController.swift
//  ListViewer
//
//  Created by Spencer Bell on 1/4/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var viewModel: ViewControllerViewModelProtocol = ViewControllerViewModel()
    
    var activityView:  UIActivityIndicatorView {
        let activityView = UIActivityIndicatorView(style: .large)
        activityView.center = self.view.center
        return activityView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        registerCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    func registerCells() {
        tableView.register(UINib(nibName: "ListCategoryCell", bundle: nil) , forCellReuseIdentifier: "ListCategoryCell")
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let rowData = viewModel.getCellData(from: indexPath) else {
            return UITableViewCell()
        }
        
        switch rowData {
        case .listCategoryCell(let viewModel):
            let cell = tableView.dequeueReusableCell(withIdentifier: "ListCategoryCell", for: indexPath) as! ListCategoryCell
            cell.configure(with: viewModel)
            return cell
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.getListData(from: indexPath) { (listData: ListDetailData?, error: Error?) in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let listData = listData, let vc = storyboard.instantiateViewController(withIdentifier: "ListDetailViewControllerID") as? ListDetailViewController {
                vc.viewModel = ListDetailViewControllerViewModel(listDetailData: listData)
                DispatchQueue.main.async { [weak self] in
                    self?.present(vc, animated: true)
                }
            }
        }
    }
}

extension ViewController: NetworkingDelegate {
    func startNetworkCall() {
        DispatchQueue.main.async { [unowned self] in
            self.tableView.isUserInteractionEnabled = false
            self.view.addSubview(self.activityView)
            self.activityView.startAnimating()
        }
    }
    
    func networkCallCompleted() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.isUserInteractionEnabled = true
            self?.activityView.stopAnimating()
            self?.activityView.removeFromSuperview()
        }
    }
}
