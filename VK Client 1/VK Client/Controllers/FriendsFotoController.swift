//
//  FriendsFotoController.swift
//  VK Client
//
//  Created by Анастасия Живаева on 26.02.2021.
//

import UIKit
import RealmSwift

class FriendsFotoController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!

    var id = 0
    var friendName = ""
    var friendGallery: [Photo] = []
    
    var token = NotificationToken()
    let userService = UserService()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = friendName
        collectionView.delegate = self
        
        userService.loadUserPhotos(id: id) { [weak self] in
            self?.loadData()
            self?.readData()
        }
        
        collectionView.register(UINib(nibName: "FriendsFotoCell", bundle: nil), forCellWithReuseIdentifier: FriendsFotoCell.reuseId)
    }
    
    // MARK: - Load and Read Data
    
    func loadData() {
        do {
            let realm = try Realm()
            let photos = realm.objects(Photo.self)
            self.friendGallery = Array(photos)
        } catch {
            print(error)
        }
    }
    
    func readData() {
        guard let realm = try? Realm() else { return }
        let photos = realm.objects(Photo.self)
        token = photos.observe { changes in
            guard let collectionView = self.collectionView else { return }
            
            switch changes {
            case .initial:
                collectionView.reloadData()
                print("Start to modified Photos")
            case .update(let results, deletions: let deletions, insertions: let insertions, modifications: let modifications):
                collectionView.performBatchUpdates({
                    collectionView.insertItems(at: insertions.map({ IndexPath(row: $0, section: 0) }))
                    collectionView.deleteItems(at: deletions.map({ IndexPath(row: $0, section: 0) }))
                    collectionView.reloadItems(at: modifications.map({ IndexPath(row: $0, section: 0) }))
                }, completion: nil)
                print("Photos were modified: \(results)")
            case .error(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: -  CollectionView Data Source

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friendGallery.count
    }

   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FriendsFotoCell.reuseId, for: indexPath) as! FriendsFotoCell
    
        cell.configure(photo: friendGallery[indexPath.row])
    
        return cell
    }
    
    // MARK: - CollectionView Layout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width/3, height: UIScreen.main.bounds.width/3)
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? FullScreenPhotoViewController {

            controller.friendsImage = friendGallery
            controller.index = collectionView.indexPathsForSelectedItems?.first?.row ?? 0
        }
    }
   
}
