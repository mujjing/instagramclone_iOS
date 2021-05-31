//
//  SearchViewController.swift
//  instagramclone_iOS
//
//  Created by 전지훈 on 2021/05/31.
//

import UIKit

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let searchBar = UISearchBar()
        searchBar.placeholder = "Search..."
        self.navigationItem.titleView = searchBar
    }

}
