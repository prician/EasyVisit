//
//  ChatMessageCell.swift
//  Easyvisit
//
//  Created by 康思为 on 2022/4/23.
//

import UIKit
import SnapKit
import SDWebImage
import YYText

enum ChatMessageDirection {
    case FromLeftToRight
    case FromRightToLeft
}

class ChatMessageCell: UITableViewCell {
    
    lazy var avatarImageView: UIImageView = {
        let imgV = UIImageView(frame: .zero)
        imgV.backgroundColor = .white
        imgV.layer.cornerRadius = 25
        return imgV
    }()
    
    lazy var chatContentView: UIView = {
        let vi = UIView(frame: .zero)
        vi.addSubview(contentTextLabel)
//        vi.addSubview(bubbleView)
        return vi
    }()
    
    lazy var contentTextLabel: YYLabel = {
        let label = YYLabel()
        label.textColor = .black
        label.backgroundColor = .white
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.layer.cornerRadius = 5
        label.textAlignment = .left
        label.textContainerInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        return label
    }()
    
    lazy var bubbleView: BubbleView = {
        let vi = BubbleView(frame: CGRect(x: -10, y: 10, width: 20, height: 20))
        vi.backgroundColor = .clear
        return vi
    }()
    
    func setContentText(_ text: String?, foregroundColor: UIColor) {
        let style = NSMutableParagraphStyle()
        style.headIndent = 10
        let attributedString = NSAttributedString(string: text!, attributes: [.paragraphStyle: style, .font: UIFont(name: "Arial", size: 18) as Any, .foregroundColor: foregroundColor])
        let layout = YYTextLayout(containerSize: CGSize(width: screenWidth - 130, height: CGFloat.greatestFiniteMagnitude), text: attributedString)
        contentTextLabel.frame.size = CGSize(width: layout!.textBoundingSize.width + 20, height: layout!.textBoundingSize.height + 20)
        switch direction {
        case .FromLeftToRight:
            contentTextLabel.frame.origin = CGPoint(x: 0, y: 0)
        case .FromRightToLeft:
            contentTextLabel.frame.origin = CGPoint(x: screenWidth - 110 - layout!.textBoundingSize.width - 20, y: 0)
        }
        contentTextLabel.attributedText = attributedString
//        contentTextLabel.textLayout = layout
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var direction: ChatMessageDirection = .FromRightToLeft {
        didSet {
            switch direction {
            case .FromLeftToRight:
                avatarImageView.frame = CGRect(x: 20, y: 20, width: 50, height: 50)
                chatContentView.frame = CGRect(x: 90, y: 20, width: screenWidth - 110, height: self.frame.height - 40)
            case .FromRightToLeft:
                avatarImageView.frame = CGRect(x: screenWidth - 70, y: 20, width: 50, height: 50)
                chatContentView.frame = CGRect(x: 20, y: 20, width: screenWidth - 110, height: self.frame.height - 40)
            }
        }
    }
    
    func setAvatarImage(_ urlString: String?) {
        guard let urlString = urlString else { return }
        self.avatarImageView.sd_setImage(with: URL(string: urlString))
    }
    
    func setAvatarImage(_ image: UIImage?) {
        self.avatarImageView.image = image
    }
    
    func setup() {
        contentView.addSubview(avatarImageView)
        contentView.addSubview(chatContentView)
    }

}
