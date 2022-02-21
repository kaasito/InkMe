//
//  ListaTableViewCell.swift
//  inkme_beta
//
//  Created by Lucas Romero Magaña on 18/1/22.
//

import UIKit
import AlamofireImage

protocol ListaTableViewCellDelgate {
    func listaTableViewCell(_ cell:ListaTableViewCell, didSelectImageAtIndex index: Int)
    
}

protocol DestinoTableViewCellDelegate {
    func didPressFotoPerfil(_ cell:ListaTableViewCell)
}

class ListaTableViewCell: UITableViewCell {
    var delegateNickname: DestinoTableViewCellDelegate?
    var delegate: ListaTableViewCellDelgate?
    var user: User? {
        didSet {
            renderUI()
        }
    }
    
    var id = 0
    @IBOutlet weak var nickname: UIButton!
    @IBOutlet weak var tarjeta: UIView!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var vista: UIView!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var categoria: UILabel!
    
    
    @IBOutlet weak var location: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGestureRecognizerImg1 = UITapGestureRecognizer(target: self, action: #selector(imageTappedImg1(tapGestureRecognizer:)))
        let tapGestureRecognizerImg2 = UITapGestureRecognizer(target: self, action: #selector(imageTappedImg2(tapGestureRecognizer:)))
        let tapGestureRecognizerImg3 = UITapGestureRecognizer(target: self, action: #selector(imageTappedImg3(tapGestureRecognizer:)))
        img1.isUserInteractionEnabled = true
        img1.addGestureRecognizer(tapGestureRecognizerImg1)
        img2.isUserInteractionEnabled = true
        img2.addGestureRecognizer(tapGestureRecognizerImg2)
        img3.isUserInteractionEnabled = true
        img3.addGestureRecognizer(tapGestureRecognizerImg3)
        
        
        
        tarjeta.layer.cornerRadius = 10
        img1.image = UIImage(named: "harry")
        img2.image = UIImage(named: "harry2")
        img3.image = UIImage(named: "harry2")
        profilePic.layer.cornerRadius = profilePic.frame.size.width / 2
        profilePic.clipsToBounds = true
    }
    
   
    
    @objc func imageTappedImg1(tapGestureRecognizer: UITapGestureRecognizer)
    {
        
        delegate?.listaTableViewCell(self, didSelectImageAtIndex: 0)
    }
   
    
    @objc func imageTappedImg2(tapGestureRecognizer: UITapGestureRecognizer)
    {
        
        delegate?.listaTableViewCell(self, didSelectImageAtIndex: 1)
    }
    
    @objc func imageTappedImg3(tapGestureRecognizer: UITapGestureRecognizer)
    {
        
        delegate?.listaTableViewCell(self, didSelectImageAtIndex: 2)
    }
    
    
    private func renderUI() {
        guard let user = user else { return }
        
        nickname.setTitle(user.name, for: .normal)
        
        
        if user.posts!.count > 2{
            
            let url = URL(string:user.posts![0].photo!)
            let url1 = URL(string:user.posts![1].photo!)
            let url2 = URL(string:user.posts![2].photo!)
            img1.af.setImage(withURL: url!)
            img2.af.setImage(withURL: url1!)
            img3.af.setImage(withURL: url2!)
            let profilepicurl = URL(string: user.profile_picture!)
            profilePic.af.setImage(withURL: profilepicurl!)
            location.text = user.location
            categoria.text = user.styles
            
        }else{
            img1.image = UIImage(named: "harry")
            img2.image = UIImage(named: "harry2")
            img3.image = UIImage(named: "harry3")
            profilePic.image = UIImage(named: "harry")
        }
        
        
        
        
    }
    
}


