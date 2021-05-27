//
//  FriendsFotoController.swift
//  VK Client
//
//  Created by Анастасия Живаева on 26.02.2021.
//

import UIKit
import RealmSwift

class FriendsFotoController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!

    var id = 0
    var friendName = ""
    var friendGallery: [Photo] = []
    
    var token = NotificationToken()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = friendName
        
        collectionView.delegate = self
        
        userService.loadUserPhotos(id: id) { [weak self] in
            self?.loadData()
            self?.readData()
        }
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
    
    // MARK: -  UICollectionView

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friendGallery.count
    }

   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendsFotoCell", for: indexPath) as! FriendsFotoCell
    
        if let photo = friendGallery[indexPath.row].photo604 {
            let url = URL(string: photo)!
            let data = try? Data(contentsOf: url)
            cell.friendImage.image = UIImage(data: data!)
        } else {
            cell.friendImage.image = UIImage(systemName: "person.fill")
        }

        let button = ILikeButton(frame: CGRect(x: 112, y: 128, width: 60, height: 20))
        
        button.button.setTitle(String(friendGallery[indexPath.row].likes?.count ?? 0), for: .normal)
   
        cell.addSubview(button)
    
        return cell
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? FullScreenPhotoViewController {

            controller.friendsImage = friendGallery
            controller.index = collectionView.indexPathsForSelectedItems?.first?.row ?? 0
        }
    }
   
}
