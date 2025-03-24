//
//  ViewController.swift
//  vlgrigorevPW5
//
//  Created by Vladimir Grigoryev on 26.02.2025.
//

import UIKit

final class NewsViewController: UIViewController {
    enum Constants {
        static let rowHeight: CGFloat = 200
        static let shareTitleText: String = "Share"
    }
    
    private let tableView: UITableView = UITableView(frame: .zero)
    private var interactor: (NewsInteractor & NewsDataStore)?
    private var articles: [Models.ArticleModel] = []
    
    init(interactor: (NewsInteractor & NewsDataStore)?) {
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
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = Constants.rowHeight
        
        interactor?.loadFreshNews()
    }
    
    func displayView(viewModel: Models.NewsViewModel) {
        DispatchQueue.main.async { [weak self] in
            self?.articles = viewModel.articles
            self?.tableView.reloadData()
        }
    }

    private func configureTable() {
        view.addSubview(tableView)
        tableView.register(ArticleCell.self, forCellReuseIdentifier: ArticleCell.Constants.identifier)
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
        let articleUrl = interactor?.articles[indexPath.row].articleUrl
        interactor?.routToWeb(Models.RoutToWeb(articleURL: articleUrl))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = "Cell number \(indexPath.row)"
//        cell.selectionStyle = .none
//        return cell
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleCell.Constants.identifier, for: indexPath) as? ArticleCell else {
            return UITableViewCell()
        }
        
        let article = articles[indexPath.row]
        cell.configure(with: article)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let share = UIContextualAction(style: .normal, title: Constants.shareTitleText) { (action, view, completionHandler) in
            self.interactor?.prepareNewsShare(self.interactor?.articles[indexPath.row].newsId)
            completionHandler(true)
        }
        
        let swipe = UISwipeActionsConfiguration(actions: [share])
        return swipe
    }
}

