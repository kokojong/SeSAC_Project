//
//  PersonSearchViewController.swift
//  TrendMedia_assignment
//
//  Created by kokojong on 2021/10/31.
//

import UIKit

class PersonSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var personSearchTableView: UITableView!
    
    
    var personSearchList: [PersonSearchModel] = []
    var person_id: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        personSearchTableView.delegate = self
        personSearchTableView.dataSource = self
        
        title = "출연작"
        
        loadPersonSearchData()

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if personSearchList.count > 0 {
            return personSearchList.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if personSearchList.count > 0 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonSearchTableViewCell.identifier) as? PersonSearchTableViewCell else { return UITableViewCell() }
            
            let row = personSearchList[indexPath.row]
            
            cell.titleLabel.text = row.title
            cell.rateLabel.text = "\(row.vote_average)"
            
            
            return cell
            
        } else {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonSearchTableViewCell.identifier) as? PersonSearchTableViewCell else { return UITableViewCell() }
            
            cell.titleLabel.text = "출연작이 없습니다"
            cell.rateLabel.text = ""
           
            return cell
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    

    
    func loadPersonSearchData() {
        
        TrendMediaPersonSearchAPIManager.shared.fetchTrendMediaPersonSearchData(person_id: person_id) { json in
            
            for movie in json["cast"].arrayValue {
                let title = movie["title"].stringValue
                let rate = movie["vote_average"].doubleValue
                
                let data = PersonSearchModel(title: title, vote_average: rate)
                
                self.personSearchList.append(data)
                
            }
            
            self.personSearchTableView.reloadData()
            
        }
        
        
    }
   

}
