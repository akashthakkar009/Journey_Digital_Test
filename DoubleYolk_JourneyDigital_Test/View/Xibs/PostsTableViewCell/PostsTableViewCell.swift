//
//  PostsTableViewCell.swift
//  DoubleYolk_JourneyDigital_Test
//
//  Created by DoubleYolk on 03/12/21.
//

import UIKit

class PostsTableViewCell: UITableViewCell, NibReusable  {

    @IBOutlet weak var lblPostDetail: UILabel!
    @IBOutlet weak var lblPostTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    public func configureCell(aPostModel: Post?) {
        lblPostTitle.text = aPostModel?.title ?? ""
        lblPostDetail.text = aPostModel?.body ?? ""
    }
}
