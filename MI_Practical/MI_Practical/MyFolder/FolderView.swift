//
//  FolderView.swift
//  MI_Practical
//
//  Created by SLS M2 on 20/12/23.
//

import Foundation
import UIKit

class CreateFolderViewController: UIViewController {

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private let folderViewModel = FolderViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = folderViewModel.currentFolder

        view.addSubview(tableView)
        setupTableViewConstraints()
        setupTableView()
        addBackButton()
        generateFolders()
        folderViewModel.navigateBackClosure = { [weak self] in
                  self?.navigationController?.popToRootViewController(animated: true)
              }
    }

    func setupTableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    func addBackButton() {
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
    }

    @objc func backButtonTapped() {
        // Handle back button action using the view model
        folderViewModel.handleBackButton()
        updateUI()
    }

    func generateFolders() {
        // Generate folders using the view model
        folderViewModel.generateFolders()
        updateUI()
    }

    func updateUI() {
        // Update UI elements using data from the view model
        title = folderViewModel.currentFolder
        tableView.reloadData()
    }
}

extension CreateFolderViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return folderViewModel.folders.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = folderViewModel.folders[indexPath.row].name
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Toggle selection state
        tableView.cellForRow(at: indexPath)?.isSelected.toggle()
        
        folderViewModel.currentFolder = folderViewModel.folders[indexPath.row].name
        folderViewModel.folderCount = 0
            generateFolders()
            tableView.reloadData()
        title = folderViewModel.currentFolder
        
      
    }
}


