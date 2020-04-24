import 'package:flutter/material.dart';
import 'package:flutter_crud_example/src/models/producto_model.dart';
import 'package:flutter_crud_example/src/providers/productos_providers.dart';
// import 'package:flutter_crud_example/src/blocs/providers.dart';

class HomePage extends StatelessWidget {
  final productosProvider = new ProductosProvider();

  @override
  Widget build(BuildContext context) {
    // final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Home Page',
        style: Theme.of(context).textTheme.title,
      )),
      body: _crearListado(),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearBoton(BuildContext context) {
    return FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () => Navigator.pushNamed(context, 'producto'));
  }

  Widget _crearListado() {
    return FutureBuilder(
        future: productosProvider.cargarProductos(),
        builder: (BuildContext context,
            AsyncSnapshot<List<ProductoModel>> snapshot) {
          if (snapshot.hasData) {
            final productos = snapshot.data;

            return ListView.builder(
              itemCount: productos.length,
              itemBuilder: (context, i) => _crearItem(context, productos[i]),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget _crearItem(BuildContext context, ProductoModel producto) {
    return Dismissible(
      background: Container(color: Colors.red),
      onDismissed: (direccion) {
        productosProvider.borrarProducto(producto.id);
      },
      key: UniqueKey(),
      child: ListTile(
        title: Text('${producto.titulo} - ${producto.valor}'),
        subtitle: Text(producto.id),
        onTap: () => Navigator.pushNamed(context, 'producto', arguments: producto ),
      ),
    );
  }
}
