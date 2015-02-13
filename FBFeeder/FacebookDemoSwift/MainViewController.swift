//
//  MainViewController.swift
//  FacebookDemoSwift
//
//  Created by Timothy Lee on 2/11/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var resultArray: NSArray!;
    var fbArray: [FBFeed]!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reload()
        
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reload() {
        FBRequestConnection.startWithGraphPath("/me/home", parameters: nil, HTTPMethod: "GET") { (connection: FBRequestConnection!, result: AnyObject!, error: NSError!) -> Void in
            self.resultArray = result["data"] as NSArray;
            //self.fbArray = FBFeed();
            self.fbArray = FBFeed().parseToModel(self.resultArray);
            self.tableView.reloadData();
            //println("\(result)")
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let array = self.fbArray{
            return array.count;
        }else{
            return 0;
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var picture = (fbArray[indexPath.row] as FBFeed).picture;
        var message  = (fbArray[indexPath.row] as FBFeed).message;
        if (picture != nil){
            let cell = tableView.dequeueReusableCellWithIdentifier("PhotoCell") as PhotoTableViewCell;
            cell.textLabel?.text = message;
            cell.imageView?.setImageWithURL(NSURL(string: picture))
            return cell;
        }
        let cell = tableView.dequeueReusableCellWithIdentifier("StatusCell") as StatusTableViewCell;
        cell.textLabel?.text = message;
        return cell;
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
