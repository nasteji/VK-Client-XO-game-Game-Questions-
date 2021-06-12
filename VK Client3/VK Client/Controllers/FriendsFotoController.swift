//
//  FriendsFotoController.swift
//  VK Client
//
//  Created by Анастасия Живаева on 26.02.2021.
//

import UIKit

class FriendsFotoController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!

    var id = 0
    var friendName = ""
    var friendGallery: [Photo] = []
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = friendName
        
        collectionView.delegate = self
        
        userService.loadUserPhotos(id: id) { [weak self] photos in
            self?.friendGallery = photos
            self?.collectionView.reloadData()
        }
    }
    
    // MARK: -  UICollectionView

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friendGallery.count
    }

   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendsFotoCell", for: indexPath) as! FriendsFotoCell
    
        let data = try? Data(contentsOf: friendGallery[indexPath.row].sizes.last!.url)
    
        cell.friendImage.image = UIImage(data: data!)
    
        let button = ILikeButton(frame: CGRect(x: 112, y: 128, width: 60, height: 20))
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
