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
    func didPressFotoPerfil(_ cell:ListaTableViewCell, didSelecProfilePic index: Bool)
    func callSegueFromCell(_ cell:ListaTableViewCell, didSelectNickName index: Bool)
}



class ListaTableViewCell: UITableViewCell {
    @IBOutlet weak var viewsLabel: UILabel!
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
        let tapGestureRecognizerPp = UITapGestureRecognizer(target: self, action: #selector(profilePictureTapped(tapGestureRecognizer:)))
        img1.isUserInteractionEnabled = true
        img1.addGestureRecognizer(tapGestureRecognizerImg1)
        img2.isUserInteractionEnabled = true
        img2.addGestureRecognizer(tapGestureRecognizerImg2)
        img3.isUserInteractionEnabled = true
        img3.addGestureRecognizer(tapGestureRecognizerImg3)
        profilePic.isUserInteractionEnabled = true
        profilePic.addGestureRecognizer(tapGestureRecognizerPp)
        
        
        
        tarjeta.layer.cornerRadius = 10
        img1.image = UIImage(named: "harry")
        img2.image = UIImage(named: "harry2")
        img3.image = UIImage(named: "harry2")
        profilePic.layer.cornerRadius = profilePic.frame.size.width / 2
        profilePic.clipsToBounds = true
    }
    
   
    
    @IBAction func didpressedButtonNicknAME(_ sender: Any) {
        delegate?.callSegueFromCell(self, didSelectNickName: true)
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
    
    @objc func profilePictureTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        
        delegate?.didPressFotoPerfil(self, didSelecProfilePic: true)
    }
    
    
    private func renderUI() {
        guard let user = user else { return }
        let nombreusuariovalor:String = user.name!
        let arroba = "@"
        let mostrar = arroba + nombreusuariovalor
        nickname.setTitle(mostrar, for: .normal)
        
        
        if user.posts!.count > 2{
            
            let url = URL(string:user.posts![0].photo!)
            let url1 = URL(string:user.posts![1].photo!)
            let url2 = URL(string:user.posts![2].photo!)
            img1.af.setImage(withURL: url!)
            img2.af.setImage(withURL: url1!)
            img3.af.setImage(withURL: url2!)
            let profilepicurl = URL(string: user.profile_picture ?? "https://fundaciongaem.org/wp-content/uploads/2016/05/no-foto.jpg")
            profilePic.af.setImage(withURL: profilepicurl!)
            location.text = user.location
            categoria.text = user.styles
            viewsLabel.text = "\(user.viewsTotales!) Views"
            
        }else{
            img1.image = UIImage(named: "harry")
            img2.image = UIImage(named: "harry2")
            img3.image = UIImage(named: "harry3")
            profilePic.image = UIImage(named: "harry")
        }
        
        
        
        
    }
    
}


