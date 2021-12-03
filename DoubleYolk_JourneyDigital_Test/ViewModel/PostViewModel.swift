//
//  PostViewModel.swift
//
//  DoubleYolk_JourneyDigital_Test
//
//  Created by DoubleYolk on 03/12/21.


import UIKit

import Foundation

class PostViewModel: NSObject {
    
    // MARK: - Properties
    private var postService: APIService?
    private(set) var searchPosts: Array<Post>?
    private(set) var posts: Array<Post>? {
        didSet {
            self.bindPostViewModelToController()
        }
    }
    
    public var bindPostViewModelToController: (() -> ()) = {}
    
    /// Init method with API Service class init & fetch the list of Post from server..
    override init() {
        super.init()
        self.postService = APIService()
        self.fetchGetPostList()
    }
    
    
    /// fetch the list of post by calling Get api & genrate the Post model data setup..
    private func fetchGetPostList() {
        postService?.apiToGetPosts(completion: { result in
            
            switch (result) {
                
            case .failure(let error):
                print("error = \(error.errorMessage)")
                
            case .success(let arrPostList):
                if let arrPostList  = arrPostList as? Array<Post>? {
                    self.posts = arrPostList
                }
            }
        })
    }
    
    /// This method will return the list of all the Post model.
    /// - Returns: retun the Post array list.
    public func getPosts() -> Array<Post>? {
        return posts
    }
    
    
    /// This method will retrun the list of all the searched matching Post array with Title & Body text on Main API model list.
    /// - Parameter searchText: searching keyworld to apply searching on the list of Post List model & get the matching objects with title & body
    func filterContentForSearchText(_ searchText: String) {
        
        searchPosts = posts?.filter({(aPost: Post) -> Bool in
            let titleMatch = aPost.title.range(of: searchText, options: .caseInsensitive)
            let bodyMatch = aPost.body.range(of: searchText, options: .caseInsensitive)
            return titleMatch != nil || bodyMatch != nil
        })
    }
}

