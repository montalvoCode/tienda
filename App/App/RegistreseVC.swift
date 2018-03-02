
import UIKit
import Alamofire

class RegistreseVC: UIViewController {
    
    
    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var txtUsuario: UITextField!
    @IBOutlet weak var txtClave: UITextField!
    @IBOutlet weak var txtConfirmaClave: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func registrar(_ sender: Any) {
        let clave = txtClave.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let confirmaClave = txtConfirmaClave.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let delegado = UIApplication.shared.delegate as! AppDelegate
        if (clave == confirmaClave)
        {
            //consumimos el servicio REST
            let url = "http://localhost:3000/api/usuarios"
            let parametros:Parameters = ["usuario":txtUsuario.text,
                                         "clave":clave,
                                         "nombre":txtNombre.text]
          
            request(url, method: .post, parameters: parametros, encoding: JSONEncoding.default, headers: nil)
            .responseJSON(completionHandler: { (resultado) in
                switch (resultado.result)
                {
                case .failure:
                    delegado.mostrarCuadroDialogo(titulo: "ERROR", mensaje: "Error al registrar al usuario", vista: self)
                case .success:
                    delegado.mostrarCuadroDialogo(titulo: "AVISO", mensaje: "Usuario registrado correctament", vista: self)
                    self.txtNombre.text = ""
                    self.txtUsuario.text = ""
                    self.txtClave.text = ""
                    self.txtConfirmaClave.text = ""
                    
                }
            })
            
        }
        else
        {
            
            delegado.mostrarCuadroDialogo(titulo: "ERROR", mensaje: "Las claves no coinciden", vista: self)
            
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
