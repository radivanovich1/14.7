//
//  Todo.swift
//  12.6
//
//  Created by user on 21.05.21.
//

import Foundation
import RealmSwift
import CoreData

class Note: Object{
    @objc dynamic var note = ""
    
}

class Todo{
    
    static var shared = Todo()
    private let realm = try! Realm()
    
    func write(text: String)  {
        let note = Note()
        note.note = text
        try! realm.write{
            realm.add(note)
        }
    }
    
    func read() -> [Note] {
        var noteArr: [Note] = []
        let allNotes = realm.objects(Note.self)
        for data in allNotes{
            noteArr.append(data)
        }
        return noteArr
    }
    
    func remove(note: Note){
        try! realm.write{
        realm.delete(note)
        }
    }
    
    func writeCore(text: String, context: NSManagedObjectContext )  {
        let entity = NSEntityDescription.entity(forEntityName: "NoteCore", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        newUser.setValue(text, forKey: "noteCore")
        try! context.save()
         
    }
    
    func readCore(context: NSManagedObjectContext) -> [NoteCore] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "NoteCore")
               
        request.returnsObjectsAsFaults = false
        let result = try! context.fetch(request)
        var arrNoteCore: [NoteCore] = []
                for data in result as! [NSManagedObject] {
                    arrNoteCore.append(data as! NoteCore)
                }
                    
               return arrNoteCore
    }
    
    func removeCore(note: NoteCore, context: NSManagedObjectContext ){
        context.delete(note)
    }
    
}
