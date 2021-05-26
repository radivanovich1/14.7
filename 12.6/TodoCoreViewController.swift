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
    var index = 0
    var curretNote: NoteCore?
    var context: NSManagedObjectContext? = nil
    let todo = Todo()
//
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        curretNote = todo.readCore(context: context!).last
        noteTextView.text = curretNote?.noteCore
        index = todo.readCore(context: context!).count - 1
        nextButton.isEnabled = false

    }
    @IBAction func save(_ sender: Any) {
        todo.writeCore(text: noteTextView.text , context: context!)
        index = todo.readCore(context: context!).count - 1
        prevButton.isEnabled = true
    }
    
    @IBAction func prev(_ sender: Any) {
        let arr:[NoteCore] = todo.readCore(context: context!)
        
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
        let arr:[NoteCore] = todo.readCore(context: context!)
        
        if index < arr.count - 1  {
            index += 1
            curretNote = arr[index]
            noteTextView.text = curretNote?.noteCore
            prevButton.isEnabled = true

        }
        if index == todo.readCore(context: context!).count - 1{ nextButton.isEnabled = false
            
        }
    }
    
    @IBAction func remove(_ sender: Any) {
        if let curret = curretNote{
            todo.removeCore(note: curret, context: context!)
            if index > 0 {
                index -= 1
                let arr:[NoteCore] = todo.readCore(context: context!)
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
