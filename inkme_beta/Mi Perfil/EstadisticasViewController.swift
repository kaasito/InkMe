//
//  ViewController.swift
//  PantallaEstadistica
//
//  Created by Aitor Gomis on 14/3/22.
//

import UIKit
import Alamofire
import AlamofireImage

class EstadisticasViewController: UIViewController {
    let defaults = UserDefaults.standard
    /*Declaracion de las variables de la pantalla de estadistica:
     - Las tarjetas: para poder darles el borde redondeado
     - Los numeros: de cada uno de las estadisticas correspondientes
     - Las imagenes: de los post mas visitados*/
    @IBOutlet weak var tarjetaVisitas: UIView!
    @IBOutlet weak var tarjetaActividad: UIView!
    @IBOutlet weak var tarjetaPublico: UIView!
    
    @IBOutlet weak var numVisitas: UILabel!
    @IBOutlet weak var numPost1: UILabel!
    @IBOutlet weak var numPost2: UILabel!
    @IBOutlet weak var numPost3: UILabel!
    @IBOutlet weak var numClientes: UILabel!
    @IBOutlet weak var numTatuadores: UILabel!
    
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    
    override func viewDidLoad() {
        peticionStats()// hacemos la peticion de la api
        super.viewDidLoad()
        tarjetaPublico.layer.cornerRadius = 10
        tarjetaActividad.layer.cornerRadius = 10
        tarjetaVisitas.layer.cornerRadius = 10
        
    }
    /*Peticion a la API: viewStats
     - necesitamos: api_token
     - recibimos: visitas totales, post mas visitados (con sus estadisticas *), publico */
    func peticionStats(){
        let url = "http://desarrolladorapp.com/inkme/public/api/viewStats"
        let usuarioApiToken = defaults.string(forKey: "token")
        let json = ["api_token": usuarioApiToken]//json que enviamos con el api_token
        AF.request(url, method: .put, parameters: json as Parameters, encoding: JSONEncoding.default).responseDecodable (of: StatsResponse.self) { [self] response in
            print("response",response)
            if (response.value?.status) == 1 {
                /*Recogemos los datos de la llamada por el response*/
                self.numVisitas.text = String((response.value?.total)!)
                self.numClientes.text = String((response.value?.clients)!)
                self.numTatuadores.text = String((response.value?.tattooist)!)
                self.numPost1.text = String((response.value?.top3?[0].viewsTotales)!)
                self.numPost2.text = String((response.value?.top3?[1].viewsTotales)!)
                self.numPost3.text = String((response.value?.top3?[2].viewsTotales)!)
                /*Recogemos las imagenes, usando alamofire img para las imagenes*/
                let urlImg1 =  URL(string: (response.value?.top3?[0].photo) ?? "https://fundaciongaem.org/wp-content/uploads/2016/05/no-foto.jpg")
                self.img1.af.setImage(withURL: urlImg1!)
                
                let urlImg2 =  URL(string: (response.value?.top3?[1].photo) ?? "https://fundaciongaem.org/wp-content/uploads/2016/05/no-foto.jpg")
                self.img2.af.setImage(withURL: urlImg2!)
                
                let urlImg3 =  URL(string: (response.value?.top3?[2].photo) ?? "https://fundaciongaem.org/wp-content/uploads/2016/05/no-foto.jpg")
                self.img3.af.setImage(withURL: urlImg3!)
            }else{
                print("no se ha podido hacer fetch")
            }
        }
        
    }
}

