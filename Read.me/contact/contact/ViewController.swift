//
//  ViewController.swift
//  contact
//
//  Created by David Mamou on 6/06/18.
//  Copyright © 2018 David Mamou. All rights reserved.
//

import UIKit
import Contacts

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var contactStore = CNContactStore()
    var contacts = [contactStruct]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        contactStore.requestAccess(for: .contacts) { ( success, error) in
            if (success){
                print("Autorisation")
            }
        }
        fetchContacts()
    }
    
    

    func fetchContacts(){
        let key = [CNContactGivenNameKey, CNContactFamilyNameKey,CNContactPhoneNumbersKey] as [CNKeyDescriptor]
        let request = CNContactFetchRequest(keysToFetch: key)
        try! contactStore.enumerateContacts(with: request){ (contact, stoppingPointer) in
            let name = contact.givenName
            let familyName = contact.familyName
            let number = contact.phoneNumbers.first?.value.stringValue
            
            let contactToAppend = contactStruct(name: name, familyName: familyName, number: number!)
            
            self.contacts.append(contactToAppend)
            
        }
        tableView.reloadData()
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style:  .subtitle, reuseIdentifier: nil)
        let contactToDisplay = contacts[indexPath.row]
        cell.textLabel?.text = contactToDisplay.name + " " + contactToDisplay.familyName
        cell.detailTextLabel?.text = contactToDisplay.number
        return cell
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

