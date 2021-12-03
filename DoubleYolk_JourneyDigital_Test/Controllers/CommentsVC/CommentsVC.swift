//
//  CommentsVC.swift
//  DoubleYolk_JourneyDigital_Test
//
//  Created by DoubleYolk on 03/12/21.



import UIKit

class CommentsVC: BaseVC {

    // MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tblComments: UITableView!
    
    // MARK: - Properties
    private(set) var commentsViewModel: CommentsViewModel?
    var postModle: Post?
    var isSearching:Bool?
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConfigOnViewDidload()
    }
    
    
    /// This method will - register the CommentsTableViewCell - tableview cell
    ///  And make the callGetComments - API call metho
    private func setupConfigOnViewDidload() {
        
        tblComments.register(cellType: CommentsTableViewCell.self)
        commentsViewModel = CommentsViewModel()
        commentsViewModel?.callGetComments(aPostID: postModle?.id ?? 0, callBack: { comments in
            guard let aComments = comments , aComments.count > 0 else { return }
            DispatchQueue.main.async {
                self.tblComments.reloadData()
            }
        })
    }

}

// MARK: - UISearchBarDelegate
extension CommentsVC: UISearchBarDelegate {
    ///UISearchBarDelegate - method for invoking the search and show cancel button to remove.
    /// - Parameter searchBar: object delegate method to invoke when start beggining of editing for search bar & show cancel button to remove search text.
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    /// UISearchBarDelegate - method when user start searching and on text change will make filter the API Modle response
    /// - Parameters:
    ///   - searchBar: search bar object
    ///   - searchText: searched text on text change to make searching
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if(!searchText.isEmpty){
            commentsViewModel?.filterContentForSearchText(searchText)
            isSearching = true
        }else{
            isSearching = false
        }
        
        tblComments.reloadData()
    }
    
    /// method will  handle the clear options and making clear for search bar text to get original recoards & hide keybaord
    /// - Parameter searchBar: searchBar with clear options and hide / show
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        isSearching = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}
