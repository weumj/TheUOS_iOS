//
//  ViewController.swift
//  TheUOS
//
//  Created by MJ on 2017. 3. 26..
//  Copyright © 2017년 uoscs09. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var announces = [Announce]()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
        
        announces.removeAll()
        
        AnnounceParser.test()
            .subscribe(onNext: {
                self.announces.append($0)
            }, onError: { error in
                print(error)
            }, onCompleted: {
                self.tableView.reloadData()
            })
            .addDisposableTo(self.disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return announces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "AnnounceTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! AnnounceTableViewCell
        
        let announce = announces[indexPath.row]
        
        cell.label.text = announce.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let announce = announces[indexPath.row]
        
        UIApplication.shared.openURL(URL(string: announce.pageURL)!)
    }
}
