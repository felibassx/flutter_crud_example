import 'package:flutter/material.dart';
import 'package:flutter_crud_example/src/models/producto_model.dart';
import 'package:flutter_crud_example/src/providers/productos_providers.dart';
import 'package:flutter_crud_example/src/utils/utils.dart' as utils;

class ProductoPage extends StatefulWidget {
  // sirve para especificar el identificador unico del formulario
  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {

  final formKey = GlobalKey<FormState>();
  ProductoModel producto = new ProductoModel();
  final productosProvider = new ProductosProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Producto'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.photo_size_select_actual), onPressed: () {}),
          IconButton(icon: Icon(Icons.camera), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.all(15),
        child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _crearNombre(),
                _crearPrecio(),
                _crearDisponible(),
                _crearBoton(),
              ],
            )),
      )),
    );
  }

  Widget _crearNombre() {
    return TextFormField(
      initialValue: producto.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Producto'),
      onSaved: (value) => producto.titulo = value,
      validator: (value) {
        if (value.length < 3) {
          return 'El nombre debe tener al menos 3 caracteres';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearPrecio() {
    return TextFormField(
      initialValue: producto.valor.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: 'Precio'),
      onSaved: (value) => producto.valor = double.parse(value),
      validator: (value) {
        if (utils.isNumeric(value)) {
          return null;
        } else {
          return 'Sólo Números';
        }
      },
    );
  }

  Widget _crearBoton() {
    return RaisedButton.icon(
      onPressed: _submit,
      icon: Icon(Icons.save),
      label: Text('Guardar'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: Colors.deepPurple,
      textColor: Colors.white,
    );
  }

  Widget _crearDisponible() {
    return SwitchListTile(
      value: producto.disponible, 
      title: Text('Disponible'),
      activeColor: Colors.deepPurple,
      onChanged: (value) => setState((){
        producto.disponible = value;
      })
    );
  }

  void _submit() {

    // formKey.currentState.validate(): esta instrucción regresará un true si el formulario es válido

    if (!formKey.currentState.validate()) return;

    // Código si es válido
    formKey.currentState.save(); // dispara el evento onsaved()        

    // print(producto.titulo);
    // print(producto.valor);
    // print(producto.disponible);

    productosProvider.crearProducto(producto);
    
  }
}
