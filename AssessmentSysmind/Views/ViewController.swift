//
//  ViewController.swift
//  AssessmentSysmind
//
//  Created by Ganpat Jangir on 16/01/25.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - IBOutlets.
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Variables.
    private var viewModel = HomeViewModel()
    private var noItemLabel: UILabel?    
    
    //MARK: - View LifeCycle Methods.
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.viewModel.delegate = self
        self.searchBar.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.searchBar.resignFirstResponder()
    }
    
    //MARK: - Setup UI.
    private func setupUI() {
        self.searchBar.autocapitalizationType = .none
        self.tableView.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ItemTableViewCell")
        self.tableView.isHidden = true
        self.addNoItemLabel()
    }
    
    private func addNoItemLabel() {
        let lbl = UILabel()
        lbl.text = "No User Found"
        lbl.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.isHidden = true
        self.noItemLabel = lbl
        self.view.addSubview(lbl)
        NSLayoutConstraint.activate([
            lbl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            lbl.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.searchRelatedUser(searchText: searchText)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell") as? ItemTableViewCell else {
            return UITableViewCell()
        }
        let item = self.viewModel.filteredData[indexPath.row]
        cell.selectionStyle = .none
        cell.configureCell(item: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
}

extension ViewController: HomeViewModelProtocol {
    func manageUI() {
        if self.viewModel.filteredData.isEmpty {
            self.noItemLabel?.isHidden = false
            self.tableView.isHidden = true
        } else {
            self.noItemLabel?.isHidden = true
            self.tableView.isHidden = false
            self.tableView.reloadData()
        }
    }
    
    func showError() {
        let alert = UIAlertController(title: "Error", message: "Something went wrong! Please try again later.", preferredStyle: .alert)
        let okBtn = UIAlertAction(title: "OK", style: .cancel) { _ in }
        alert.addAction(okBtn)
        self.present(alert, animated: true)
    }
}
