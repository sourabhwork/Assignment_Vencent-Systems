//
//  ViewController.swift
//  Assignment_Vencent Systems
//
//  Created by Sourabh Kumbhar on 13/03/21.
//  Copyright © 2021 Sourabh Kumbhar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // IBOutlets
    @IBOutlet weak var tableView    : UITableView!
    
    // Local variables
    private var users               = [User]()
    private var progreeView         : ProgressHUD?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        callToFetchData()
        setupTableView()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.backgroundView = getTableViewBackgroundLabel()
        tableView.separatorColor = .red
        tableView.separatorInset = .zero
    }
    
    private func setupProgressView() {
        progreeView = ProgressHUD(text: ConstantKey.fetchingData)
        self.view.addSubview(progreeView!)
    }

    private func callToFetchData() {
        let networkServices = NetworkServices()
        setupProgressView()
        networkServices.fetchData(completion: { (isSuccess , message, dataArray) in
            if isSuccess {
                self.users = dataArray ?? []
                DispatchQueue.main.async {
                    self.progreeView?.hide()
                    self.tableView.reloadData()
                }
            } else {
                DispatchQueue.main.async {
                    self.progreeView?.hide()
                    self.showAlert(title: ConstantKey.error, message: message ?? ConstantKey.somethingWentWrong)
                }
            }
        })
    }
}

// MARK:- UITableView Delegate and Datasource

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Check for no data found
        if users.count == 0 {
            tableView.backgroundView?.isHidden = false
        } else {
            tableView.backgroundView?.isHidden = true
        }
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create cell object
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableCellConstant.vcCell, for: indexPath) as? VCTableViewCell else {
            return UITableViewCell()
        }
        // Check array out of bound
        if indexPath.row < users.count {
            // Set data to cell
            cell.configureCell(user: users[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
}

