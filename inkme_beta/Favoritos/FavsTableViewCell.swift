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
    func didPressFotoPerfil(_ cell:FavsTableViewCell, didSelecProfilePic index: Bool)
    
}

class FavsTableViewCell: UITableViewCell {
    var delegate: FavsTableViewCellDelgate?
    var id = 0
    var url1:String?
    @IBOutlet weak var descripcion: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var corazon: UIButton!
    @IBOutlet weak var vista: UIView!
    @IBOutlet weak var imagenPost: UIImageView!
    var post: Post? {
        didSet{
            renderUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGestureRecognizerPp = UITapGestureRecognizer(target: self, action: #selector(imageTappedPp(tapGestureRecognizer:)))
        imagenPost.isUserInteractionEnabled = true
        imagenPost.addGestureRecognizer(tapGestureRecognizerPp)
        vista.layer.cornerRadius = 10
        corazon.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
        corazon.setImage(UIImage(systemName: "suit.heart.fill"), for: .highlighted)
        corazon.setImageTintColor(UIColor.systemRed)
        descripcion.numberOfLines = 0
        descripcion.lineBreakMode = NSLineBreakMode.byWordWrapping
    }
    
    @objc func imageTappedPp(tapGestureRecognizer: UITapGestureRecognizer)
    {
        
        delegate?.didPressFotoPerfil(self, didSelecProfilePic: true)
    }
    
    private func renderUI() {
        guard let post = post else { return }
        
        let url = URL(string: post.photo!)
        imagenPost.af.setImage(withURL: url!)
        username.text = post.title
        descripcion.text = post.description
        id = post.id!
        url1 = post.photo!
    }
}
