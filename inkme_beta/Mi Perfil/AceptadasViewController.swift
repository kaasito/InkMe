
import UIKit

class AceptadasViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    

    var citas: [CitasActvas]?
    @IBOutlet weak var tabla: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabla.delegate = self
        self.tabla.dataSource = self
       
        AceptadasNetWorking.shared.getUser() { arrayCitas in
            self.citas = arrayCitas
            self.tabla.reloadData()
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
        let cell = tableView.cellForRow(at: indexPath) as! FavsTableViewCell
        cell.backgroundColor = .clear
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.black
        cell.selectedBackgroundView = bgColorView
    }
}
