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
        self.tableViewProgress.isUserInteractionEnabled = true

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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "InitStoryboard", bundle: nil)
        let popUp = storyBoard.instantiateViewController(withIdentifier: "PopUp") as! PopUpViewController
        popUp.modalTransitionStyle = .crossDissolve
        var image: UIImage? = UIImage(data: arrayRout[indexPath.row]?.image ?? Data())
        self.present(popUp, animated: true, completion: {
            popUp.imagen.image = image
        })
    }
    
}

extension MyProgressViewController: MyProgressPresenterDelegate {
    func showRoutes(routes: [RouteModel?]?) {
        self.arrayRout = routes ?? []
    }
}


