//
//  HomeVC.swift
//  InsuraTest
//
//  Created by Ivan Martin on 05/02/2022.
//

import UIKit

class HomeVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var coordinator: HomeFlow?
    var viewModel: HomeVM?
    
    lazy var child = LoadingView()
    
    var posts: [Post] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupNavigation()
        self.request()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
    }
    
    private func setupNavigation(){
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func setupTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableView.automaticDimension
        
        let nibname = UINib(nibName: "HomeCell", bundle: nil)
        self.tableView.register(nibname, forCellReuseIdentifier: "HomeCell")
        self.tableView.reloadData()
    }
    
    private func request(){
        self.showLoading()
        viewModel?.getPost(completionHandler: { result in
            self.hideLoading()
            switch result{
            case .success(let model):
                DispatchQueue.main.async {
                    self.posts = model
                    self.tableView.reloadData()
                }
            case .failure(let err):
                self.showErrorMessage(message: err.errorDescription)
            }
        })
    }
    
    func showLoading(){
        //add the spinner view controller
        DispatchQueue.main.async {
            self.addChild(self.child)
            self.child.view.frame = self.view.frame
            self.view.addSubview(self.child.view)
            self.child.didMove(toParent: self)
        }
    }
    
    func hideLoading(){
        DispatchQueue.main.async {
            self.child.willMove(toParent: nil)
            self.child.view.removeFromSuperview()
            self.child.removeFromParent()
        }
    }

}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell") as! HomeCell
        cell.title.text = posts[indexPath.row].title
        cell.subtitle.text = posts[indexPath.row].body
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.coordinateToDetail(post: posts[indexPath.row])
    }
    
}
