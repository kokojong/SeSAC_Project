//
//  CastViewController.swift
//  TrendMedia_assignment
//
//  Created by kokojong on 2021/10/16.
//

import UIKit

class CastViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = castTableView.dequeueReusableCell(withIdentifier: "CastTableViewCell") as? CastTableViewCell else {
            return UITableViewCell()
        }
        
        cell.castImageView.image = UIImage(systemName: "person")
        cell.nameLabel.text = "kokojong"
        cell.roleLabel.text = "iOS - dev"
        
        
        
        return cell
        
    }
    

    @IBOutlet weak var castTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        castTableView.delegate = self
        castTableView.dataSource = self
        
        castTableView.estimatedRowHeight = 100
        castTableView.rowHeight = UITableView.automaticDimension
        
//        navigationController?.popViewController(animated: true)
        
//        navigationItem.backButtonTitle = "뒤로가기"
        navigationItem.title = "출연/제작"
        self.navigationController?.navigationBar.topItem?.title = "뒤로가기"
        
        
        // Do any additional setup after loading the view.
    }
    
    
    

    

}
