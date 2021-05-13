//
//  NoteDetailsViewController.swift
//  Note Taking App
//
//  Created by matrix on 13/05/2021.
//

import UIKit

class NoteDetailsViewController: UIViewController {
    
    @IBOutlet weak var noteBody: UITextView!
    var text: String = ""
    var masterView:ViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noteBody.text = text
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    func setText(data:String) {
        text = data
        if isViewLoaded {
            noteBody.text = text
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        masterView.newNoteText = noteBody.text
        noteBody.resignFirstResponder()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        noteBody.becomeFirstResponder()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
