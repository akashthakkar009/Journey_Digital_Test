//
//  APIService.swift
//
//  DoubleYolk_JourneyDigital_Test
//
//  Created by DoubleYolk on 03/12/21.


import Foundation


enum NetworkError {
    case noInternet
    case networkError
    case fetchError
    
    var errorMessage: String {
        switch self {
        case .noInternet: return "Please check your internet connectivity and try again"
        case .networkError: return "Something went wrong!"
        case .fetchError: return "Unable to Fetch!"
        }
    }
}

enum NetworkResult {
    case success(Array<Any>?)
    case failure(NetworkError)
}

class APIService {
    
    static let instance = APIService()
    
    
    /// apiToGetPosts : API call with make the request and fetch the list of post api json and convert it into Post model object listing with success & failure blocks
    /// - Parameter completion: completion will retun Network Results with success & failure blocks
    public func apiToGetPosts(completion: @escaping(NetworkResult) -> ()) {
        
        if Reachability.isConnectedToNetwork(){
            guard let url = URL(string: API.kBaseURL + API.kPosts) else { return }
            
            URLSession.shared.dataTask(with: url) { (data, response ,error) in
                
                guard let dataReceive = data else {
                    DispatchQueue.main.async {
                        completion(NetworkResult.failure(NetworkError.fetchError))
                    }
                    return
                }
                do {
                    let posts = try JSONDecoder().decode(Array<Post>.self, from: dataReceive)
                    completion(NetworkResult.success(posts))
                } catch( _) {
                    DispatchQueue.main.async {
                        completion(NetworkResult.failure(NetworkError.networkError))
                    }
                }
            }.resume()
        }else{
            DispatchQueue.main.async {
                Utility.mostTopViewController?.showAlert(withTitle: "No Internet", andMessage: NetworkError.noInternet.errorMessage)
                completion(NetworkResult.failure(NetworkError.noInternet))
            }
        }
    }
    
    /// apiToGetComments : API call with make the request and fetch the list of Comment api json and convert it into Comment model object listing with success & failure blocks
    /// - Parameter completion: completion will retun Network Results with success & failure blocks
    public func apiToGetComments(_ postID : Int, completion: @escaping(NetworkResult) -> ()) {
        
        if Reachability.isConnectedToNetwork(){
            guard let url = URL(string: API.kBaseURL + API.kPosts + "/\(postID)/" + API.kComments) else { return }
            
            URLSession.shared.dataTask(with: url) { (data, response ,error) in
                
                guard let dataReceive = data else {
                    DispatchQueue.main.async {
                        completion(NetworkResult.failure(NetworkError.fetchError))
                    }
                    return
                }
                do {
                    let comments = try JSONDecoder().decode(Array<Comments>.self, from: dataReceive)
                    completion(NetworkResult.success(comments))
                } catch( _) {
                    DispatchQueue.main.async {
                        completion(NetworkResult.failure(NetworkError.networkError))
                    }
                }
            }.resume()
            
        }else{
            DispatchQueue.main.async {
                Utility.mostTopViewController?.showAlert(withTitle: "No Internet", andMessage: NetworkError.noInternet.errorMessage)
                completion(NetworkResult.failure(NetworkError.noInternet))
            }
        }
    }
}
