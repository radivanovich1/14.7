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
    var index = 0
    var curretNote: Note?
    let todo = Todo()
    override func viewDidLoad() {
        super.viewDidLoad()
        curretNote = todo.read().last
        noteTextView.text = curretNote?.note
        index = todo.read().count - 1
        nextButton.isEnabled = false
            
    }
    @IBAction func save(_ sender: Any) {
        todo.write(text:noteTextView.text)
        index = todo.read().count - 1
        prevButton.isEnabled = true
    }
    
    @IBAction func prev(_ sender: Any) {
        
        let arr:[Note] = todo.read()
        
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
        
        let arr:[Note] = todo.read()
        
        if index < arr.count - 1  {
            index += 1
            curretNote = arr[index]
            noteTextView.text = curretNote?.note
            prevButton.isEnabled = true

        }
        if index == todo.read().count - 1{ nextButton.isEnabled = false
            
        }
    }
    
    @IBAction func remove(_ sender: Any) {
        if let curret = curretNote{
            todo.remove(note: curret)
            if index > 0 {
                index -= 1
                let arr:[Note] = todo.read()
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
