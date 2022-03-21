
import UIKit

class AceptadasViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    

    var citas: [CitasActvas]?
    @IBOutlet weak var tabla: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabla.delegate = self
        self.tabla.dataSource = self
       
        AceptadasNetWorking.shared.getUser() { arrayPost in
            self.posts = arrayPost
            self.tabla.reloadData()
        } failure: { error in
            print(error)
        }
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabla.delegate = self
        self.tabla.dataSource = self
        FavNetWorking.shared.getUser() { arrayPost in
            self.posts = arrayPost
          
            
            self.tabla.reloadData()
        } failure: { error in
            print(error)
        }
        
        self.tabla.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavsCell", for: indexPath) as! FavsTableViewCell
        cell.post = posts![indexPath.row]
        cell.delegate = self
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
