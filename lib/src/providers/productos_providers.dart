
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_crud_example/src/models/producto_model.dart';

class ProductosProvider {

  final String _url = 'https://flutter-varioscl.firebaseio.com';

  Future<bool> crearProducto( ProductoModel producto ) async {

    final url = '$_url/productos.json';

    final resp = await http.post(url, body: productoModelToJson(producto));

    final decodedData = jsonDecode(resp.body);

    print(decodedData);

    return true;

  }

  Future<List<ProductoModel>> cargarProductos() async {

    final url = '$_url/productos.json';

    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = jsonDecode(resp.body);
    final List<ProductoModel> productos = new List();

    if (decodedData == null) return [];

    decodedData.forEach( (id, prod) {

      final prodTemp = new ProductoModel.fromJson(prod);
      prodTemp.id = id;

      productos.add(prodTemp);

    }); 

    // print(productos);

    return productos;

  }

  Future<int> borrarProducto( String id ) async {

    final url = '$_url/productos/$id.json';
    final resp = await http.delete(url);

    print(jsonDecode(resp.body));

    return 1;

  }
  
}