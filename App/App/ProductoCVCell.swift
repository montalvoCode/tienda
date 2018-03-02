

import UIKit
import AlamofireImage

class ProductoCVCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imagen: UIImageView!
    
    var producto: Producto? = nil{
        didSet{
            if let prod = producto,
                let url = URL(string:prod.foto){
                self .imagen.af_setImage(withURL: url)
            }
            
        }
    }
    
}
