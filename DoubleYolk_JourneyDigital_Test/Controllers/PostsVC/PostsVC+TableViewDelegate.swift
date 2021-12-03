//
//  PostsVC+TableViewDelegate.swift
//  DoubleYolk_JourneyDigital_Test
//
//  Created by DoubleYolk on 03/12/21.
//

import Foundation
import UIKit

// MARK: - TableView Delegate,Datasource
extension PostsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(isSearching ?? false){
            return postViewModel.searchPosts?.count ?? 0
        }
        return postViewModel.posts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: PostsTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.selectionStyle = .none
        
        if(isSearching ?? false){
            cell.configureCell(aPostModel: postViewModel.searchPosts?[indexPath.row])
        }else {
            cell.configureCell(aPostModel: postViewModel.posts?[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var selectedPost : Post?
        if(isSearching ?? false){
            selectedPost = postViewModel.searchPosts?[indexPath.row]
        }else {
            selectedPost = postViewModel.posts?[indexPath.row]
        }
        self.performSegue(withIdentifier: Segues.kShowPostDetail, sender: selectedPost)
    }
}
