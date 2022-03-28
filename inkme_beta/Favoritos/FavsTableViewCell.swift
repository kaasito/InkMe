//
//  FavsTableViewCell.swift
//  inkme_beta
//
//  Created by Lucas Romero Magaña on 11/3/22.
//

import UIKit
import Alamofire
import AlamofireImage

protocol FavsTableViewCellDelgate {
    func didPressProfilePicture(_ cell:FavsTableViewCell, didSelecProfilePic index: Bool)
    
}

class FavsTableViewCell: UITableViewCell {
    var delegate: FavsTableViewCellDelgate?
    var id = 0
    var urlPost:String?
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var postImage: UIImageView!
    var post: Post? {
        didSet{
            renderUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGestureRecognizerPp = UITapGestureRecognizer(target: self, action: #selector(profilePictureTapped(tapGestureRecognizer:)))
        postImage.isUserInteractionEnabled = true
        postImage.addGestureRecognizer(tapGestureRecognizerPp)
        view.layer.cornerRadius = 10
        desc.numberOfLines = 0
        desc.lineBreakMode = NSLineBreakMode.byWordWrapping
    }
    
    @objc func profilePictureTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        
        delegate?.didPressProfilePicture(self, didSelecProfilePic: true)
    }
    
    private func renderUI() {
        guard let post = post else { return }
        
        let url = URL(string: post.photo!)
        postImage.af.setImage(withURL: url!)
        username.text = post.title
        desc.text = post.description
        id = post.id!
        urlPost = post.photo!
    }
}
