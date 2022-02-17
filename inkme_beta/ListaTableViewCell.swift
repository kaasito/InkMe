//
//  ListaTableViewCell.swift
//  inkme_beta
//
//  Created by Lucas Romero Magaña on 18/1/22.
//

import UIKit
import AlamofireImage
class ListaTableViewCell: UITableViewCell {
    var user: User? {
        didSet {
            renderUI()
        }
    }
    let tableview = ListaViewController()
    @IBOutlet weak var nickname: UIButton!
    @IBOutlet weak var tarjeta: UIView!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var vista: UIView!
    @IBOutlet weak var profilePic: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tarjeta.layer.cornerRadius = 10
        img1.image = UIImage(named: "harry")
        img2.image = UIImage(named: "harry2")
        img3.image = UIImage(named: "harry2")
        profilePic.layer.cornerRadius = profilePic.frame.size.width / 2
        profilePic.clipsToBounds = true
    }
    
   
    private func renderUI() {
        guard let user = user else { return }
        
        nickname.setTitle(user.name, for: .normal)
       
        
        if user.posts.count > 2{
            let url = URL(string:user.posts[0].photo)
            let url1 = URL(string:user.posts[1].photo)
            let url2 = URL(string:user.posts[2].photo)
            img1.af.setImage(withURL: url!)
            img2.af.setImage(withURL: url1!)
            img3.af.setImage(withURL: url2!)
            let profilepicurl = URL(string: user.profile_picture!)
            profilePic.af.setImage(withURL: profilepicurl!)
            
        }else{
            img1.image = UIImage(named: "harry")
            img2.image = UIImage(named: "harry2")
            img3.image = UIImage(named: "harry3")
            profilePic.image = UIImage(named: "harry")
        }
        
       
      
        
    }
    
}


