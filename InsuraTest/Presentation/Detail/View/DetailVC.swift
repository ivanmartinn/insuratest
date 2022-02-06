//
//  DetailVC.swift
//  InsuraTest
//
//  Created by Ivan Martin on 06/02/2022.
//

import UIKit

class DetailVC: UIViewController {
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var coordinator: DetailFlow?
    var viewModel: DetailVM?
    
    lazy var child = LoadingView()
    
    var post: Post!
    
    var comments: [Comment] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupTableView()
        self.request()
    }
    
    private func setupUI(){
        self.title = "Detail Post"
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.titleLabel.text = post.title
        self.bodyLabel.text = post.body
        
        container.layer.borderWidth = 1
        container.layer.borderColor = UIColor.lightGray.cgColor
        container.layer.cornerRadius = 10
    }
    
    private func setupTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableView.automaticDimension
        
        let nibname = UINib(nibName: "DetailCell", bundle: nil)
        self.tableView.register(nibname, forCellReuseIdentifier: "DetailCell")
        self.tableView.reloadData()
    }
    
    private func request(){
        self.showLoading()
        self.viewModel?.getComment(completionHandler: { result in
            self.hideLoading()
            switch result{
            case .success(let model):
                DispatchQueue.main.async {
                    self.comments = model
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


extension DetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell") as! DetailCell
        cell.nameLabel.text = self.comments[indexPath.row].name
        cell.commentLabel.text = self.comments[indexPath.row].body
        return cell
    }
    
    
}
