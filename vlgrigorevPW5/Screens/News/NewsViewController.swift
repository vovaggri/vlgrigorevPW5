//
//  ViewController.swift
//  vlgrigorevPW5
//
//  Created by Vladimir Grigoryev on 26.02.2025.
//

import UIKit

final class NewsViewController: UIViewController {
    
    private let tableView: UITableView = UITableView(frame: .zero)
    private var interactor: (NewsInteractor & NewsDataStore)?
    
    init(interactor: (NewsInteractor & NewsDataStore)? = nil) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        configureTable()
    }

    private func configureTable() {
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        tableView.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor)
        tableView.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor)
        tableView.pinRight(to: view.safeAreaLayoutGuide.trailingAnchor)
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Cell number \(indexPath.row)"
        cell.selectionStyle = .none
        return cell
    }
}

