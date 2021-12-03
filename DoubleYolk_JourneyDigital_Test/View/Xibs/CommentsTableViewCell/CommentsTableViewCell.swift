//
//  CommentsTableViewCell.swift
//  DoubleYolk_Test
//
//  Created by Journey Digital on 03/12/21.
//

import UIKit

class CommentsTableViewCell: UITableViewCell, NibReusable  {
    
    @IBOutlet weak var lblCommentName: UILabel!
    @IBOutlet weak var txtCommentEmail: UITextView!
    @IBOutlet weak var lblCommentBody: UILabel!
    
    /// <#Description#>
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    /// <#Description#>
    /// - Parameters:
    ///   - selected: <#selected description#>
    ///   - animated: <#animated description#>
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    
    /// <#Description#>
    /// - Parameter aCommentModel: <#aCommentModel description#>
    public func configureCell(aCommentModel: Comments?) {
        lblCommentName.text = aCommentModel?.name ?? ""
        txtCommentEmail.text = aCommentModel?.email ?? ""
        lblCommentBody.text = aCommentModel?.body ?? ""
        
        txtCommentEmail.textContainer.lineFragmentPadding = 0
        txtCommentEmail.textContainerInset = .zero
    }
}
