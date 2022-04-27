//
//  RecordTableViewCell.swift
//  Easyvisit
//
//  Created by WSH on 2022/4/26.
//

import UIKit

class RecordTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configUI()
    }
    
    
    lazy var Hospilabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 10, y: 15, width: 100, height: 20))
        label.text = "中山医院"
        label.font = UIFont(name: "Arial", size: 18)
        label.textAlignment = NSTextAlignment.left
        label.textColor = .black
        return label
    }()
    
    lazy var Departlabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 150, y: 15, width: 100, height: 20))
        label.text = "骨科"
        label.font = UIFont(name: "Arial", size: 18)
        label.textAlignment = NSTextAlignment.left
        label.textColor = .black
        return label
    }()
    
    lazy var DateLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 300, y: 25, width: 100, height: 20))
        label.text = "2022年4月26日"
        label.font = UIFont(name: "Arial", size: 14)
        label.textAlignment = NSTextAlignment.left
        label.textColor = .gray
        return label
    }()
    
    func configUI(){
        self.addSubview(Hospilabel)
        self.addSubview(Departlabel)
        self.addSubview(DateLabel)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
