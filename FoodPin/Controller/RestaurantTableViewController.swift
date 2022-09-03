//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Khayal Yediyarov on 23.08.22.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
    
    var restaurants:[Restaurant] = [
        Restaurant(name: "Cafe Deadend", type: "Coffee & Tea Shop", location:"Hong Kong", image: "cafedeadend", isFavorite: false),
        Restaurant(name: "Homei", type: "Cafe", location: "Hong Kong", image:"homei", isFavorite: false),
        Restaurant(name: "Teakha", type: "Tea House", location: "Hong Kong", image: "teakha", isFavorite: false),
        Restaurant(name: "Cafe loisl", type: "Austrian / Causual Drink", location: "Hong Kong", image: "cafeloisl", isFavorite: false),
        Restaurant(name: "Petite Oyster", type: "French", location: "Hong Kong", image: "petiteoyster", isFavorite: false),
        Restaurant(name: "For Kee Restaurant", type: "Bakery", location: "HongKong", image: "forkee", isFavorite: false),
        Restaurant(name: "Po's Atelier", type: "Bakery", location: "Hong Kong", image: "posatelier", isFavorite: false),
        Restaurant(name: "Bourke Street Backery", type: "Chocolate", location:"Sydney", image: "bourkestreetbakery", isFavorite: false),
        Restaurant(name: "Haigh's Chocolate", type: "Cafe", location: "Sydney", image: "haigh", isFavorite: false),
        Restaurant(name: "Palomino Espresso", type: "American / Seafood", location: "Sydney", image: "palomino", isFavorite: false),
        Restaurant(name: "Upstate", type: "American", location: "New York", image: "upstate", isFavorite: false),
        Restaurant(name: "Traif", type: "American", location: "New York", image: "traif", isFavorite: false),
        Restaurant(name: "Graham Avenue Meats", type: "Breakfast & Brunch", location: "New York", image: "graham", isFavorite: false),
        Restaurant(name: "Waffle & Wolf", type: "Coffee & Tea", location: "NewYork", image: "waffleandwolf", isFavorite: false),
        Restaurant(name: "Five Leaves", type: "Coffee & Tea", location: "New York", image: "fiveleaves", isFavorite: false),
        Restaurant(name: "Cafe Lore", type: "Latin American", location: "New York", image: "cafelore", isFavorite: false),
        Restaurant(name: "Confessional", type: "Spanish", location: "New York", image: "confessional", isFavorite: false),
        Restaurant(name: "Barrafina", type: "Spanish", location: "London", image: "barrafina", isFavorite: false),
        Restaurant(name: "Donostia", type: "Spanish", location: "London", image: "donostia", isFavorite: false),
        Restaurant(name: "Royal Oak", type: "British", location: "London", image: "royaloak", isFavorite: false),
        Restaurant(name: "CASK Pub and Kitchen", type: "Thai", location: "London", image: "cask", isFavorite: false)
    ]
    
    
    
    
    
    enum Section {
        case all
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.cellLayoutMarginsFollowReadableWidth = true
        
        tableView.dataSource = dataSource
        
        tableView.separatorStyle = .none
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Restaurant>()
        snapshot.appendSections([.all])
        snapshot.appendItems(restaurants, toSection: .all)
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    
    
    func configureDataSource() -> UITableViewDiffableDataSource<Section, Restaurant >{
        let cellIdentifier = "datacell"
        
        let dataSource = UITableViewDiffableDataSource<Section, Restaurant>(
            tableView: tableView,
            cellProvider: {  tableView, indexPath, restaurant in
                
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
                //                downcasting
                cell.nameLabel?.text = restaurant.name
                cell.thumbnailImageView?.image = UIImage(named: restaurant.image)
                cell.locationLabel?.text = restaurant.location
                cell.typeLabel?.text = restaurant.type
                cell.heartIconImageView.isHidden = restaurant.isFavorite ? false : true
                
                return cell
                
            }
        )
        
        return dataSource
    }
    
    lazy var dataSource = configureDataSource()
    
    
    
    
    //    Managing Row Selections by Implementing the Protocol
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Create an option menu as an action sheet
        let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .actionSheet)
        
        
        if let popoverController = optionMenu.popoverPresentationController {
            if let cell = tableView.cellForRow(at: indexPath) {
                popoverController.sourceView = cell
                popoverController.sourceRect = cell.bounds
            }
        }
        
        
        // Add actions to the menu
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        
        // Add "Reserve a table" action
        let reserveActionHandler = { (action:UIAlertAction!) -> Void in
            let alertMessage = UIAlertController(
                title: "Not available yet",
                message: "Sorry, this feature is not available yet. Please retry later.",
                preferredStyle: .alert
            )
            alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertMessage, animated: true, completion: nil)
        }
        let reserveAction = UIAlertAction(
            title: "Reserve a table",
            style: .default,
            handler: reserveActionHandler
        )
        
        
        // Mark as favorite action
        
        let favoriteAction = UIAlertAction(
            title: self.restaurants[indexPath.row].isFavorite ? "Remove from favorites" : "Mark as favorite",
            style: .default,
            handler: {
                (action:UIAlertAction!) -> Void in
                
                let cell = tableView.cellForRow(at: indexPath) as! RestaurantTableViewCell
                
                cell.heartIconImageView.isHidden = self.restaurants[indexPath.row].isFavorite
                self.restaurants[indexPath.row].isFavorite = self.restaurants[indexPath.row].isFavorite ? false : true
                
                
            })
        
        
        optionMenu.addAction(favoriteAction)
        optionMenu.addAction(reserveAction)
        optionMenu.addAction(cancelAction)
        
        // Display the menu
        present(optionMenu, animated: true, completion: nil)
        
        // Deselect the row
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
