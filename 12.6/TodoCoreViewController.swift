//
//  TodoCoreViewController.swift
//  12.6
//
//  Created by user on 26.05.21.
//

import UIKit
import CoreData

class TodoCoreViewController: UIViewController {

    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var editNoteTextView: UITextView!
    var index = 0
    var curretNote: NoteCore?
    var context: NSManagedObjectContext? = nil
//
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        curretNote = Todo.shared.readCore(context: context!).last
        noteTextView.text = curretNote?.noteCore
        index = Todo.shared.readCore(context: context!).count - 1
        nextButton.isEnabled = false
       


    }
    @IBAction func save(_ sender: Any) {
        if editNoteTextView.text != "" {
        Todo.shared.writeCore(text: editNoteTextView.text , context: context!)
        index = Todo.shared.readCore(context: context!).count - 1
        curretNote = Todo.shared.readCore(context: context!).last
        noteTextView.text = curretNote?.noteCore
        nextButton.isEnabled = false
            if index > 0{
                prevButton.isEnabled = true
            }
        }
    }
    
    @IBAction func prev(_ sender: Any) {
        let arr:[NoteCore] = Todo.shared.readCore(context: context!)
        
        if index > 0 {
            index -= 1
            curretNote = arr[index]
            noteTextView.text = curretNote?.noteCore
            nextButton.isEnabled = true
        }
        if index == 0{
            prevButton.isEnabled = false
            
        }
    }
    @IBAction func next(_ sender: Any) {
        let arr:[NoteCore] = Todo.shared.readCore(context: context!)
        
        if index < arr.count - 1  {
            index += 1
            curretNote = arr[index]
            noteTextView.text = curretNote?.noteCore
            prevButton.isEnabled = true

        }
        if index == Todo.shared.readCore(context: context!).count - 1{ nextButton.isEnabled = false
            
        }
    }
    
    @IBAction func remove(_ sender: Any) {
        if let curret = curretNote{
            Todo.shared.removeCore(note: curret, context: context!)
            if index > 0 {
                index -= 1
                let arr:[NoteCore] = Todo.shared.readCore(context: context!)
                curretNote = arr[index]
                noteTextView.text = curretNote?.noteCore
            }
            else if index == 0 && Todo.shared.readCore(context: context!).count > 0 {
                let arr:[NoteCore] = Todo.shared.readCore(context: context!)
                curretNote = arr[index]
                noteTextView.text = curretNote?.noteCore
            }
            else{
                noteTextView.text = ""
                curretNote = nil
                index = 0
                prevButton.isEnabled = false
            }
        }
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first != nil{
            view.endEditing(true)
        }
        super.touchesBegan(touches, with: event)
    }



}
