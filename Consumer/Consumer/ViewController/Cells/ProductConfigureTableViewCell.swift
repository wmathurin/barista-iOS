//
//  ProductConfigureTableViewCell.swift
//  Consumer
//
//  Created by Nicholas McDonald on 2/13/18.
//  Copyright © 2018 Salesforce. All rights reserved.
//

import UIKit

enum ProductConfigureCellControlType {
    case unknown
    case slider
    case increment
    case expand
}

class ProductConfigureTableViewCell: UITableViewCell {
    
    var imageURL: String? {
        didSet {
            self.cellImageView.loadImageUsingCache(withUrl: imageURL)
        }
    }
    var name: String? {
        didSet {
            self.cellTitleLabel.text = name
        }
    }
    
    var controlStyle:(ProductConfigureCellControlType, Int) = (.unknown, 0) {
        didSet {
            switch controlStyle.0 {
            case .slider:
                let control = SliderControl()
                control.minTrackColor = Theme.appMainControlColor
                control.maxTrackColor = Theme.productConfigSliderMaxTrackColor
                control.thumbColor = Theme.appMainControlColor
                control.textColor = Theme.appMainControlTextColor
                control.maxValue = 3 // TODO - from data
                control.thumbLabels = ["S", "M", "L"] // TODO - from data
                control.addTarget(self, action: #selector(handleControlEventChange), for: .valueChanged)
                self.configureControl = control
            case .increment:
                let control = IncrementControl()
                control.controlColor = Theme.appMainControlColor
                control.plusImage = UIImage(named: "plus01")
                control.minusImage = UIImage(named: "minus01")
                control.textColor = Theme.appMainControlTextColor
                control.maxValue = 3
                self.configureControl = control
            case .expand:
                self.rightImageView.image = UIImage(named: "expand")
                return
            case .unknown:
                return
            }
        }
    }
    
    fileprivate var cellImageView = UIImageView()
    fileprivate var cellTitleLabel = UILabel()
    fileprivate var configureControl:UIControl? {
        didSet {
            guard let control = configureControl else {return}
            self.contentView.addSubview(control)
            control.translatesAutoresizingMaskIntoConstraints = false
            control.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant:-10).isActive = true
            control.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        }
    }
    fileprivate var rightImageView = UIImageView()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clear
        self.selectionStyle = .none
        
        self.cellImageView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.cellImageView)
        
        self.cellTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.cellTitleLabel)
        
        self.rightImageView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.rightImageView)
        
        self.cellTitleLabel.textColor = Theme.productConfigTextColor
        self.cellTitleLabel.font = Theme.productConfigItemCellFont
        
        self.cellImageView.centerXAnchor.constraint(equalTo: self.contentView.leftAnchor, constant:30.0).isActive = true
        self.cellImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        
        self.cellTitleLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant:60.0).isActive = true
        self.cellTitleLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        
        self.rightImageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant:-16.0).isActive = true
        self.rightImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        guard let control = self.configureControl else {return}
        control.removeFromSuperview()
        self.configureControl = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @objc func handleControlEventChange() {
        
    }
}
