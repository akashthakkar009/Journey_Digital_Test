//
//  PostViewModel.swift
//  DoubleYolk_Test
//
//  Created by Journey Digital on 03/12/21.
//


import Foundation

class CommentsViewModel: NSObject {
    
    // MARK: - Properties
    private var apiService: APIService?
    var postID : Int = 0
    
    private(set) var searchComments: Array<Comments>?
    
    private(set) var comments: Array<Comments>? {
        didSet {
        }
    }
    
    override init() {
        super.init()
        self.apiService = APIService()
    }
    
    
    /// This method will make the API calling and fetch the list of comments by using Post ID
    /// - Parameters:
    ///   - aPostID: aPostID ID by help of that it will get the list of all the comments
    ///   - callBack: reply with array list of Comment model
    func callGetComments(aPostID : Int , callBack : @escaping (_ comments : Array<Comments>?) -> Void) {
        
        apiService?.apiToGetComments(aPostID, completion: { result in
            
            switch (result) {
                
            case .failure(let error):
                print("error = \(error.errorMessage)")
                
            case .success(let arrCommentsList):
                if let arrCommentsList  = arrCommentsList as? Array<Comments>? {
                    self.comments = arrCommentsList
                    callBack(arrCommentsList)
                }
            }
        })
    }
    
    /// This method will retrun the list of all the searched matching Comments array with Title & Body text on Main API model list.
    /// - Parameter searchText: searching keyworld to apply searching on the list of Comments List model & get the matching objects with title & body
    func filterContentForSearchText(_ searchText: String) {
        
        searchComments = comments?.filter({(aComments: Comments) -> Bool in
            let titleMatch = aComments.name.range(of: searchText, options: .caseInsensitive)
            let emailMatch = aComments.email.range(of: searchText, options: .caseInsensitive)
            let bodyMatch = aComments.body.range(of: searchText, options: .caseInsensitive)
            return titleMatch != nil || emailMatch != nil || bodyMatch != nil
        })
    }
}
