//
//  ApiService.swift
//  VK-Client
//
//  Created by Artem Firsov on 10/18/21.
//

import Foundation
import Alamofire

class ApiService {
   
    let baseUrl: String = "https://api.vk.com/method"
    let token = Storage.shared.token
    let clientId = "143669340"
    let version = "5.131"
    
    func getFriends(completion: @escaping([User]) -> ()) {
        
        let method = "/friends.get"
        
        let params: Parameters = [
                                  "order": "hints",
                                  "fields": "photo_50",
                                  "access_token": Storage.shared.token,
                                  "v": version]
        
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: params).responseData { response in
            guard let data = response.data else { return }
//            print(data.prettyJSON as Any)
            
            do {
                guard let friendsResponse = try? JSONDecoder().decode(FriendsModel.self, from: data) else { return }
                let friends = friendsResponse.response.items
                
                DispatchQueue.main.async {
                    completion(friends)
                }
            } catch {
                print(error)
            }
        }
    }
    
    func getGroups(completion: @escaping([Group]) -> ()) {
        let method = "/groups.get"
        
        let params: Parameters = [ "extended": 1,
                                   "fields": "photo_50,photo_100",
                                   "access_token": Storage.shared.token,
                                   "v": version]
        
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: params).responseData { response in
            guard let data = response.data else { return }
            
//            print(data.prettyJSON as Any)
            do {
                guard let groupsResponse = try? JSONDecoder().decode(GroupModel.self, from: data) else { return }
                let groups = groupsResponse.response.items
                DispatchQueue.main.async {
                    completion(groups)  
                }
            } catch {
                print(error)
            }
        }
    }
    
    func getNews(completion: @escaping([News], [Group]?, [Profile]?) -> ()) {
        let method = "/newsfeed.get"
        let url = baseUrl + method
        
        let params: Parameters = ["user_id": clientId,
                                  "filters": "post",
                                  "count": 2,
                                  "access_token": Storage.shared.token,
                                  "v":version]
        
        AF.request(url, method: .get, parameters: params).responseData { response in
            guard let data = response.data else { return }
//            print(data.prettyJSON as Any)
            
            do {
                guard let newsResponse = try? JSONDecoder().decode(NewsFeedModel.self, from: data) else { return }
//                let response = newsResponse.response
                let post = newsResponse.response.items
                let groups = newsResponse.response.groups
                let profiles = newsResponse.response.profiles
                
                DispatchQueue.main.async {
                    completion(post, groups, profiles)
                }
            }
        }
    }
    
    func getCleanNews(completion: @escaping(NewsResponse) -> ()) {
        let method = "/newsfeed.get"
        let url = baseUrl + method
        
        let params: Parameters = ["user_id": clientId,
                                  "filters": "post",
                                  "count": 55,
                                  "access_token": Storage.shared.token,
                                  "v":version]
        
        AF.request(url, method: .get, parameters: params).responseData { response in
            guard let data = response.data else { return }
//            print(data.prettyJSON as Any)
            
            do {
                guard let newsResponse = try? JSONDecoder().decode(NewsFeedModel.self, from: data) else { return }
                let response = newsResponse.response
//                let post = newsResponse.response.items
//                let groups = newsResponse.response.groups
//                let profiles = newsResponse.response.profiles
                
                DispatchQueue.main.async {
//                    completion(post, groups, profiles)
                    completion(response)
                    
                }
            }
        }
    }

}
