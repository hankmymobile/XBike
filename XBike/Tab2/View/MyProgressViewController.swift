//
//  MyProgressViewController.swift
//  XBike
//
//  Created by Daniel Beltran on 24/08/22.
//

import UIKit

class MyProgressViewController: UIViewController {
    private let myProgressPresenter = MyProgressPresenter(routesService: RoutesService())
    @IBOutlet weak var tableViewProgress: UITableView!
    var arrayRout : [RouteModel?] = [RouteModel]() {
        didSet{
            tableViewProgress.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.myProgressPresenter.getRoutes()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myProgressPresenter.setViewDelegate(myProgressPresenterDelegate: self)
        self.tableViewProgress.register(UINib(nibName: "ProgressTableViewCell", bundle: nil), forCellReuseIdentifier: "ProgressTableViewCell")
        self.tableViewProgress.separatorStyle = UITableViewCell.SeparatorStyle.singleLine

    }
}

extension MyProgressViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayRout.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProgressTableViewCell") as! ProgressTableViewCell
        cell.configureCell(route: arrayRout[indexPath.row])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
 
}

extension MyProgressViewController: MyProgressPresenterDelegate {
    func showRoutes(routes: [RouteModel?]?) {
        self.arrayRout = routes ?? []
    }
}


