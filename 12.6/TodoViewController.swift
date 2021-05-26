//
//  TodoViewController.swift
//  12.6
//
//  Created by user on 21.05.21.
//

import UIKit

class TodoViewController: UIViewController {

    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var editNoteTextView: UITextView!
    var index = 0
    var curretNote: Note?
    override func viewDidLoad() {
        super.viewDidLoad()
        curretNote = Todo.shared.read().last
        noteTextView.text = curretNote?.note
        index = Todo.shared.read().count - 1
        nextButton.isEnabled = false
    }
    @IBAction func save(_ sender: Any) {
        if editNoteTextView.text != ""{
        Todo.shared.write(text: editNoteTextView.text)
        index = Todo.shared.read().count - 1
        curretNote = Todo.shared.read().last
        noteTextView.text = curretNote?.note
        nextButton.isEnabled = false
            if index > 0{
                prevButton.isEnabled = true
            }
        }
    }
    
    @IBAction func prev(_ sender: Any) {
        
        let arr:[Note] = Todo.shared.read()
        
        if index > 0 {
            index -= 1
            curretNote = arr[index]
            noteTextView.text = curretNote?.note
            nextButton.isEnabled = true
        }
        if index == 0{
            prevButton.isEnabled = false
            
        }
    }
    @IBAction func next(_ sender: Any) {
        
        let arr:[Note] = Todo.shared.read()
        
        if index < arr.count - 1  {
            index += 1
            curretNote = arr[index]
            noteTextView.text = curretNote?.note
            prevButton.isEnabled = true

        }
        if index == Todo.shared.read().count - 1{ nextButton.isEnabled = false
            
        }
    }
    
    @IBAction func remove(_ sender: Any) {
        if let curret = curretNote{
            Todo.shared.remove(note: curret)
            if index > 0 {
                index -= 1
                let arr:[Note] = Todo.shared.read()
                curretNote = arr[index]
                noteTextView.text = curretNote?.note
            }
            else if index == 0 && Todo.shared.read().count > 0 {
                let arr:[Note] = Todo.shared.read()
                curretNote = arr[index]
                noteTextView.text = curretNote?.note
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
