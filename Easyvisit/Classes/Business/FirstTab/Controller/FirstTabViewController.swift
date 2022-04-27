//
//  FirstTabViewController.swift
//  Easyvisit
//
//  Created by WSH on 2022/4/21.
//

import UIKit
import FSPagerView

class FirstTabViewController: UIViewController {

    let firstCellID = "firstCellID"
    let CellImage = ["commite", "medicine", "curve", "more"]
    let CellLabel = ["用户社区", "用药指南", "指标记录", "更多"]
    let pager = ["lunbo", "lunbo2", "lunbo3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = false
        self.view.backgroundColor = .white
        configUI()
    }

    lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "lunbo"))
        return imageView
    }()
    
    lazy var searchView: SearchView = {
        let sv = SearchView()
        sv.backgroundColor = .white
        sv.layer.cornerRadius = CGFloat(20.fw)
        sv.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        sv.layer.borderWidth = CGFloat(1.fw)
        sv.searchTextField.delegate = self
        return sv
    }()
    
    lazy var pagerView: FSPagerView = {
        let pageView = FSPagerView()
        pageView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        pageView.dataSource = self
        pageView.delegate = self
        pageView.automaticSlidingInterval = 3.0
        pageView.isInfinite = true
        //pagerView.itemSize = CGSize(width: 200, height: 180)
        //pagerView.interitemSpacing = 10
        pageView.layer.cornerRadius = 20
        pageView.layer.masksToBounds = true
        let pageControl = FSPageControl()
        return pageView
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false // 隐藏滑动条
        collectionView.alwaysBounceVertical = false
        
        collectionView.register(FirstCollectionViewCell.self, forCellWithReuseIdentifier: firstCellID)
        return collectionView
    }()
        
    lazy var dateView: DateView = {
        let view = DateView()
        return view
    }()
    
    lazy var noticeView: NoticeView = {
        let view = NoticeView()
        return view
    }()
    
    func configUI(){
        //self.view.addSubview(imageView)
        self.view.addSubview(searchView)
        self.view.addSubview(collectionView)
        self.view.addSubview(dateView)
        self.view.addSubview(noticeView)
        self.view.addSubview(pagerView)
        
    
        searchView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(65)
            make.left.equalToSuperview().offset(20.fw)
            make.right.equalToSuperview().offset(-20.fw)
            make.height.equalTo(40)
        }
        
        pagerView.snp.makeConstraints { make in
            make.top.equalTo(searchView.snp.bottom).offset(25)
            make.left.equalToSuperview().offset(30.fw)
            make.right.equalToSuperview().offset(-30.fw)
            make.height.equalTo(170)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(pagerView.snp.bottom).offset(25)
            make.height.equalTo(90)
            make.left.equalToSuperview().offset(38)
            make.right.equalToSuperview().offset(-30)
        }
        
        dateView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(30)
            make.height.equalTo(80)
            make.left.equalToSuperview().offset(45)
            make.right.equalToSuperview().offset(-20)
        }
        
        noticeView.snp.makeConstraints { make in
            make.top.equalTo(dateView.snp.bottom).offset(20)
            make.bottom.equalToSuperview().offset(-70)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
    }
}

extension  FirstTabViewController:  UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: firstCellID, for: indexPath) as! FirstCollectionViewCell
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 20
        cell.BackView.image = UIImage(named: CellImage[indexPath.section])
        cell.IntroduceLabel.text = CellLabel[indexPath.section]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section{
        case 0:
            //用户社区
            let vc = CommiteViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 1:
            //用药指南
            let vc = MedicineViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 2:
            //指标记录
            let vc = CurveViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            break
        default: break
        }
    }
}
    


extension FirstTabViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 75.fw, height: 75.fh)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: CGFloat(0.fh), left: CGFloat(0.fw), bottom: CGFloat(0.fh), right: CGFloat(15.fw))
    }
}

extension FirstTabViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //blackView.isHidden = false
    }
}

extension FirstTabViewController: FSPagerViewDataSource, FSPagerViewDelegate {
 
    
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return 3
    }
        
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = UIImage(named: pager[index])
//        cell.textLabel?.text = ...
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        let vc = NewsViewController()
        vc.cnt = index
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
