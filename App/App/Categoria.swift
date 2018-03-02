
import Foundation

class Categoria  {
    var nombre:String
    var productos: [Producto]
    
    init(nombre:String, productos:[Producto]) {
        self.nombre = nombre
        self.productos = productos
    }
}
