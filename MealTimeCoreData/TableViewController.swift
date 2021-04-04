//
//  TableViewController.swift
//  MealTimeCoreData
//
//  Created by Андрей Моисеев on 04.04.2021.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {

    var context: NSManagedObjectContext!
    var user: User!
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
    @IBAction func addButtonPressed(_ sender: Any) {
        
        let meal = Meal(context: context)
        meal.date = Date()
        
        let meals = user.meals?.mutableCopy() as? NSMutableOrderedSet
        meals?.add(meal)
        user.meals = meals
        
        do {
            try context.save()
            tableView.reloadData()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userName = "Andrei"
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", userName)
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.isEmpty {
                user = User(context: context)
                user.name = userName
                try context.save()
            } else {
                user = results.first
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }


    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return user.meals?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        guard let meal = user.meals?[indexPath.row] as? Meal,
            let mealDate = meal.date
            else { return cell }
        
        cell.textLabel!.text = dateFormatter.string(from: mealDate)
        return cell
    }


}
