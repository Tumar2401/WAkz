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
//MARK: - Helper methods
    
    func weatherURL(searchText: String) -> URL{
        
        let encodingCharacter = searchText.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let urlString = String(format: "https://api.openweathermap.org/data/2.5/weather?q=%@&appid=caeec4c29187edc047e2d350e38ea653&units=metric",encodingCharacter!)
        let url = URL(string: urlString)
        return url!
    }
    func performWeatherRequest(with url: URL)-> String? {
        
        do {
          let string = try String(contentsOf: url, encoding: .utf8)
            return string
        } catch  {
            print("Error: Cannot dowload - \(error.localizedDescription)")
            return nil
        }
       
    }
}
//MARK: - SearchBarViewController Delegate
extension WeatherViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchResults = []
        searchBar.resignFirstResponder()
        hasSearch = true
        
        let url = weatherURL(searchText: searchBar.text!)
        print("====URL \(url)====")
        
        
        if let jsonString = performWeatherRequest(with: url) {
            print(jsonString)
        }
      
        tableView.reloadData()
       
    }
//        if searchBar.text != "Atai" {
//            searchResults.append(SearchResponse(response: "Fake1", cityName: searchBar.text!))
//            searchResults.append(SearchResponse(response: "Fake2", cityName: searchBar.text!))
//            searchResults.append(SearchResponse(response: "Fake3", cityName: searchBar.text!))
//            
//        }
      //https://api.openweathermap.org/data/2.5/weather?q=Karaganda&appid=caeec4c29187edc047e2d350e38ea653&units=metric"
       //https://api.openweathermap.org/data/2.5/weather?q=AslanKaraganda&appid=caeec4c29187edc047e2d350e38ea653&units=metric
       
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

/*
{
  -"coord": {
    "lon": 73.1,
    "lat": 49.8
  },
 - "weather": [
    {
      "id": 800,
      "main": "Clear",
      "description": "clear sky",
      "icon": "01n"
    }
  ],
 - "base": "stations",
  -"main": {
    "temp": 254.15,
    "feels_like": 249.8,
    "temp_min": 254.15,
    "temp_max": 254.15,
    "pressure": 1034,
    "humidity": 77
  },
  "visibility": 10000,
  -"wind": {
    "speed": 1,
    "deg": 0
  },
  "clouds": {
    "all": 0
  },
 - "dt": 1607876165,
  "sys": {
    "type": 1,
    "id": 8827,
    "country": "KZ",
    "sunrise": 1607828231,
    "sunset": 1607857603
  },
  -"timezone": 21600,
  "id": 609655,
  "name": "Karaganda",
  "cod": 200
}
 keys = caeec4c29187edc047e2d350e38ea653
 https://api.openweathermap.org/data/2.5/weather?q=Karaganda&appid=caeec4c29187edc047e2d350e38ea653&units=metric
 {"coord":{"lon":73.1,"lat":49.8},"weather":[{"id":621,"main":"Snow","description":"shower snow","icon":"13n"}],"base":"stations","main":{"temp":-7,"feels_like":-16.43,"temp_min":-7,"temp_max":-7,"pressure":1012,"humidity":73},"visibility":2800,"wind":{"speed":9,"deg":180},"snow":{"1h":0.62},"clouds":{"all":75},"dt":1608401435,"sys":{"type":1,"id":8827,"country":"KZ","sunrise":1608433332,"sunset":1608462499},"timezone":21600,"id":609655,"name":"Karaganda","cod":200}
*/
