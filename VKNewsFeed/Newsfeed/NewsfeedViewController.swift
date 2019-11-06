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
    private var feedViewModel = FeedViewModel.init(cells: [])
    
    @IBOutlet weak var table: UITableView!
    
    
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
        
        //self.table.register(UINib(nibName: "NewsfeedCell", bundle: nil), forCellReuseIdentifier: NewsfeedCell.reuseId)
        self.table.register(NewsfeedCodeCell.self, forCellReuseIdentifier: NewsfeedCodeCell.reuseId)
        
        self.table.separatorStyle = .none
        self.table.backgroundColor = .clear
        self.view.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        self.interactor?.makeRequest(request: Newsfeed.Model.Request.RequestType.getNewsfeed)
    }
    
    func displayData(viewModel: Newsfeed.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .displayNewsfeed(let feedViewModel):
            self.feedViewModel = feedViewModel
            self.table.reloadData()
        }
    }
    
}


extension NewsfeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.feedViewModel.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: NewsfeedCell.reuseId, for: indexPath) as! NewsfeedCell
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsfeedCodeCell.reuseId, for: indexPath) as? NewsfeedCodeCell
        let cellViewModel = self.feedViewModel.cells[indexPath.row]
        cell?.set(viewModel: cellViewModel)
        return cell ?? NewsfeedCodeCell()
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.interactor?.makeRequest(request: .getFeed)
//
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellViewModel = self.feedViewModel.cells[indexPath.row]
        return cellViewModel.sizes.totalHeight
    }
    
}
