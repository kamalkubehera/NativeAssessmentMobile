//
//  TableViewController.swift
//  NativeAssessmentMobile
//
//  Created by KAMAL KUMAR BEHERA on 22/11/18.
//  Copyright © 2018 KAMAL KUMAR BEHERA. All rights reserved.
//

import UIKit

class TableViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{

    static var cityName : String!
    var tableViewTitle = ""
    var refreshCtrl: UIRefreshControl!
    var cache: NSCache<AnyObject, AnyObject>!
    var contacts: [DataModel] = [DataModel]()
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshCtrl = UIRefreshControl()
        self.refreshCtrl.addTarget(self, action: #selector(TableViewController.refreshTabeview), for: .valueChanged)
        self.tableView.refreshControl = self.refreshCtrl
        self.cache = NSCache()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 100
        self.tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "customCell") //register the cell to the table view
        self.view.addSubview(self.tableView)
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        self.getAllJsonData()
        self.setUpNavigation()
        
    }
    
    //Get all json data...
    func getAllJsonData(){
        
        NetworkServices.loadNetworkData { (arrayObjectes) in
            weak var weakSelf = self
            weakSelf?.contacts = arrayObjectes
            //weakSelf?.tableViewTitle = title
            DispatchQueue.main.async {
                
                weakSelf?.tableView.reloadData()
            }
        }
    }
    
    //Pull-to-refresh to a tableview..
    @objc func refreshTabeview(){
        weak var weakSelf = self
        self.getAllJsonData()
        DispatchQueue.main.async(execute: { () -> Void in
            
            weakSelf?.tableView.refreshControl?.endRefreshing()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Set the Navigation..
    func setUpNavigation() {
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.2431372549, green: 0.7647058824, blue: 0.8392156863, alpha: 1)
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor(red: 1, green: 1, blue: 1, alpha: 1)]
    }
    
    //MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        navigationItem.title = self.tableViewTitle
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
        let dictionary = contacts[indexPath.row]
        cell.contact = contacts[indexPath.row]
        let imageNamedesc = contacts[indexPath.row].description
        
        let imageName = "clear sky.png"
        let image = UIImage(named: imageName)
        cell.imageView?.image = UIImage(named:contacts[indexPath.row].description ?? imageName)
        return cell
}
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
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
