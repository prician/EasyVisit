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
    let lab = ["病例", "就医记录","设置"]
    let pic = ["pic-2", "pic-3", "pic-4"]
    
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
    

}

extension  MineViewController:  UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
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
                let vc = AddDiaryViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            cell.OtnercellCallBack = { date in
                let vc = OtherDiaryViewController()
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
//        let vc = CityViewController()
//        vc.updateUI(with: IntroduceData[indexPath.section])
//        navigationController?.pushViewController(vc, animated: true)
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
