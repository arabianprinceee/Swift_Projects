//
//  Main_TableVC.swift
//  FavoritePlacesApp_SwiftBook
//
//  Created by Анас Бен Мустафа on 10/22/20.
//

import UIKit
import RealmSwift

class Main_TableVC: UITableViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    var filteredPlaces: Results<Place>!
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    var places: Results<Place>! // из realm'a
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        places = realm.objects(Place.self) // для отображения данных на экране при запуске приложения
        
        // Настройка SearchController'a
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (isFiltering) {
            return filteredPlaces.count
        }
        return places.isEmpty ? 0 : places.count
    }
    
    /*
    // Метод, через который можно настроить размер изображения
    func image( _ image:UIImage, withSize newSize:CGSize) -> UIImage {
        UIGraphicsBeginImageContext(newSize)
        image.draw(in: CGRect(x: 0,y: 0,width: newSize.width,height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!.withRenderingMode(.automatic)
    }
 */

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        
        var place = Place()
        
        if isFiltering {
            place = filteredPlaces[indexPath.row]
        } else {
            place = places[indexPath.row]
        }
        
        cell.NameLabel?.text = place.nameOfPlace
        cell.LocationLabel?.text = place.location
        cell.TypeLabel?.text = place.typeOfPlace
        cell.ImageOfPlace.image = UIImage(data: place.imageData!)
        cell.ImageOfPlace?.layer.cornerRadius = 40
        cell.ImageOfPlace?.clipsToBounds = true
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            
            let place: Place
            
            if isFiltering {
                place = filteredPlaces[indexPath.row]
            } else {
                place = places[indexPath.row]
            }
            
            let NewPlaceVC = segue.destination as! NewPlace_TableViewController
            NewPlaceVC.currentPlace = place
        }
    }

    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) { // Метод для возврата на главный экран
        
        // Создаём объект типа NewPlaceViewController. Так как данные мы будем полчать ИЗ него, используем segue.source
        guard let newPlaceVC = segue.source as? NewPlace_TableViewController else { return }
        
        newPlaceVC.savePlace()
        tableView.reloadData()
    }
    
    
    // MARK: TableViewDelegate
    // Добавление свайпа справа для ячеек
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let placeToDelete = places[indexPath.row]
            StorageManager.deleteObject(placeToDelete)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    /*
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let placeToDelete = places[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, _) in
            StorageManager.deleteObject(placeToDelete)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    */
     
}

extension Main_TableVC: UISearchResultsUpdating {
    
    private func filterContentForSearchedText(_ searchedText: String) {
        filteredPlaces = places.filter("nameOfPlace CONTAINS[c] %@ OR location CONTAINS[c] %@", searchedText, searchedText)
        
        tableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchedText(searchController.searchBar.text!)
    }
    
}
