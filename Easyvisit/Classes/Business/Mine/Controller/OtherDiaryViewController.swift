//
//  OtherDiaryViewController.swift
//  Easyvisit
//
//  Created by WSH on 2022/4/23.
//

import UIKit

class RecordViewController: UIViewController {
    
    var recordCellID = "recordCellID"
    let screenRect = UIScreen.main.bounds
    let numbers:[Int] = [1,2,5,10]
    let titles:[String] = ["当日","一周内","一个月内","一年内"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.

    }
    lazy var searchView: UITextField! = {
        let sv = UITextField(frame: CGRect(x: 10, y: 100, width: screenRect.width-20, height: 40))
        sv.backgroundColor = .white
        sv.borderStyle = UITextField.BorderStyle.roundedRect
        sv.layer.cornerRadius = CGFloat(20)
        sv.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        sv.layer.borderWidth = CGFloat(1)
        sv.placeholder = "请输入相关信息"
        sv.autocorrectionType = UITextAutocorrectionType.no
        sv.returnKeyType = UIReturnKeyType.done
        sv.clearButtonMode = UITextField.ViewMode.whileEditing
        sv.keyboardAppearance = UIKeyboardAppearance.dark
        
        let pic = UIImage(named:"search")
        let picView = UIImageView(image:pic)
        picView.frame = CGRect(x: 40, y: 130, width: 10, height: 10)
        sv.leftView = picView
        sv.leftViewMode = .always
        
        sv.delegate = self
        return sv
    }()
    
    
    lazy var tableView:UITableView = {
        let tableRect = CGRect(x: 10, y: 150, width: screenRect.size.width-20, height: screenRect.size.height - 170)
        let tableView = UITableView(frame: tableRect)
        tableView.backgroundColor = #colorLiteral(red: 0.3434987664, green: 0.7703599334, blue: 0.9376719594, alpha: 1)
        tableView.isScrollEnabled = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(RecordTableViewCell.self,forCellReuseIdentifier: recordCellID)
        return tableView
    }()
    
    lazy var label:UILabel = {
        let label = UILabel(frame: CGRect(x: screenRect.width/2 - 50, y: 50, width: 100, height: 30))
        label.text = "就医记录"
        label.font = UIFont(name: "Arial", size: 18)
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor.black
        return label
    }()
    
    func configUI(){
        self.view.addSubview(label)
        self.view.addSubview(tableView)
        self.view.addSubview(searchView)
        
    }
}


extension RecordViewController: UITableViewDataSource,UITableViewDelegate {
    
     func numberOfSections(in tableView: UITableView) -> Int {
         return 4
     }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return numbers[section]
     }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: recordCellID, for: indexPath) as! RecordTableViewCell
         cell.backgroundColor = UIColor.white
         cell.clipsToBounds = true
         return cell
     }
    
    
    func tableView(_ tableView:UITableView,titleForHeaderInSection section: Int) -> String?{
        return titles[section]
    }
   
   func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       return 15
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
