import UIKit
import Alamofire
import SwiftyJSON

class ProductoVC: BaseViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    
    var categorias:[Categoria] = []
    func numberOfSections(in tableView: UITableView) -> Int {
        return categorias.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categorias[section].nombre
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "celda") as! ProductoTVCell
        celda.categoria = categorias[indexPath.section]
        return celda
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false

        // Do any additional setup after loading the view.
        addSlideMenuButton()
        self.obtenerDatos()
    }
    
    func obtenerDatos() {
        let url = "http://localhost:3000/api/categorias";
        request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
        .responseJSON { (resultado) in
            let delegado  = UIApplication.shared.delegate as! AppDelegate
            
            switch resultado.result{
            case .failure:
                delegado.mostrarCuadroDialogo(titulo: "ERROR", mensaje: "Error con el servicio", vista: self)
            case .success:
                if resultado.response?.statusCode == 200{
                    let json = JSON(resultado.value!)
                    for(_,valor) in json
                    {
                        let nombreCat = valor["nombre"].string
                        var productos:[Producto] = []
                        for(_,valor1) in valor["productos"]
                        {
                            let prod = Producto(nombre: valor1["producto"].string!,
                                                precio: valor1["precio"].string!,
                                                foto: valor1["foto"].string!)
                            productos.append(prod)
                        }
                        let categoria = Categoria(nombre: nombreCat!, productos: productos)
                        self.categorias.append(categoria)
                    }
                    self.tableView.reloadData()
                    
                }else{
                    delegado.mostrarCuadroDialogo(titulo: "ERROR", mensaje: "Error al listar la categoria", vista: self)
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
