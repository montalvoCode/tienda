import UIKit
import Alamofire

class AutenticacionVC: UIViewController {

    
    @IBOutlet weak var txtUsuario: UITextField!
  
    
    @IBOutlet weak var txtClave: UITextField!
   
    
    @IBAction func autenticar(_ sender: Any) {
        let usuario:String  = (txtUsuario.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!
        let clave = txtClave.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        let url = "http://localhost:3000/api/Autenticacion"
        let parametros:Parameters = ["usuario":usuario,
                                     "clave":clave]
        let delegado = UIApplication.shared.delegate as! AppDelegate
        request(url, method: .post, parameters: parametros, encoding: JSONEncoding.default, headers: nil)
        .responseJSON { (resultado) in
            switch (resultado.result)
            {
            case .failure:
                delegado.mostrarCuadroDialogo(titulo: "ERROR", mensaje: "Error con el servicio de autenticacion", vista: self)
            case .success:
                if resultado.response?.statusCode == 200
                {
                    self.performSegue(withIdentifier: "irProductoVC", sender: self)
                }
                else
                {
                    delegado.mostrarCuadroDialogo(titulo: "ERROR", mensaje: "Error con el usuario y/o clave", vista: self)
                }
            }
        }
        
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
