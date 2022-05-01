//
//  MineViewController.swift
//  Easyvisit
//
//  Created by WSH on 2022/4/21.
//

import UIKit

class MineViewController: UIViewController {

    let moodCellID = "moodCellID"
    let otherCellID = "otherCellID"
    let lab = ["心情问卷","病历", "就医记录","设置"]
    let pic = ["wenjuan","pic-2", "mine_pic-3", "mine_pic-4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        configUI()
        // Do any additional setup after loading the view.
    }
    
    lazy var topView: TopView = {
        let topView = TopView()
        return topView
    }()
    
    lazy var headButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "head"), for: .normal)
        button.imageView?.layer.cornerRadius  = 35
        button.imageView?.clipsToBounds = true
        button.addTarget(self, action: #selector(headClick), for: .touchUpInside)
        return button
    }()
    
    @objc func headClick(){
        
        let vc = SelfViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false // 隐藏滑动条
        collectionView.alwaysBounceVertical = false
        
        collectionView.register(MoodCollectionViewCell.self, forCellWithReuseIdentifier: moodCellID)
        collectionView.register(OtherCollectionViewCell.self, forCellWithReuseIdentifier: otherCellID)
        return collectionView
    }()
    
    func configUI() {
        view.addSubview(topView)
        view.addSubview(collectionView)
        view.addSubview(headButton)
        
        headButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-50)
            make.width.height.equalTo(70.fw)
            make.top.equalToSuperview().offset(70.fw)
        }
        
        topView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview().offset(0)
        }
        
        collectionView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(180)
            make.height.equalTo(1000)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = false
    }
    

}

extension  MineViewController:  UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section{
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: moodCellID, for: indexPath) as! MoodCollectionViewCell
            cell.diaryView.image = UIImage(named: "pic-1")
            cell.AddcellCallBack = { date in
                let vc = EditDiaryViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            cell.allDiaryCallBack = {
                let vc = AddDiaryViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: otherCellID, for: indexPath) as! OtherCollectionViewCell
            cell.diarylabel.text = lab[indexPath.section - 1]
            cell.diaryView.image = UIImage(named: pic[indexPath.section - 1])
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        switch indexPath.section{
        case 1:
            let vc = QuestionViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = CaseViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 3:
            let vc = RecordViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 4:
            let vc = SelfViewController()
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
}
    


extension MineViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section{
        case 0:
            return CGSize(width: Int(screenWidth - 40).fw, height: 200.fh)
        default:
            return CGSize(width: Int(screenWidth - 40).fw, height: 40.fh)
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: CGFloat(0.fh), left: CGFloat(0.fw), bottom: CGFloat(25.fh), right: CGFloat(0.fw))
    }
    
    
}
