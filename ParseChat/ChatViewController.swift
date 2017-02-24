//
//  ChatViewController.swift
//  ParseChat
//
//  Created by Abhijeet Chakrabarti on 2/23/17.
//  Copyright © 2017 Abhijeet Chakrabarti. All rights reserved.
//

import UIKit
import Parse

class MessageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    var messages: [PFObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
        //refresh every one second
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(MessageViewController.refresh), userInfo: nil, repeats: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let messages = messages {
            return messages.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageTableViewCell
        
        let message = messages[indexPath.row]
        cell.messageLabel.text = message["text"] as! String?
        
        return cell
    }
    
    @IBAction func onTapSend(_ sender: Any) {
        let message = PFObject(className:"Message")
        message["text"] = messageTextField.text
        message["user"] = PFUser.current()
        
        message.saveInBackground { (success: Bool, error: Error?) in
            if(success) {
                //message has been saved
                print("Message: \(self.messageTextField.text!) has been saved")
            } else {
                //error occured
                print(error!.localizedDescription)
            }
        }
    }
    
    func refresh() {
        let query = PFQuery(className: "Message")
        query.whereKey("user", equalTo: PFUser.current()!)
        query.order(byDescending: "createdAt")
        query.includeKey("user")
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if error == nil {
                //the find is successful
                print("successfully retrieved message")
                self.messages = objects!
                self.tableView.reloadData()
            } else {
                print("There is an error: \(error!.localizedDescription)")
            }
        }
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
