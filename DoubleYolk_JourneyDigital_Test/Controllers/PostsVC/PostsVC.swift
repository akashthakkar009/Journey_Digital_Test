//
//  PostsVC.swift
//  DoubleYolk_JourneyDigital_Test
//
//  Created by DoubleYolk on 03/12/21.
//

import UIKit

class PostsVC: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tblPosts: UITableView!
    
    // MARK: - Properties
    private(set) var postViewModel: PostViewModel = PostViewModel()
    var isSearching:Bool?
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConfigOnViewDidload()
    }
    
    
    /// This method will - register the PostsTableViewCell - tableview cell
    ///  And make the requestGetPostAPICall - API call method
    private func setupConfigOnViewDidload() {
        tblPosts.register(cellType: PostsTableViewCell.self)
        requestGetPostAPICall()
    }
    
    
    /// requestGetPostAPICall : method will make the request on the sever and fetch the Post Model response with Json parsing & make table reloading.
    private func requestGetPostAPICall() {
        postViewModel.bindPostViewModelToController = { [weak self] in
            guard let self = self, let posts = self.postViewModel.getPosts(), posts.count > 0 else { return }
            DispatchQueue.main.async {
                self.tblPosts.reloadData()
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
// MARK: - UISearchBarDelegate
extension PostsVC: UISearchBarDelegate {
    
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
            postViewModel.filterContentForSearchText(searchText)
            isSearching = true
        }else{
            isSearching = false
        }
        
        tblPosts.reloadData()
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

