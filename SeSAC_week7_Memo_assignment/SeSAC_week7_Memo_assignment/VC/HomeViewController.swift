//
//  HomeViewController.swift
//  SeSAC_week7_Memo_assignment
//
//  Created by kokojong on 2021/11/08.
//

import UIKit
import RealmSwift

class HomeViewController: UIViewController {

    @IBOutlet weak var memoCountLabel: UILabel!
    @IBOutlet weak var memoSearchBar: UISearchBar!
    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var editToolbar: UIToolbar!
    @IBOutlet weak var editToolbarButton: UIBarButtonItem!
    
    var memoCount = 1000
    
    var tasks: Results<Memo>!
    
    let localRealm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkIsFirstLaunch()
        
        
        /* ----------- UI ----------- */
        // light 모드일때도 보이게
        view.backgroundColor = .black
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let formattedNumber = numberFormatter.string(for: memoCount)!
        
        memoCountLabel.text = "\(formattedNumber)개의 메모"
        memoCountLabel.font = .boldSystemFont(ofSize: 30)
        tableview.backgroundColor = .clear
        
        tableview.delegate = self
        tableview.dataSource = self
        let nibName = UINib(nibName: HomeTableViewCell.identifier, bundle: nil)
        tableview.register(nibName, forCellReuseIdentifier: HomeTableViewCell.identifier)
        
        tableview.estimatedRowHeight = 100
        tableview.rowHeight = UITableView.automaticDimension
        
        editToolbarButton.setBackgroundImage(UIImage(systemName: "square.and.pencil"), for: .normal, style: .plain, barMetrics: .default)
        editToolbarButton.tintColor = UIColor.systemOrange
           
        /* --------- Realm ---------- */
        
        print("Realm:",localRealm.configuration.fileURL!)
        tasks = localRealm.objects(Memo.self)
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableview.reloadData()
    }
    
    @objc func onBackBarItemClicked(){
        // 왜 안되는가..?
        // -> 기본적인 backBarItem을 쓰면 제공되기 때문에 지정할 수 없음(?)
        print("onBackBarItemClicked")
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onEditToolbarButtonClicked(_ sender: UIBarButtonItem) {
        print("onEditToolbarButtonClicked")
        
        let sb = UIStoryboard(name: "Edit", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: EditViewController.identifier)
        
       
//        let backBarItem = UIBarButtonItem(title: "뒤뒤", style: .plain , target: self, action: nil)
//
//        vc.navigationItem.backBarButtonItem = backBarItem
        
        let backBarItem = UIBarButtonItem(title: "메모", style: .plain , target: self, action: #selector(onBackBarItemClicked))

        self.navigationItem.backBarButtonItem = backBarItem
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func checkIsFirstLaunch() {
        if UserDefaults.standard.bool(forKey: "first launch") != true {
            UserDefaults.standard.set(true, forKey: "first launch")
            print("first")
            presentPopup()
        } else{ // 임시 -> 처음이 아님 -> 나중에 지워주기
            presentPopup()
        }
        
    }

    func presentPopup() {
        let sb = UIStoryboard(name: "Popup", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: PopupViewController.identifier)
        
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
    }
    
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return section == 0 ? 5 : tasks.count
//        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        
      
        
        if indexPath.section == 0 {
            cell.titleLabel.text = "제목"
            cell.contentLabel.text = "내용"
            
        }
        else if indexPath.section == 1 {
            let row = tasks[indexPath.row]
            cell.titleLabel.text = row.memoTitle
            cell.contentLabel.text = row.memoContent
        }
        
        
        return cell
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "고정된 메모" : "메모"
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView{
            headerView.textLabel?.textColor = .white
            headerView.textLabel?.font = .boldSystemFont(ofSize: 20)
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    // pin 액션
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let pinAction = UIContextualAction(style: .normal, title: "", handler: { action, view, completionHandler in
            
            completionHandler(true)
        })
        pinAction.backgroundColor = .systemOrange
        // 현재 핀상태 여부 분기처리 추가하기
        pinAction.image = UIImage(systemName: "pin.fill")
        
        return UISwipeActionsConfiguration(actions: [pinAction])
    }
    
    // delete 액션
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "", handler: { action, view, completionHandler in
            completionHandler(true)
        })
        
        deleteAction.image = UIImage(systemName: "trash.fill")
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Edit", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: EditViewController.identifier)
        
       
//        let backBarItem = UIBarButtonItem(title: "뒤뒤", style: .plain , target: self, action: nil)
//
//        vc.navigationItem.backBarButtonItem = backBarItem
        
        let backBarItem = UIBarButtonItem(title: "검색", style: .plain , target: self, action: #selector(onBackBarItemClicked))

        self.navigationItem.backBarButtonItem = backBarItem
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
 
    
    
    
    
    
    
}
