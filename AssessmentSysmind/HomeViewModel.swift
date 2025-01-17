//
//  HomeViewModel.swift
//  AssessmentSysmind
//
//  Created by Ganpat Jangir on 16/01/25.
//

import Foundation

//MARK: - HomeViewModelProtocol.
protocol HomeViewModelProtocol: NSObject{
    func manageUI()
    func showError()
}


//MARK: - HomeViewModel.
class HomeViewModel {
    
    //MARK: - Variables.
    var tableData: [UserModel] = []
    var filteredData: [UserModel] = []
    private var networkManager = NetworkManager()
    private var searchTimer : Timer?
    private var retryCount: Int = 3
    weak var delegate: HomeViewModelProtocol?

    
    //MARK: - Initialization.
    init() {
        self.getDataFromAPI()
    }
    
    //MARK: - Other Methods.
    
    func getDataFromAPI() {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.retryCount -= 1
            self.networkManager.fetchData { [weak self] result in
                guard let self = self else { return }
                switch result {
                case.success(let userData):
                    self.tableData = userData
                    self.filteredData = userData
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        self.delegate?.manageUI()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    if self.retryCount > 0 {
                        self.getDataFromAPI()
                    } else {
                        DispatchQueue.main.async { [weak self] in
                            guard let self = self else { return }
                            self.delegate?.showError()
                        }
                    }
                }
            }
        }
    }
    
    func searchRelatedUser(searchText: String) {
        self.searchTimer?.invalidate()
        searchTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] _ in
            DispatchQueue.global(qos: .userInteractive).async { [weak self] in
                guard let self = self else { return }
                if searchText == "" {
                    self.filteredData = self.tableData
                } else {
                    self.filteredData = self.tableData.filter({$0.company?.name?.lowercased().contains(searchText.lowercased()) == true})
                }
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.delegate?.manageUI()
                }
            }
        }
    }
    
}
