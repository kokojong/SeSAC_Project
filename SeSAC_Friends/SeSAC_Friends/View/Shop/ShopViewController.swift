//
//  ShopViewController.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/01/24.
//

import UIKit
import SnapKit
import Tabman
import Pageboy
import Toast


class ShopViewController: TabmanViewController {
    
    var profileView = ProfileBackgroundView().then {
        $0.matchButton.setTitle("저장하기", for: .normal)
    }
    
    let tapView = UIView()
    
    private var viewControllers: [UIViewController] = []
    
    var style = ToastStyle()
    
    private let titleList = ["새싹", "배경"]
    
    let faceTitles = ["기본 새싹", "튼튼 새싹", "민트 새싹", "퍼플 새싹", "골드 새싹"]
    let faceSubtitles = [
        "새싹을 대표하는 기본 식물입니다. 다른 새싹들과 함께 하는 것을 좋아합니다.", "잎이 하나 더 자라나고 튼튼해진 새나라의 새싹으로 같이 있으면 즐거워집니다.", "호불호의 대명사! 상쾌한 향이 나서 허브가 대중화된 지역에서 많이 자랍니다.",
        "감정을 편안하게 쉬도록 하며 슬프고 우울한 감정을 진정시켜주는 멋진 새싹입니다.", "화려하고 멋있는 삶을 살며 돈과 인생을 플렉스 하는 자유분방한 새싹입니다."
    ]
    
    let backgroundTitles = ["하늘공원", "씨티 뷰", "밤의 산책로", "낮의 산책로", "연극 무대", "라틴 거실", "홈트방", "뮤지션 작업실"]
    let backgroundSubtitles = [
        "새싹들을 많이 마주치는 매력적인 하늘 공원입니다", "창밖으로 보이는 도시 야경이 아름다운 공간입니다", "어둡지만 무섭지 않은 조용한 산책로입니다", "즐겁고 가볍게 걸을 수 있는 산책로입니다",
        "연극의 주인공이 되어 연기를 펼칠 수 있는 무대입니다", "모노톤의 따스한 감성의 거실로 편하게 쉴 수 있는 공간입니다", "집에서 운동을 할 수 있도록 기구를 갖춘 방입니다", "여러가지 음악 작업을 할 수 있는 작업실입니다"
    ]
    
    let faceVC = ShopFaceViewController()
    let backgroundVC = ShopBackgroundViewController()
    
    let flowLayout = UICollectionViewFlowLayout().then {
        let spacing: CGFloat
        = 8
        let totalWidth = UIScreen.main.bounds.width - spacing*3
        let totalHeight: CGFloat = 285
        
        $0.itemSize = CGSize(width: totalWidth/2, height: totalHeight)
        $0.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        $0.minimumInteritemSpacing = spacing
        $0.minimumLineSpacing = spacing
        $0.scrollDirection = .vertical
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
        
        title = "새싹샵"
        
        viewControllers.append(faceVC)
        viewControllers.append(backgroundVC)
        
        self.dataSource = self
        
        print(viewControllers)
        
        setBar()
        
        faceVC.mainCollectionView.delegate = self
        faceVC.mainCollectionView.dataSource = self
        faceVC.mainCollectionView.register(FaceCollectionViewCell.self, forCellWithReuseIdentifier: FaceCollectionViewCell.reuseIdentifier)
        faceVC.mainCollectionView.collectionViewLayout = flowLayout
        
        backgroundVC.mainTableView.delegate = self
        backgroundVC.mainTableView.dataSource = self
        backgroundVC.mainTableView.register(BackgroundTableViewCell.self, forCellReuseIdentifier: BackgroundTableViewCell.reuseIdentifier)
        backgroundVC.mainTableView.rowHeight = UITableView.automaticDimension
        
        addViews()
        addConstraints()
        
        tapView.backgroundColor = .yellow
        
        
    }
    
    func addViews() {
        view.addSubview(profileView)
        view.addSubview(tapView)
        
    }
    
    func addConstraints() {
        profileView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(175)
        }
        
        tapView.snp.makeConstraints { make in
            make.top.equalTo(profileView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
            
        }
        
        
        
    }
    
    func setBar() {
        
        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap // Customize
        bar.layout.contentMode = .fit
        
        // Add to view
        addBar(bar, dataSource: self, at: .custom(view: tapView, layout: nil))
        
        // ToastStyle
        style.titleColor = UIColor.white!
        
    }

}

extension ShopViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return faceTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FaceCollectionViewCell.reuseIdentifier, for: indexPath) as? FaceCollectionViewCell else { return UICollectionViewCell() }
        
        cell.faceImageView.image = UIImage(named: "sesac_face_\(indexPath.row + 1)")
        cell.titleLabel.text = faceTitles[indexPath.row]
        cell.subtitleLabel.text = faceSubtitles[indexPath.row]
        
        return cell
    }
    
    
}

extension ShopViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return backgroundTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BackgroundTableViewCell.reuseIdentifier, for: indexPath) as? BackgroundTableViewCell else {
            return UITableViewCell()
        }
        
        cell.backgroundImageView.image = UIImage(named: "sesac_background_\(indexPath.row + 1)")
        
        cell.titleLabel.text = backgroundTitles[indexPath.row]
        cell.subtitleLabel.text = backgroundSubtitles[indexPath.row]
        
        
        return cell
        
    }
    
    
    
}

extension ShopViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        let title = titleList[index]
        return TMBarItem(title: title)
    }
    
}
