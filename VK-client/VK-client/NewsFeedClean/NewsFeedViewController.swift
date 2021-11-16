//
//  NewsFeedViewController.swift
//  VK-client
//
//  Created by Artem Firsov on 10/28/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol NewsFeedDisplayLogic: class
{
    func displaySomething(viewModel: NewsFeed.Something.ViewModel.ViewModelData)
}

class NewsFeedViewController: UITableViewController, NewsFeedDisplayLogic
{
    
 
    var interactor: NewsFeedBusinessLogic?
  var router: (NSObjectProtocol & NewsFeedRoutingLogic & NewsFeedDataPassing)?
  
    private var feedViewModel = FeedViewModel.init(cells: [])
  // MARK: Setup
  
  private func setup()
  {
    let viewController = self
    let interactor = NewsFeedInteractor()
    let presenter = NewsFeedPresenter()
    let router = NewsFeedRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
    
//    presenter.cellSizeCalculator = SizeCalculator(screenWidth: <#T##CGFloat#>)
  }
  
  // MARK: Routing
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    tableView.separatorStyle = .none
    tableView.contentInset.bottom = 5
    setup()
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "celllsd")
    tableView.register(CodedTopCell.self, forCellReuseIdentifier: CodedTopCell.reuseIden)
    tableView.register(UINib(nibName: "NewsFeedTableViewCell", bundle: nil), forCellReuseIdentifier: NewsFeedTableViewCell.reuseIden)
    
    interactor?.doSomething(request: .getNewsFeed)
    
    
  }
  
  // MARK: Do something
  
    //@IBOutlet weak var nameTextField: UITextField!
  
  func doSomething()
  {
//    let request = NewsFeed.Something.Request.RequestType()
//    interactor?.doSomething(request: request)
  }
  
    func displaySomething(viewModel: NewsFeed.Something.ViewModel.ViewModelData)
  {
        switch viewModel {
        case .some:
            print("some printing")
        case .displayNewsFeed(feedViewModel: let feedViewModel):
            self.feedViewModel = feedViewModel
            tableView.reloadData()
//                .map { (cellInfo) in
//                print(cellInfo.postText)
//            }
        }
  }
}

extension NewsFeedViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedViewModel.cells.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

//        guard let cell = tableView.dequeueReusableCell(withIdentifier: CodedTopCell.reuseIden, for: indexPath) as? CodedTopCell else { return UITableViewCell() }
//        cell.textLabel?.text = "index: \(indexPath.row)"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedTableViewCell.reuseIden, for: indexPath) as? NewsFeedTableViewCell else { return UITableViewCell() }
        let cellViewModel = feedViewModel.cells[indexPath.row]
        cell.configure(viewModel: cellViewModel)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        
        interactor?.doSomething(request: .getFeed)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellViewModel = feedViewModel.cells[indexPath.row]
        return cellViewModel.sizes.totalHeight
    }
}