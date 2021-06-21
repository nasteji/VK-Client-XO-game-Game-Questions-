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
        }
        
        collectionView.register(UINib(nibName: "FriendsFotoCell", bundle: nil), forCellWithReuseIdentifier: FriendsFotoCell.reuseId)
    }
    
    // MARK: - Load Data
    
    func loadData() {
        do {
            let realm = try Realm()
            let photos = realm.objects(Photo.self)
            self.friendGallery = Array(photos)
            collectionView.reloadData()
        } catch {
            print(error)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "SegueToFullScreenPhotoViewController", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? FullScreenPhotoViewController {

            controller.friendsImage = friendGallery
            controller.index = collectionView.indexPathsForSelectedItems?.first?.row ?? 0
        }
    }
   
}
