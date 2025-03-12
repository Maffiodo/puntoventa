import 'package:flutter/material.dart';

class InventarioView extends StatefulWidget {
  const InventarioView({super.key});

  @override
  State<InventarioView> createState() => _InventarioViewState();
}

// Modelo de datos para productos del inventario integrado en la vista
class ProductoInventario {
  String id;
  String nombre;
  String categoria;
  String presentacion;
  double precio;
  int existencias;
  int stock_minimo;

  ProductoInventario({
    required this.id,
    required this.nombre,
    required this.categoria,
    required this.presentacion,
    required this.precio,
    required this.existencias,
    required this.stock_minimo,
  });

  // Método para crear una copia de un producto
  ProductoInventario copyWith({
    String? id,
    String? nombre,
    String? categoria,
    String? presentacion,
    double? precio,
    int? existencias,
    int? stock_minimo,
  }) {
    return ProductoInventario(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      categoria: categoria ?? this.categoria,
      presentacion: presentacion ?? this.presentacion,
      precio: precio ?? this.precio,
      existencias: existencias ?? this.existencias,
      stock_minimo: stock_minimo ?? this.stock_minimo,
    );
  }
}

class _InventarioViewState extends State<InventarioView> {
  // Color principal de la aplicación
  final Color azulPrimario = const Color(0xFF1E4D8C);

  // Lista de productos de inventario
  List<ProductoInventario> _productos = [];

  // Lista filtrada que se mostrará en la UI
  List<ProductoInventario> _productosFiltrados = [];

  // Controlador para búsqueda
  final TextEditingController _searchController = TextEditingController();

  // Variable para almacenar la categoría seleccionada
  String _categoriaSeleccionada = 'Todas';

  // Lista de categorías disponibles
  final List<String> _categorias = [
    'Todas',
    'Bebidas',
    'Lácteos',
    'Abarrotes',
    'Enlatados',
    'Higiene',
    'Snacks',
    'Panadería',
  ];//wdiuhnwidoiwdd

