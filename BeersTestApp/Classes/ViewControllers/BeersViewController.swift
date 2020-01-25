//
//  BeersViewController.swift
//  BeersTestApp
//
//  Created by Roman Rybachenko on 24.01.2020.
//  Copyright © 2020 Roman Rybachenko. All rights reserved.
//

import UIKit
import SDWebImage


class BeersViewController: UIViewController, Storyboardable {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    static var storyboardName: Storyboard {
        return .beers
    }
    
    private let viewModel = BeersVM()
    
    
    // MARK: - Overriden funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        getBeers()
    }
    
    
    // MARK: - Private funcs
    
    private func setupView() {
        self.title = viewModel.title
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.registerCell(BeerCell.self)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = BeerCell.height
        
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: 0.1, height: 0.1))
        footer.backgroundColor = .clear
        tableView.tableFooterView = footer
    }
    
    private func getBeers() {
        viewModel.getBeers(completion: { [weak self] in
            self?.tableView.reloadData()
        }, failure: { [weak self] error in
            AlertsManager.showServerErrorAlert(with: error, to: self)
        })
    }
    
    private func configureCell(_ cell: BeerCell, with beerItem: Beer) {
        cell.nameLabel.text = beerItem.name
        cell.tagilneLabel.text = beerItem.tagline
        cell.descriptionLabel.text = beerItem.description
        cell.logoImageView.sd_setImage(with: beerItem.imageUrl, placeholderImage: UIImage(named: "imagePlaceholder"))
    }
    
}


// MARK: - UITableViewDataSource
extension BeersViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let beerItem = viewModel.item(at: indexPath.row) else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: BeerCell.self)
        configureCell(cell, with: beerItem)
        
        return cell
    }
    
}


// MARK: - UITableViewDelegate
extension BeersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
