//
//  PlayerVC.swift
//  Pickup-Basketball-Queue
//
//  Created by Ben Arteaga on 6/19/20.
//  Copyright © 2020 Ben Arteaga. All rights reserved.
//

import UIKit
import Firebase

class QueueVC: UIViewController {

    @IBOutlet weak var playerQueue: UITableView!
    @IBOutlet weak var getOnQueueBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.playerQueue.delegate = self
        self.playerQueue.dataSource = self
        
        getOnQueueBtn.layer.cornerRadius = 10
        
        QueueService.instance.loadQueue() { (success) in
            if success {
                self.playerQueue.reloadData()
            }
        }
    }
    
    @IBAction func getOnQueueBtnPressed(_ sender: UIButton) {
        if getOnQueueBtn.backgroundColor == .red {
            QueueService.instance.removeCurrentUserFromQueue() { (success) in
//                if success {
//                    self.getOnQueueBtn.backgroundColor = .systemGreen
//                    self.getOnQueueBtn.setTitle("Get On Queue", for: .normal)
//                }
//                else {
//                    self.showAlert(title: "Error", message: "Something went wrong!")
//                }
            }
            self.getOnQueueBtn.backgroundColor = .systemGreen
            self.getOnQueueBtn.setTitle("Get On Queue", for: .normal)
        }
        else {
            QueueService.instance.addCurrentUserToQueue()
            getOnQueueBtn.backgroundColor = .red
            getOnQueueBtn.setTitle("Get Off Queue", for: .normal)
        }

    }
    
    //takes a title and message and uses them to create and show a custom alert
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "QueueViewtoCourtOptionsView", sender: nil)
    }
}

extension QueueVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        QueueService.instance.queue.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let player = QueueService.instance.queue[indexPath.row]
        if let cell = playerQueue.dequeueReusableCell(withIdentifier: "QueueCell") as? QueueCell {
            cell.configureCell(in_player: player)
            return cell
        }
        else {
            return QueueCell()
        }
    }
}