  // Controladores para el formulario
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _presentacionController = TextEditingController();
  final TextEditingController _precioController = TextEditingController();
  final TextEditingController _existenciasController = TextEditingController();
  final TextEditingController _stockMinimoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cargarDatosIniciales();
    _searchController.addListener(_filtrarProductos);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filtrarProductos);
    _searchController.dispose();
    _nombreController.dispose();
    _presentacionController.dispose();
    _precioController.dispose();
    _existenciasController.dispose();
    _stockMinimoController.dispose();
    super.dispose();
  }

  // Método para cargar datos iniciales (simulación)
  void _cargarDatosIniciales() {
    _productos = [
      ProductoInventario(
        id: '001',
        nombre: 'Coca Cola',
        categoria: 'Bebidas',
        presentacion: 'Botella 2L',
        precio: 38.50,
        existencias: 24,
        stock_minimo: 10,
      ),
      ProductoInventario(
        id: '002',
        nombre: 'Leche Alpura',
        categoria: 'Lácteos',
        presentacion: 'Cartón 1L',
        precio: 26.80,
        existencias: 15,
        stock_minimo: 12,
      ),
      ProductoInventario(
        id: '003',
        nombre: 'Frijoles La Costeña',
        categoria: 'Enlatados',
        presentacion: 'Lata 580g',
        precio: 18.90,
        existencias: 32,
        stock_minimo: 15,
      ),
      ProductoInventario(
        id: '004',
        nombre: 'Arroz SOS',
        categoria: 'Abarrotes',
        presentacion: 'Bolsa 1Kg',
        precio: 32.30,
        existencias: 18,
        stock_minimo: 8,
      ),
      ProductoInventario(
        id: '005',
        nombre: 'Papel Higiénico Petalo',
        categoria: 'Higiene',
        presentacion: 'Paquete 4 rollos',
        precio: 45.40,
        existencias: 10,
        stock_minimo: 5,
      ),
      ProductoInventario(
        id: '006',
        nombre: 'Aceite 1-2-3',
        categoria: 'Abarrotes',
        presentacion: 'Botella 1L',
        precio: 42.20,
        existencias: 14,
        stock_minimo: 6,
      ),
      ProductoInventario(
        id: '007',
        nombre: 'Maseca',
        categoria: 'Abarrotes',
        presentacion: 'Paquete 1Kg',
        precio: 21.60,
        existencias: 20,
        stock_minimo: 10,
      ),
      ProductoInventario(
        id: '008',
        nombre: 'Huevo Bachoco',
        categoria: 'Lácteos',
        presentacion: 'Cartón 18 piezas',
        precio: 85.50,
        existencias: 8,
        stock_minimo: 5,
      ),
      ProductoInventario(
        id: '009',
        nombre: 'Jamón FUD',
        categoria: 'Lácteos',
        presentacion: 'Paquete 250g',
        precio: 38.90,
        existencias: 12,
        stock_minimo: 6,
      ),
      ProductoInventario(
        id: '010',
        nombre: 'Sabritas Clásicas',
        categoria: 'Snacks',
        presentacion: 'Bolsa 240g',
        precio: 52.50,
        existencias: 25,
        stock_minimo: 10,
      ),
      ProductoInventario(
        id: '011',
        nombre: 'Tortillas de harina Tía Rosa',
        categoria: 'Panadería',
        presentacion: 'Paquete 10 piezas',
        precio: 24.90,
        existencias: 18,
        stock_minimo: 8,
      ),
      ProductoInventario(
        id: '012',
        nombre: 'Pan Bimbo',
        categoria: 'Panadería',
        presentacion: 'Bolsa grande',
        precio: 48.50,
        existencias: 15,
        stock_minimo: 6,
      ),
    ];
    _productosFiltrados = List.from(_productos);
  }

  // OPERACIONES CRUD

  // CREATE: Agregar un nuevo producto
  Future<bool> _agregarProducto(ProductoInventario producto) async {
    try {
      // Verificar si ya existe un producto con ese ID
      if (_productos.any((p) => p.id == producto.id)) {
        return false; // ID duplicado
      }

      // Agregar el producto
      setState(() {
        _productos.add(producto);
        _filtrarProductos(); // Actualizar lista filtrada
      });
      return true;
    } catch (e) {
      print('Error al agregar producto: $e');
      return false;
    }
  }

  // UPDATE: Actualizar un producto existente
  Future<bool> _actualizarProducto(ProductoInventario producto) async {
    try {
      final index = _productos.indexWhere((p) => p.id == producto.id);
      if (index >= 0) {
        setState(() {
          _productos[index] = producto;
          _filtrarProductos(); // Actualizar lista filtrada
        });
        return true;
      }
      return false; // No se encontró el producto para actualizar
    } catch (e) {
      print('Error al actualizar producto: $e');
      return false;
    }
  }

  // DELETE: Eliminar un producto
  Future<bool> _eliminarProducto(String id) async {
    try {
      final removedCount = _productos.where((p) => p.id == id).length;
      setState(() {
        _productos.removeWhere((p) => p.id == id);
        _filtrarProductos(); // Actualizar lista filtrada
      });
      return removedCount > 0;
    } catch (e) {
      print('Error al eliminar producto: $e');
      return false;
    }
  }

  // BÚSQUEDA Y FILTRADO

  // Método para filtrar productos según búsqueda y categoría
  void _filtrarProductos() {
    final String query = _searchController.text.toLowerCase();
    setState(() {
      _productosFiltrados = _productos.where((producto) {
        final bool matchesQuery = query.isEmpty ||
            producto.nombre.toLowerCase().contains(query) ||
            producto.id.toLowerCase().contains(query);
        final bool matchesCategory = _categoriaSeleccionada == 'Todas' ||
            producto.categoria == _categoriaSeleccionada;
        return matchesQuery && matchesCategory;
      }).toList();
    });
  }

  // Método para cambiar la categoría seleccionada
  void _cambiarCategoria(String categoria) {
    setState(() {
      _categoriaSeleccionada = categoria;
    });
    _filtrarProductos();
  }

  // INVENTARIO Y STOCK

  // Verificar productos con stock bajo
  List<ProductoInventario> _obtenerProductosStockBajo() {
    return _productos.where((p) => p.existencias <= p.stock_minimo).toList();
  }

  // Generar un nuevo ID para productos
  String _generarNuevoId() {
    // Encontrar el valor numérico más alto en los IDs actuales
    int maxId = 0;
    for (var producto in _productos) {
      try {
        final numericId = int.parse(producto.id);
        if (numericId > maxId) {
          maxId = numericId;
        }
      } catch (e) {
        // Ignorar IDs que no sean numéricos
      }
    }

    // Generar un nuevo ID incrementando en 1 y formateando con ceros a la izquierda
    return (maxId + 1).toString().padLeft(3, '0');
  }

  // Validar datos de producto
  String? _validarProducto(ProductoInventario producto) {
    if (producto.nombre.isEmpty) {
      return 'El nombre del producto es obligatorio';
    }
    if (producto.categoria.isEmpty) {
      return 'La categoría es obligatoria';
    }
    if (producto.presentacion.isEmpty) {
      return 'La presentación es obligatoria';
    }
    if (producto.precio <= 0) {
      return 'El precio debe ser mayor a cero';
    }
    if (producto.existencias < 0) {
      return 'Las existencias no pueden ser negativas';
    }
    if (producto.stock_minimo < 0) {
      return 'El stock mínimo no puede ser negativo';
    }
    return null; // No hay errores
  }

  @override
  Widget build(BuildContext context) {
    final productosStockBajo = _obtenerProductosStockBajo();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: azulPrimario,
        title: const Text(
          'Inventario',
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
          // Indicador de productos con stock bajo
          Badge(
            backgroundColor: Colors.red,
            isLabelVisible: productosStockBajo.isNotEmpty,
            label: Text(
              '${productosStockBajo.length}',
              style: const TextStyle(color: Colors.white),
            ),
            child: IconButton(
              icon: const Icon(Icons.warning_amber_rounded, color: Colors.white),
              onPressed: () => _mostrarProductosStockBajo(),
            ),
          ),
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
      body: Column(
        children: [
          // Barra de búsqueda y filtros
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey[100],
            child: Column(
              children: [
                // Barra de búsqueda
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Buscar producto por nombre o ID...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  ),
                ),
                const SizedBox(height: 16),

                // Filtro por categorías
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _categorias.map((categoria) {
                      final bool isSelected = _categoriaSeleccionada == categoria;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ChoiceChip(
                          label: Text(categoria),
                          selected: isSelected,
                          selectedColor: azulPrimario,
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                          onSelected: (selected) {
                            if (selected) {
                              _cambiarCategoria(categoria);
                            }
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),

          // Encabezados de la tabla
          Container(
            color: azulPrimario,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: const Row(
              children: [
                SizedBox(width: 60, child: Text('ID', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))),
                Expanded(flex: 2, child: Text('Producto', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))),
                Expanded(flex: 1, child: Text('Categoría', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))),
                SizedBox(width: 70, child: Text('Precio', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))),
                SizedBox(width: 70, child: Text('Stock', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))),
                SizedBox(width: 80, child: Text('Acciones', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))),
              ],
            ),
          ),

          // Lista de productos
          Expanded(
            child: _productosFiltrados.isEmpty
                ? Center(
              child: Text(
                'No se encontraron productos',
                style: TextStyle(color: Colors.grey[600]),
              ),
            )
                : ListView.builder(
              itemCount: _productosFiltrados.length,
              itemBuilder: (context, index) {
                final producto = _productosFiltrados[index];
                // Color de fondo alternado para las filas
                final Color backgroundColor = index % 2 == 0 ? Colors.white : Colors.grey[50]!;
                // Color para stock bajo
                final bool stockBajo = producto.existencias <= producto.stock_minimo;
                final Color stockColor = stockBajo ? Colors.red : Colors.black;

                return Container(
                  color: backgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Row(
                      children: [
                        // ID
                        SizedBox(
                          width: 60,
                          child: Text(
                            producto.id,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),

                        // Nombre y presentación
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                producto.nombre,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                producto.presentacion,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Categoría
                        Expanded(
                          flex: 1,
                          child: Text(producto.categoria),
                        ),

                        // Precio
                        SizedBox(
                          width: 70,
                          child: Text(
                            '\$${producto.precio.toStringAsFixed(2)}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),

                        // Stock
                        SizedBox(
                          width: 70,
                          child: Text(
                            '${producto.existencias}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: stockColor,
                            ),
                          ),
                        ),

                        // Botones de acción
                        SizedBox(
                          width: 80,
                          child: Row(
                            children: [
                              // Editar
                              IconButton(
                                icon: Icon(Icons.edit, color: azulPrimario, size: 20),
                                constraints: const BoxConstraints(),
                                padding: EdgeInsets.zero,
                                onPressed: () => _editarProducto(context, producto),
                              ),
                              // Eliminar
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                                constraints: const BoxConstraints(),
                                padding: EdgeInsets.zero,
                                onPressed: () => _confirmarEliminar(context, producto),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: azulPrimario,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () => _agregarNuevoProducto(context),
      ),
    );
  }

  // Método para mostrar productos con stock bajo
  void _mostrarProductosStockBajo() {
    final productosStockBajo = _obtenerProductosStockBajo();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Productos con Stock Bajo'),
        content: SizedBox(
          width: double.maxFinite,
          child: productosStockBajo.isEmpty
              ? const Text('No hay productos con stock bajo.')
              : ListView.builder(
            shrinkWrap: true,
            itemCount: productosStockBajo.length,
            itemBuilder: (context, index) {
              final producto = productosStockBajo[index];
              return ListTile(
                title: Text(producto.nombre),
                subtitle: Text('${producto.existencias} en stock (mínimo: ${producto.stock_minimo})'),
                leading: const Icon(Icons.warning, color: Colors.red),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  // Método para editar un producto
  void _editarProducto(BuildContext context, ProductoInventario producto) {
    // Llenar los controladores con los datos del producto
    _nombreController.text = producto.nombre;
    _presentacionController.text = producto.presentacion;
    _precioController.text = producto.precio.toString();
    _existenciasController.text = producto.existencias.toString();
    _stockMinimoController.text = producto.stock_minimo.toString();

    String categoriaSeleccionada = producto.categoria;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text('Editar ${producto.nombre}'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ID (no editable)
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'ID',
                    enabled: false,
                  ),
                  controller: TextEditingController(text: producto.id),
                ),
                const SizedBox(height: 8),

                // Nombre
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Nombre *',
                  ),
                  controller: _nombreController,
                ),
                const SizedBox(height: 8),

                // Categoría
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Categoría *',
                  ),
                  value: categoriaSeleccionada,
                  items: _categorias
                      .where((c) => c != 'Todas') // Excluir "Todas" de las opciones
                      .map((String categoria) {
                    return DropdownMenuItem<String>(
                      value: categoria,
                      child: Text(categoria),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        categoriaSeleccionada = newValue;
                      });
                    }
                  },
                ),
                const SizedBox(height: 8),

                // Presentación
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Presentación *',
                  ),
                  controller: _presentacionController,
                ),
                const SizedBox(height: 8),

                // Precio
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Precio *',
                    prefixText: '\$',
                  ),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  controller: _precioController,
                ),
                const SizedBox(height: 8),

                // Existencias
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Existencias *',
                  ),
                  keyboardType: TextInputType.number,
                  controller: _existenciasController,
                ),
                const SizedBox(height: 8),

                // Stock mínimo
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Stock Mínimo *',
                  ),
                  keyboardType: TextInputType.number,
                  controller: _stockMinimoController,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                // Crear objeto producto actualizado
                final productoActualizado = producto.copyWith(
                  nombre: _nombreController.text,
                  categoria: categoriaSeleccionada,
                  presentacion: _presentacionController.text,
                  precio: double.tryParse(_precioController.text) ?? producto.precio,
                  existencias: int.tryParse(_existenciasController.text) ?? producto.existencias,
                  stock_minimo: int.tryParse(_stockMinimoController.text) ?? producto.stock_minimo,
                );

                // Validar producto
                final error = _validarProducto(productoActualizado);
                if (error != null) {
                  // Mostrar error
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(error),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                // Actualizar producto
                final success = await _actualizarProducto(productoActualizado);

                if (context.mounted) {
                  Navigator.of(context).pop();

                  // Mostrar mensaje de confirmación
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(success
                          ? '${productoActualizado.nombre} actualizado correctamente'
                          : 'Error al actualizar el producto'),
                      backgroundColor: success ? azulPrimario : Colors.red,
                    ),
                  );
                }
              },
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }

  // Método para confirmar eliminación
  void _confirmarEliminar(BuildContext context, ProductoInventario producto) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar eliminación'),
        content: Text('¿Estás seguro de que deseas eliminar "${producto.nombre}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              // Eliminar producto
              final success = await _eliminarProducto(producto.id);

              if (context.mounted) {
                Navigator.of(context).pop();

                // Mostrar mensaje de confirmación
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(success
                        ? '${producto.nombre} eliminado del inventario'
                        : 'Error al eliminar el producto'),
                    backgroundColor: success ? azulPrimario : Colors.red,
                  ),
                );
              }
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  // Método para agregar un nuevo producto
  void _agregarNuevoProducto(BuildContext context) {
    // Limpiar los controladores
    _nombreController.clear();
    _presentacionController.clear();
    _precioController.clear();
    _existenciasController.clear();
    _stockMinimoController.clear();

    final nuevoId = _generarNuevoId();
    String categoriaSeleccionada = _categorias[1]; // Primera categoría después de "Todas"

    showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
      title: const Text('Agregar Nuevo Producto'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
        // ID (no editable)
        TextField(
        decoration: const InputDecoration(
        labelText: 'ID',
          enabled: false,
        ),
        controller: TextEditingController(text: nuevoId),
      ),
      const SizedBox(height: 8),

      // Nombre
      TextField(
        decoration: const InputDecoration(
          labelText: 'Nombre *',
        ),
        controller: _nombreController,
      ),
      const SizedBox(height: 8),

      // Categoría
      DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          labelText: 'Categoría *',
        ),
        value: categoriaSeleccionada,
        items: _categorias
            .where((c) => c != 'Todas') // Excluir "Todas" de las opciones
            .map((String categoria) {
          return DropdownMenuItem<String>(
            value: categoria,
            child: Text(categoria),
          );
        }).toList(),
        onChanged: (String? newValue) {
          if (newValue != null) {
            setState(() {
              categoriaSeleccionada = newValue;
            });
          }
        },
      ),
      const SizedBox(height: 8),

      // Presentación
      TextField(
        decoration: const InputDecoration(
          labelText: 'Presentación *',
        ),
        controller: _presentacionController,
      ),
      const SizedBox(height: 8),

      // Precio
      TextField(
        decoration: const InputDecoration(
          labelText: 'Precio *',
          prefixText: '\$',
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        controller: _precioController,
      ),
      const SizedBox(height: 8),

      // Existencias
      TextField(
        decoration: const InputDecoration(
          labelText: 'Existencias *',
        ),
        keyboardType: TextInputType.number,
        controller: _existenciasController,
      ),
      const SizedBox(height: 8),

      // Stock mínimo
      TextField(
      decoration: const InputDecoration(
      labelText: 'Stock Mínimo *',
    ),
    keyboardType: TextInputType.number,
        controller: _stockMinimoController,
      ),
          ],
        ),
      ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                try {
                  // Crear objeto producto nuevo
                  final nuevoProducto = ProductoInventario(
                    id: nuevoId,
                    nombre: _nombreController.text,
                    categoria: categoriaSeleccionada,
                    presentacion: _presentacionController.text,
                    precio: double.tryParse(_precioController.text) ?? 0.0,
                    existencias: int.tryParse(_existenciasController.text) ?? 0,
                    stock_minimo: int.tryParse(_stockMinimoController.text) ?? 0,
                  );

                  // Validar producto
                  final error = _validarProducto(nuevoProducto);
                  if (error != null) {
                    // Mostrar error
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(error),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  // Agregar producto
                  final success = await _agregarProducto(nuevoProducto);

                  if (context.mounted) {
                    Navigator.of(context).pop();

                    // Mostrar mensaje de confirmación
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(success
                            ? '${nuevoProducto.nombre} agregado al inventario'
                            : 'Error al agregar el producto'),
                        backgroundColor: success ? azulPrimario : Colors.red,
                      ),
                    );
                  }
                } catch (e) {
                  print('Error al crear el producto: $e');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Error al crear el producto'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const Text('Guardar'),
            ),
          ],
        ),
        ),
    );
  }
}