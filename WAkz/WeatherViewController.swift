//
//  ViewController.swift
//  WAkz
//
//  Created by Almagul Musabekova on 19.12.2020.
//

import UIKit

class WeatherViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchResults = [SearchResponse]()
    var hasSearch = false
    
    
    struct IdentifierString {
        struct CellIdentifiers {
            static let searchResponseCell = "SearchResponse"
            static let nothingFoundCell = "NothingFound"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        let nibCell = UINib(nibName: IdentifierString.CellIdentifiers.searchResponseCell, bundle: nil)
        tableView.register(nibCell, forCellReuseIdentifier: IdentifierString.CellIdentifiers.searchResponseCell)
        let cellNF = UINib(nibName: IdentifierString.CellIdentifiers.nothingFoundCell, bundle: nil)
        tableView.register(cellNF, forCellReuseIdentifier: IdentifierString.CellIdentifiers.nothingFoundCell)
       
        
        searchBar.becomeFirstResponder()
    }
//Thread 1: "cell reuse indentifier in nib (ResponseCell) does not match the identifier used to register the nib (SearchResponse)"

}
//MARK: - SearchBarViewController Delegate
extension WeatherViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchResults = []
        
        if searchBar.text != "Atai" {
            searchResults.append(SearchResponse(response: "Fake1", cityName: searchBar.text!))
            searchResults.append(SearchResponse(response: "Fake2", cityName: searchBar.text!))
            searchResults.append(SearchResponse(response: "Fake3", cityName: searchBar.text!))
            
        }
      
        hasSearch = true
        tableView.reloadData()
        searchBar.resignFirstResponder()
    }
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        .topAttached
    }
}

//MARK: -TableView Data Source & Delegate

extension WeatherViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if hasSearch == false {
            return 0
        } else if  hasSearch == true && searchResults.count == 0 {
          return 1
        } else {
            return searchResults.count
            
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if searchResults.count == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: IdentifierString.CellIdentifiers.nothingFoundCell, for: indexPath)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: IdentifierString.CellIdentifiers.searchResponseCell, for: indexPath) as! SearchResponseCell
            cell.cityNameLabel.text = searchResults[indexPath.row].cityName
            cell.tempLabel.text = searchResults[indexPath.row].responce
            
            return cell
        }
}
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
       tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if searchResults.count == 0 {
            return nil
        } else {
            return indexPath
        }
    }
}

