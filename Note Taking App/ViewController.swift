//
//  ViewController.swift
//  Note Taking App
//
//  Created by matrix on 13/05/2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    let NOTES_KEY = "notes_list"
    @IBOutlet weak var notesTable: UITableView!
    var notesList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notesTable.dataSource = self
        self.title = "Notes"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNote))
        self.navigationItem.rightBarButtonItem = addButton
        self.navigationItem.leftBarButtonItem = editButtonItem
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func addNote() {
        if notesTable.isEditing {
            return
        }
           let name: String = "Item \(notesList.count + 1)"
           notesList.insert(name, at: 0)
           let indexPath: IndexPath = IndexPath(row: 0, section: 0)
           notesTable.insertRows(at: [indexPath], with: .automatic)
        saveData()
       }
    
    func saveData() {
        UserDefaults.standard.set(notesList, forKey: NOTES_KEY)
    }
    
    func loadData() {
        if let loadedData = UserDefaults.standard.array(forKey: NOTES_KEY) as? [String] {
            notesList = loadedData
            notesTable.reloadData()
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        notesTable.setEditing(editing, animated: animated)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        notesList.remove(at: indexPath.row)
        notesTable.deleteRows(at: [indexPath], with: .automatic)
        saveData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier:"cell")!
        cell.textLabel?.text = notesList[indexPath.row]
        return cell
    }

}

