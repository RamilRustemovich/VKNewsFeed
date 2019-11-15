//
//  NewsfeedViewController.swift
//  VKNewsFeed
//
//  Created by Ramil on 02/11/2019.
//  Copyright (c) 2019 Ramil. All rights reserved.
//

import UIKit

protocol NewsfeedDisplayLogic: class {
    func displayData(viewModel: Newsfeed.Model.ViewModel.ViewModelData)
}

class NewsfeedViewController: UIViewController, NewsfeedDisplayLogic {
    
    var interactor: NewsfeedBusinessLogic?
    var router: (NSObjectProtocol & NewsfeedRoutingLogic)?
    private var feedViewModel = FeedViewModel.init(cells: [], footerTitle: nil)
    
    @IBOutlet weak var table: UITableView!
    private var titleView = TitleView()
    private lazy var footerView = FooterView()
    private let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()
    
  
    // MARK: Setup
    private func setup() {
        let viewController        = self
        let interactor            = NewsfeedInteractor()
        let presenter             = NewsfeedPresenter()
        let router                = NewsfeedRouter()
        viewController.interactor = interactor
        viewController.router     = router
        interactor.presenter      = presenter
        presenter.viewController  = viewController
        router.viewController     = viewController
    }
    
    // MARK: Routing
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.setupTable()
        self.setupTopBars()
        
        //self.view.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        self.interactor?.makeRequest(request: Newsfeed.Model.Request.RequestType.getNewsfeed)
        self.interactor?.makeRequest(request: .getUser)
    }
    
    func displayData(viewModel: Newsfeed.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .displayNewsfeed(let feedViewModel):
            self.feedViewModel = feedViewModel
            self.table.reloadData()
            self.refreshControl.endRefreshing()
            self.footerView.setTitle(feedViewModel.footerTitle)
        case .displayUser(let userViewModel):
            self.titleView.set(userViewModel: userViewModel)
        case .displayFooterLoader:
            self.footerView.showLoader()
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y > scrollView.contentSize.height / 1.1 {
            self.interactor?.makeRequest(request: .getNextBatch)
        }
    }
    
    
    private func setupTable() {
        self.table.contentInset.top = 8
        // выбор создания ячейки через Xib или код:
        //self.table.register(UINib(nibName: "NewsfeedCell", bundle: nil), forCellReuseIdentifier: NewsfeedCell.reuseId)
        self.table.register(NewsfeedCodeCell.self, forCellReuseIdentifier: NewsfeedCodeCell.reuseId)
        
        self.table.separatorStyle = .none
        self.table.backgroundColor = .clear
        self.table.addSubview(self.refreshControl)
        self.table.tableFooterView = footerView
    }
    
    private func setupTopBars() {
        let topBar = UIView(frame: UIApplication.shared.statusBarFrame)
        topBar.backgroundColor = .white
        topBar.layer.shadowColor = UIColor.black.cgColor
        topBar.layer.shadowOpacity = 0.3
        topBar.layer.shadowOffset = .zero
        topBar.layer.shadowRadius = 8
        self.view.addSubview(topBar)
        
        self.navigationController?.hidesBarsOnSwipe = true
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.titleView = self.titleView
    }
    
    @objc private func refresh() {
        self.interactor?.makeRequest(request: Newsfeed.Model.Request.RequestType.getNewsfeed)
    }
    
}



// MARK: NewsfeedCodeCellDelegate
extension NewsfeedViewController: NewsfeedCodeCellDelegate {
    func revealPost(for cell: NewsfeedCodeCell) {
        guard let indexPath = table.indexPath(for: cell) else { return }
        let cellViewModel = self.feedViewModel.cells[indexPath.row]
        self.interactor?.makeRequest(request: .revealPostIds(postId: cellViewModel.postId))
    }
    
    
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension NewsfeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.feedViewModel.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // выбор создания ячейки через Xib или код:
        // let cell = tableView.dequeueReusableCell(withIdentifier: NewsfeedCell.reuseId, for: indexPath) as! NewsfeedCell
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsfeedCodeCell.reuseId, for: indexPath) as? NewsfeedCodeCell
        let cellViewModel = self.feedViewModel.cells[indexPath.row]
        cell?.set(viewModel: cellViewModel)
        cell?.delegate = self
        return cell ?? NewsfeedCodeCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellViewModel = self.feedViewModel.cells[indexPath.row]
        return cellViewModel.sizes.totalHeight
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellViewModel = self.feedViewModel.cells[indexPath.row]
        return cellViewModel.sizes.totalHeight
    }
    
}
