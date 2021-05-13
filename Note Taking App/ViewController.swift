//
//  ViewController.swift
//  Note Taking App
//
//  Created by matrix on 13/05/2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var notesTable: UITableView!
    var data: [String] = ["Item 1", "Item 2", "Item 3", "Item 4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notesTable.dataSource = self
        self.title = "Notes"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNote))
        self.navigationItem.rightBarButtonItem = addButton
        self.navigationItem.leftBarButtonItem = editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func addNote() {
        if notesTable.isEditing {
            return
        }
           let name: String = "Item \(data.count + 1)"
           data.insert(name, at: 0)
           let indexPath: IndexPath = IndexPath(row: 0, section: 0)
           notesTable.insertRows(at: [indexPath], with: .automatic)
       }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        notesTable.setEditing(editing, animated: animated)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        data.remove(at: indexPath.row)
        notesTable.deleteRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier:"cell")!
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }

}

