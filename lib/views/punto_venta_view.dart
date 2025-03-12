import 'package:flutter/material.dart';

class PuntoVentaView extends StatefulWidget {
  const PuntoVentaView({super.key});

  @override
  State<PuntoVentaView> createState() => _PuntoVentaViewState();
}

class _PuntoVentaViewState extends State<PuntoVentaView> {
  // Lista para almacenar los artículos agregados a la venta
  final List<ArticuloVenta> _articulosVenta = [];

  // Color principal de la aplicación
  final Color azulPrimario = const Color(0xFF1E4D8C);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar personalizado con el color azul principal y logo
      appBar: AppBar(
        backgroundColor: azulPrimario,
        title: const Text(
          'Punto de Venta',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          // Logo en el lado derecho
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Image.asset(
              'assets/images/logo_solito.jpeg',
              height: 40,
            ),
          ),
        ],
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Área izquierda (70% del ancho) - Catálogo o búsqueda de productos
            Expanded(
              flex: 7,
              child: Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Barra de búsqueda
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Buscar producto...',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Título de la sección de productos
                      Text(
                        'Productos',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: azulPrimario,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Lista de productos para ejemplo
                      // En una aplicación real, esto podría ser un GridView o ListView con datos de una API/DB
                      Expanded(
                        child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 1.2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: _productosEjemplo.length,
                          itemBuilder: (context, index) {
                            final producto = _productosEjemplo[index];
                            return _buildProductoItem(producto);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(width: 16),

            // Área derecha (30% del ancho) - Lista de artículos y total
            Expanded(
              flex: 3,
              child: Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Encabezado de la venta actual
                      Text(
                        'Venta Actual',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: azulPrimario,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Etiquetas para las columnas de la lista
                      Row(
                        children: const [
                          Expanded(
                            flex: 2,
                            child: Text(
                              'Producto',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              'Precio',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                      const Divider(thickness: 1),

                      // Lista de artículos agregados
                      Expanded(
                        child: _articulosVenta.isEmpty
                            ? Center(
                          child: Text(
                            'No hay artículos agregados',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        )
                            : ListView.builder(
                          itemCount: _articulosVenta.length,
                          itemBuilder: (context, index) {
                            final articulo = _articulosVenta[index];
                            return _buildArticuloItem(articulo, index);
                          },
                        ),
                      ),

                      // Resumen del total
                      const Divider(thickness: 1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '\$${_calcularTotal().toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: azulPrimario,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Botón para finalizar la venta
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _articulosVenta.isEmpty
                              ? null // Deshabilitado si no hay artículos
                              : () {
                            // Lógica para finalizar la venta
                            _finalizarVenta();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: azulPrimario,
                            foregroundColor: Colors.white,
                            disabledBackgroundColor: Colors.grey[400],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Finalizar Venta',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Botón para cancelar la venta
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: OutlinedButton(
                          onPressed: _articulosVenta.isEmpty
                              ? null // Deshabilitado si no hay artículos
                              : () {
                            // Lógica para cancelar la venta
                            _cancelarVenta();
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.red,
                            side: const BorderSide(color: Colors.red),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Cancelar Venta',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget para mostrar un artículo del catálogo
  Widget _buildProductoItem(Producto producto) {
    return InkWell(
      onTap: () {
        _agregarArticulo(producto);
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: 32,
              color: azulPrimario,
            ),
            const SizedBox(height: 8),
            Text(
              producto.nombre,
              style: const TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              producto.presentacion,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              '\$${producto.precio.toStringAsFixed(2)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: azulPrimario,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget para mostrar un artículo en la lista de compra
  Widget _buildArticuloItem(ArticuloVenta articulo, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          // Botón para eliminar el artículo
          IconButton(
            icon: const Icon(Icons.remove_circle, color: Colors.red, size: 20),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: () {
              setState(() {
                _articulosVenta.removeAt(index);
              });
            },
          ),
          const SizedBox(width: 8),

          // Información del artículo
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  articulo.nombre,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  articulo.presentacion,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // Precio del artículo
          Expanded(
            flex: 1,
            child: Text(
              '\$${articulo.precio.toStringAsFixed(2)}',
              textAlign: TextAlign.right,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  // Meétodo para agregar un artículo a la venta
  void _agregarArticulo(Producto producto) {
    setState(() {
      _articulosVenta.add(
        ArticuloVenta(
          nombre: producto.nombre,
          presentacion: producto.presentacion,
          precio: producto.precio,
        ),
      );
    });

    // Mostrar una notificación de éxito
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${producto.nombre} agregado'),
        duration: const Duration(seconds: 1),
        backgroundColor: azulPrimario,
      ),
    );
  }

  // Méetodo para calcular el total de la venta
  double _calcularTotal() {
    double total = 0;
    for (var articulo in _articulosVenta) {
      total += articulo.precio;
    }
    return total;
  }

  // Méetodo para finalizar la venta
  void _finalizarVenta() {
    // Aquí iría la lógica para procesar la venta
    // Por ejemplo, guardar en la base de datos, imprimir recibo, etc.

    // Por ahora, solo mostramos un diálogo de confirmación
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Venta Finalizada'),
        content: Text('Total: \$${_calcularTotal().toStringAsFixed(2)}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Limpiar la lista de artículos después de finalizar
              setState(() {
                _articulosVenta.clear();
              });
            },
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }

  // Méetodo para cancelar la venta
  void _cancelarVenta() {
    // Mostrar confirmación antes de cancelar
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancelar Venta'),
        content: const Text('¿Estás seguro de que deseas cancelar esta venta?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Limpiar la lista de artículos
              setState(() {
                _articulosVenta.clear();
              });
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Sí, Cancelar'),
          ),
        ],
      ),
    );
  }

  // Lista de productos de ejemplo para mostrar en el catálogo
  final List<Producto> _productosEjemplo = [
    Producto(
      nombre: 'Coca Cola',
      presentacion: 'Botella 2L',
      precio: 38.50,
    ),
    Producto(
      nombre: 'Leche Alpura',
      presentacion: 'Cartón 1L',
      precio: 26.80,
    ),
    Producto(
      nombre: 'Frijoles La Costeña',
      presentacion: 'Lata 580g',
      precio: 18.90,
    ),
    Producto(
      nombre: 'Arroz SOS',
      presentacion: 'Bolsa 1Kg',
      precio: 32.30,
    ),
    Producto(
      nombre: 'Papel Higiénico Petalo',
      presentacion: 'Paquete 4 rollos',
      precio: 45.40,
    ),
    Producto(
      nombre: 'Aceite 1-2-3',
      presentacion: 'Botella 1L',
      precio: 42.20,
    ),
    Producto(
      nombre: 'Maseca',
      presentacion: 'Paquete 1Kg',
      precio: 21.60,
    ),
    Producto(
      nombre: 'Huevo Bachoco',
      presentacion: 'Cartón 18 piezas',
      precio: 85.50,
    ),
    Producto(
      nombre: 'Jamón FUD',
      presentacion: 'Paquete 250g',
      precio: 38.90,
    ),
    Producto(
      nombre: 'Sabritas Clásicas',
      presentacion: 'Bolsa 240g',
      precio: 52.50,
    ),
    Producto(
      nombre: 'Tortillas de harina Tía Rosa',
      presentacion: 'Paquete 10 piezas',
      precio: 24.90,
    ),
    Producto(
      nombre: 'Pan Bimbo',
      presentacion: 'Bolsa grande',
      precio: 48.50,
    ),
  ];
}

// Clase para representar un producto del catálogo
class Producto {
  final String nombre;
  final String presentacion;
  final double precio;

  Producto({
    required this.nombre,
    required this.presentacion,
    required this.precio,
  });
}

// Clase para representar un artículo agregado a la venta
class ArticuloVenta {
  final String nombre;
  final String presentacion;
  final double precio;

  ArticuloVenta({
    required this.nombre,
    required this.presentacion,
    required this.precio,
  });
}