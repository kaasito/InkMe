
import UIKit

class AceptadasViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    

    var citas: [Cita]?
   // @IBOutlet weak var noDatesImage: UIImageView!
    @IBOutlet weak var noDatesText: UILabel!
    @IBOutlet weak var tabla: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabla.delegate = self
        self.tabla.dataSource = self
       
        AceptadasNetWorking.shared.getUser() { arrayCitas in
            self.citas = arrayCitas
            self.tabla.reloadData()
            if self.citas?.count == 0{
                self.noDatesText.isHidden = false
             //   self.noDatesImage.isHidden = false
                self.tabla.isHidden = true
            }else{
                self.noDatesText.isHidden = true
               // self.noDatesImage.isHidden = true
                self.tabla.isHidden = false
            }
        } failure: { error in
            print(error)
        }
        
      
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabla.delegate = self
        self.tabla.dataSource = self
        AceptadasNetWorking.shared.getUser() { arrayCitas in
            self.citas = arrayCitas
            self.tabla.reloadData()
            if self.citas?.count == 0{
                self.noDatesText.isHidden = false
                self.tabla.isHidden = true
            }else{
                self.noDatesText.isHidden = true
                self.tabla.isHidden = false
            }
        } failure: { error in
            print(error)
        }
     
        self.tabla.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citas?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CitasCell", for: indexPath) as! CitasAceptadasTableViewCell
        cell.nombre.text = citas![indexPath.row].client_name
        cell.fecha.text = citas![indexPath.row].date
        cell.telefono.text = citas![indexPath.row].client_tlf
        cell.comentario.text = citas![indexPath.row].comment
        cell.backgroundColor = .clear
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as! CitasAceptadasTableViewCell
        cell.backgroundColor = .clear
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.black
        cell.selectedBackgroundView = bgColorView
    }
}
