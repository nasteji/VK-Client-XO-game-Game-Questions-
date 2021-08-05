//
//  FriendAdapter.swift
//  VK Client
//
//  Created by Анастасия Живаева on 22.07.2021.
//

import Foundation
import RealmSwift

final class FriendAdapter {
    
    private let friendService = UserService()
    private var realmNotificationTokens = NotificationToken()
    
    func getFriends(completion: @escaping ([Friend]) -> Void) {
        guard let realm = try? Realm() else { return }
        
        let realmFriend = realm.objects(User.self)
        
        let token = realmFriend.observe { [weak self] (changes: RealmCollectionChange) in
            guard let self = self else { return }
            
            switch changes {
            case .update(let realmFriends, _, _, _):
                var friends: [Friend] = []
                for realmFriend in realmFriends {
                    friends.append(self.friend(from: realmFriend))
                }
                completion(friends)
            case .error(let error):
                fatalError("\(error.localizedDescription)")
            case .initial:
                break
            }
        }
        self.realmNotificationTokens = token
        friendService.loadFriends()
    }
    
        private func friend(from rlmUser: User) -> Friend {
            return Friend(id: rlmUser.id,
                          firstName: rlmUser.firstName,
                          lastName: rlmUser.lastName,
                          photo: rlmUser.photo)
        }
}
