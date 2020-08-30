//
//  ListViewController.swift
//  IOSCodeChallenge
//
//  Created by neelam panwar on 25/08/20.
//  Copyright © 2020 Neelam Panwar. All rights reserved.
//

import UIKit
import SnapKit
import RealmSwift

final class ListViewController: UIViewController {
    
    //MARK:- Public Properties
    private var listTableView = UITableView()
    private var arrayListModel = List<ListDataModel>()
    
    //MARK:- Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigation()
        setUpTableView()
        fetchDataList()
    }
    
    //MARK:- View Controller Methods
    func setUpTableView(){
        
        ///Add TableView to Main View
        listTableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.reuseableIdentifier)
        view.addSubview(listTableView)
        view.backgroundColor = .white
        
        /// Set TableView constraint with respect to main view
        listTableView.snp.makeConstraints { (make) in
            
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
        }
        
        listTableView.estimatedRowHeight = 88.0
        listTableView.separatorStyle = .none
        listTableView.delegate = self
        listTableView.dataSource = self
        
    }
    
    //Set Up Navigation
    func setUpNavigation() {
        navigationItem.title = NSLocalizedString("List", comment: "")

        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    //Fetch Request
    func fetchDataList(){
        
        let request = HttpRequest(path: .challenge, method: .get, params: [:])
        
        let response: ResultCallback<[ListDataModel]?,APIError> = { [weak self] result in
            switch result {
            case .success(let data):
                data?.forEach({ (list) in
                    self?.arrayListModel.append(list)
                    DBManager.sharedInstance.addData(object: list)
                })
                self?.listTableView.reloadData()
            case .failure(_):
                let resultData = DBManager.sharedInstance.getDataFromDB()
                resultData.forEach { (list) in
                    self?.arrayListModel.append(list)
                }
                self?.listTableView.reloadData()
            }
        }
        HTTPHandler.handleAPICallFor(request: request, shouldAddHeader: false, responseOnCompletion: response)
    }
}

//MARK:- UITableViewDelegate , UITableViewDataSource
extension ListViewController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayListModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.reuseableIdentifier, for: indexPath) as? ListTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configureCell(listModel : arrayListModel[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.listData = arrayListModel[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: false)
    }
}

