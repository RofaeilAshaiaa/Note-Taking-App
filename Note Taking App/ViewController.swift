//
//  ViewController.swift
//  Note Taking App
//
//  Created by matrix on 13/05/2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let NOTES_KEY = "notes_list"
    @IBOutlet weak var notesTable: UITableView!
    var notesList: [String] = []
    var selectedRow: Int = -1
    var newNoteText: String = ""	
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.largeTitleDisplayMode = .always
        
        //sets the table data source and the table delegate
        notesTable.dataSource = self
        notesTable.delegate = self
        self.title = "Notes"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNote))
        self.navigationItem.rightBarButtonItem = addButton
        self.navigationItem.leftBarButtonItem = editButtonItem
        loadNotes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if selectedRow != -1 {
            notesList[selectedRow] = newNoteText
            if newNoteText == "" {
                notesList.remove(at: selectedRow)
            }
            notesTable.reloadData()
            saveNotes()
        }
    }
    
    @objc func addNote() {
        if notesTable.isEditing {
            return
        }
        let name: String = ""
        notesList.insert(name, at: 0)
        let indexPath: IndexPath = IndexPath(row: 0, section: 0)
        notesTable.insertRows(at: [indexPath], with: .automatic)
        notesTable.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        self.performSegue(withIdentifier: "noteDetail", sender: nil)
    }
    
    func saveNotes() {
        UserDefaults.standard.set(notesList, forKey: NOTES_KEY)
    }
    
    func loadNotes() {
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
        saveNotes()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier:"cell")!
        cell.textLabel?.text = notesList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "noteDetail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailView: NoteDetailsViewController = segue.destination as! NoteDetailsViewController
        selectedRow = notesTable.indexPathForSelectedRow!.row
        detailView.setText(data: notesList[selectedRow])
        detailView.masterView = self
    }
    
}

