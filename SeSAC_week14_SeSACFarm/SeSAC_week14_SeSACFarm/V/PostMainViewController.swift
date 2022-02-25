//
//  PostMainViewController.swift
//  SeSAC_week14_SeSACFarm
//
//  Created by kokojong on 2022/01/03.
//

import UIKit

class PostMainViewController: UIViewController {

    let postMainView = PostMainView()
    
    var viewModel = PostMainViewModel.shared
    
    let writeButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 40)
        button.backgroundColor = .green
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
            self.postMainView.tableView.reloadData()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "새싹농장"
        view.backgroundColor = .white
        view.addSubview(writeButton)
        
        writeButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.size.equalTo(80)
        }
        
        var menuItems: [UIAction] {
            return [
                UIAction(title: "최신순 정렬", image: nil, identifier: nil, discoverabilityTitle: nil, handler: { action in
                    self.onSortDescButtonClicked()
                }),
                UIAction(title: "오래된 순 정렬", image: nil, identifier: nil, discoverabilityTitle: nil, handler: { action in
                    self.onSortAscButtonClicked()
                })
                ,
                UIAction(title: "비밀번호 변경", image: nil, identifier: nil, discoverabilityTitle: nil, handler: { action in
                    self.onChangePW()
                })
                
            ]
        }
        
        let menu = UIMenu(title: "", image: nil, identifier: nil, options: [], children: menuItems)
        let sortButton = UIBarButtonItem(title: nil, image: UIImage(named: "ellipsis.vertical") , primaryAction: nil, menu: menu)
        sortButton.tintColor = .black
        self.navigationItem.rightBarButtonItems = [sortButton]
        self.navigationItem.leftBarButtonItems = [UIBarButtonItem(image: UIImage(systemName: "power"), style: .done, target: self, action: #selector(onLogoutButtonClicked))]
        
        postMainView.tableView.delegate = self
        postMainView.tableView.dataSource = self
        postMainView.tableView.register(PostMainTableViewCell.self, forCellReuseIdentifier: PostMainTableViewCell.identifier)
        postMainView.tableView.rowHeight = UITableView.automaticDimension
        
        postMainView.tableView.refreshControl = UIRefreshControl()
        postMainView.tableView.refreshControl?.addTarget(self, action: #selector(onRefresh), for: .valueChanged)
        viewModel.getAllPosts {
            self.postMainView.tableView.reloadData()
        }
        
    }
    
    @objc func onWriteButtonClicked() {
        self.navigationController?.pushViewController(PostWriteViewController(), animated: true)
    }
    
    @objc func onSortAscButtonClicked() {
        self.viewModel.desc.value = "asc"
        viewModel.getAllPosts {
            self.postMainView.tableView.reloadData()
        }
    }
    
    @objc func onSortDescButtonClicked() {
        self.viewModel.desc.value = "desc"
        viewModel.getAllPosts {
            self.postMainView.tableView.reloadData()
        }
    }
    
    @objc func onChangePW() {
        let vc = ChangePWViewController()
//        vc.viewModel = self.viewModel
        present(vc, animated: true, completion: nil)
    }
    
    @objc func onLogoutButtonClicked() {
        
        let alert = UIAlertController(title: "로그아웃", message: "로그아웃 후 홈 화면으로 돌아갑니다", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "로그아웃", style: .destructive) { action in
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: MainViewController())
            windowScene.windows.first?.makeKeyAndVisible()
        }
        let cancel = UIAlertAction(title: "취소", style: .default)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc func onRefresh(){
        viewModel.getAllPosts {
            self.postMainView.tableView.reloadData()
            self.view.makeToast("피드 새로고침 완료")
            self.postMainView.tableView.refreshControl?.endRefreshing()
        }
    }
    

}

extension PostMainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostMainTableViewCell.identifier, for: indexPath) as? PostMainTableViewCell else { return UITableViewCell() }
        
        let row = viewModel.cellForRowAt(indexPath: indexPath)
        cell.nicknameLabel.text = row.user.username
        cell.contentLabel.text = row.text
        cell.createdDateLabel.text = row.createdAt.toDate
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
        vc.viewModel.postId.value = row.id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
