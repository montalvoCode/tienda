 //server.js

//referenciando las librerias

var express = require('express');
var mongoose = require('mongoose');
var bodyparser = require('body-parser');

//conectando a la BD
mongoose.connect('mongodb://localhost/Ventas',function(err){
	if (err)
	{
		console.log('Error al conectar a la BD');
	}
	else
	{
		console.log('Conexion correcta');
	}
});


//creando el esquema para productos
var productoEsquema = mongoose.Schema({
	producto:String,
	precio:String,
	foto:String
});

//creando el esquema para categorias
var categoriaEsquema = mongoose.Schema({
	nombre:String,
	productos:[productoEsquema]
});


//creando el esquema para la coleccion usuarios

var usuarioEsquema = mongoose.Schema({
	usuario:{type:String,unique:true},
	clave:String,
	nombre:String
});

//creando la coleccion
var usuario = mongoose.model('usuarios',usuarioEsquema);
var categoria = mongoose.model('categorias',categoriaEsquema);

//Implementando el servicio express
var app = express();
app.use(bodyparser.json());
app.use(bodyparser.urlencoded({extended:false}));

//Implementando el ruteo
var router = express.Router();

router.route('/categorias').get(function(req,res){
	categoria.find(function(err,resultado){
		if (err){
			res
			.status(500)
			.json({mensaje:'Error al listar las categorias'});
		}
		else{
			res.status(200).json(resultado);
		}
	});
});

router.route('/cargamasiva').get(function(req,res){
	var categoria1 = new categoria();
	categoria1.nombre = 'Camisas';
	for(var i=1;i<11;i++)
	{
		categoria1.productos.push({
			producto: 'camisa'+i,
			precio: 'S/5',
			foto:'http://localhost:3000/images/camisa'+i+'.jpg'
		});
	}

	var categoria2 = new categoria();
	categoria2.nombre = 'Carteras';
	for(var i = 1;i<11;i++)
	{
		categoria2.productos.push({
			producto:'Cartera'+i,
			precio:'S/350.00',
			foto:'http://localhost:3000/images/cartera'+i+'.jpg'
		});
	}

	var categoria3 = new categoria();
	categoria3.nombre = 'Polos';
	for(var i = 1;i<11;i++)
	{
		categoria3.productos.push({
			producto:'Polo'+i,
			precio:'S/40',
			foto:'http://localhost:3000/images/Polo'+i+'.jpg'
		});
	}

	var categoria4 = new categoria();
	categoria4.nombre = 'Vestidos';
	for(var i = 1;i<11;i++)
	{
		categoria4.productos.push({
			producto:'Vestido'+i,
			precio:'S/2500',
			foto:'http://localhost:3000/images/Vestido'+i+'.jpg'
		});
	}

	var categoria5 = new categoria();
	categoria5.nombre = 'Zapatos';
	for(var i = 1;i<11;i++)
	{
		categoria5.productos.push({
			producto:'Zapato'+i,
			precio:'S/3',
			foto:'http://localhost:3000/images/zapato'+i+'.jpg'
		});
	}

	categoria1.save();
	categoria2.save();
	categoria3.save();
	categoria4.save();
	categoria5.save();
});


router.route('/usuarios').post(function(req,res){
	var miUsuario = new usuario();
	miUsuario.usuario = req.body.usuario;
	miUsuario.clave = req.body.clave;
	miUsuario.nombre = req.body.nombre;
	miUsuario.save(function(err){
		if (err)
		{
			res
			.status(500)
			.json({mensaje:'Error al registrar al usuario'});
		}
		else
		{
			res
			.status(200)
			.json({mensaje:'Usuario registrado'});
		}
	});
});

router.route('/Autenticacion')
.post(function(req,res){
	usuario.findOne({usuario:req.body.usuario,
		clave:req.body.clave},function(err,miUsuario){
			if(err)
			{
				res.status(500).json({mensaje:'Error con la base BD'});
			}
			else
			{
				if (!miUsuario)
				{
					res.status(500).json({mensaje:'Error de autenticacion'});
				}
				else
				{
					res.status(200).json(
						{mensaje:'Usuario autenticado correctamente'});
				}
			}
		});
});


app.use(express.static('public'));
app.use('/api',router);
app.listen(3000);


































































