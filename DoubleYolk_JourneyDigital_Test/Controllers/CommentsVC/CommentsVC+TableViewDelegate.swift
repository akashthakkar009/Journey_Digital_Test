//
//  CommentsVC+TableViewDelegate.swift
//  DoubleYolk_JourneyDigital_Test
//
//  Created by DoubleYolk on 03/12/21.




import Foundation
import UIKit

// MARK: - TableView Delegate,Datasource
extension CommentsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(isSearching ?? false){
            return commentsViewModel?.searchComments?.count ?? 0
        }
        return commentsViewModel?.comments?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: CommentsTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.selectionStyle = .none
        
        if(isSearching ?? false){
            cell.configureCell(aCommentModel: commentsViewModel?.searchComments?[indexPath.row])
        }else {
            cell.configureCell(aCommentModel: commentsViewModel?.comments?[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
