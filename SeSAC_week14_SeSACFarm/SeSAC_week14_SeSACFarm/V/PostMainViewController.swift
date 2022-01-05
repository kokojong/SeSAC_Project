//
//  PostMainViewController.swift
//  SeSAC_week14_SeSACFarm
//
//  Created by kokojong on 2022/01/03.
//

import UIKit

class PostMainViewController: UIViewController {

    let postMainView = PostMainView()
    
    var viewModel = PostMainViewModel()
    
    let writeButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 40)
        button.backgroundColor = .green
//        button.clipsToBounds = true
        button.layer.cornerRadius = 40
        button.addTarget(self, action: #selector(onWriteButtonClicked), for: .touchUpInside)
        return button
    }()
    
    override func loadView() {
        self.view = postMainView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        viewModel.getAllPosts {
            
        }
        postMainView.tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(writeButton)
        writeButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.size.equalTo(80)
        }
        
//        postMainView.tableView.backgroundColor = .lightGray
        postMainView.tableView.delegate = self
        postMainView.tableView.dataSource = self
        postMainView.tableView.register(PostMainTableViewCell.self, forCellReuseIdentifier: PostMainTableViewCell.identifier)
        postMainView.tableView.rowHeight = UITableView.automaticDimension
        viewModel.getAllPosts {
            
        }
        
        print("numberOfItemsInSection",viewModel.numberOfItemsInSection)
        viewModel.allPosts.bind { post in
            self.postMainView.tableView.reloadData()
        }
        // Do any additional setup after loading the view.
    }
    
    @objc func onWriteButtonClicked() {
        self.navigationController?.pushViewController(PostWriteViewController(), animated: true)
    }

 

}

extension PostMainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection
//        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostMainTableViewCell.identifier, for: indexPath) as? PostMainTableViewCell else { return UITableViewCell() }
        
//        cell.nickNameLabel.text = "nickname"
//        cell.contentLabel.text = "content"
//        cell.createdDateLabel.text = "1.3"
//        cell.goToCommentLabel.text = "댓글"
        let row = viewModel.cellForItemAt(indexPath: indexPath)
//        print("row: ",row)
        cell.nickNameLabel.text = row.user.username
        cell.contentLabel.text = row.text
        cell.createdDateLabel.text = row.createdAt
        if row.comments.count == 0 {
            cell.goToCommentLabel.text = "댓글 쓰기"
        } else {
            cell.goToCommentLabel.text = "댓글 \(row.comments.count)개"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let row = self.viewModel.allPosts.value[indexPath.row]
        
        let vc = PostDetailViewController()
        vc.viewModel.detailPost.value = row
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
