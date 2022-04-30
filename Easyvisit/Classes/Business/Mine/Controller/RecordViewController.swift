//
//  OtherDiaryViewController.swift
//  Easyvisit
//
//  Created by WSH on 2022/4/23.
//

import UIKit
import SwiftyJSON

class RecordViewController: UIViewController {
    
    var departData = [Department]()
    
    var recordCellID = "recordCellID"
    let screenRect = UIScreen.main.bounds
    let titles:[String] = ["一周内","一个月内","一年内"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handyJSON()
        setNav()
        configUI()
        self.view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = false
        tabBarController?.tabBar.isHidden = true
        // Do any additional setup after loading the view.

    }

   
    lazy var searchView: SearchView = {
        let sv = SearchView()
        sv.backgroundColor = .white
        sv.layer.cornerRadius = CGFloat(20.fw)
        sv.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        sv.layer.borderWidth = CGFloat(1.fw)
        sv.searchTextField.delegate = self
        return sv
    }()
    
    
    lazy var tableView:UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = UIColor(red: 0.953, green: 0.953, blue: 0.953, alpha: 1)
        tableView.isScrollEnabled = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(RecordTableViewCell.self,forCellReuseIdentifier: recordCellID)
        return tableView
    }()
    
    
    func handyJSON() {
        do{
            let data = try Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "department", ofType: "json")!))
            if let jsonData = String(data: data, encoding: .utf8) {
                let json = JSON(parseJSON: jsonData)
                guard let jsonarray = json.array else {return}
                self.departData = jsonarray.map{ json -> Department in
                    return Department(
                        name: json["name"].stringValue,
                        depar: json["depar"].stringValue
                    )
                }
                
            }
            else {print("false")}
        }
        catch{
            print("false")
            
        }
    }
    
    func setNav() {
        self.title = "就医记录"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), style: .done, target: self, action: #selector(back))
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "添加", style: .done, target: self, action: #selector(submit))
        navigationItem.rightBarButtonItem?.tintColor = themeColor
    }
    
    @objc func back() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func submit() {
        let vc = EditRecordViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func configUI(){
        self.view.addSubview(tableView)
        self.view.addSubview(searchView)
        
        searchView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(40)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchView.snp.bottom).offset(20)
            make.bottom.equalToSuperview().offset(-60)
            make.left.right.equalToSuperview().offset(0)
        }
        
    }
}


extension RecordViewController: UITableViewDataSource,UITableViewDelegate {
    
     func numberOfSections(in tableView: UITableView) -> Int {
         return 3
     }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         switch section{
         case 0:
             return 1
         case 1:
             return 2
         default:
             return 4
         }
     }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: recordCellID, for: indexPath) as! RecordTableViewCell
         cell.backgroundColor = UIColor.white
         cell.clipsToBounds = true
         switch indexPath.section{
         case 0:
             cell.Hospilabel.text = self.departData[indexPath.row].name
             cell.Departlabel.text = self.departData[indexPath.row].depar
         case 1:
             cell.Hospilabel.text = self.departData[indexPath.row].name
             cell.Departlabel.text = self.departData[indexPath.row].depar
         default:
             cell.Hospilabel.text = self.departData[indexPath.row].name
             cell.Departlabel.text = self.departData[indexPath.row].depar
         }
         
         return cell
     }
    
    
    func tableView(_ tableView:UITableView,titleForHeaderInSection section: Int) -> String?{
        return titles[section]
    }
   
   func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       return 20
   }
   
    func tableView(_ tableView:UITableView,heightForRowAt indexPath:IndexPath) -> CGFloat {
        
        return 50
    }
 }


extension RecordViewController:  UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
