import 'package:flutter/material.dart';

// Modelo de datos para productos del inventario
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

  // Método para convertir de Map a ProductoInventario (útil para bases de datos)
  factory ProductoInventario.fromMap(Map<String, dynamic> map) {
    return ProductoInventario(
      id: map['id'],
      nombre: map['nombre'],
      categoria: map['categoria'],
      presentacion: map['presentacion'],
      precio: map['precio'],
      existencias: map['existencias'],
      stock_minimo: map['stock_minimo'],
    );
  }

  // Método para convertir de ProductoInventario a Map (útil para bases de datos)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'categoria': categoria,
      'presentacion': presentacion,
      'precio': precio,
      'existencias': existencias,
      'stock_minimo': stock_minimo,
    };
  }
}

class InventarioViewModel extends ChangeNotifier {
  // Lista de productos
  List<ProductoInventario> _productos = [];

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
  ];

  // Getters
  List<ProductoInventario> get productos => _productos;
  List<String> get categorias => _categorias;

  // Constructor que inicializa con datos de ejemplo
  InventarioViewModel() {
    _cargarDatosIniciales();
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
    notifyListeners();
  }

  // OPERACIONES CRUD

  // CREATE: Agregar un nuevo producto
  Future<bool> agregarProducto(ProductoInventario producto) async {
    try {
      // Verificar si ya existe un producto con ese ID
      if (_productos.any((p) => p.id == producto.id)) {
        return false; // ID duplicado
      }

      // Agregar el producto
      _productos.add(producto);
      notifyListeners();
      return true;
    } catch (e) {
      print('Error al agregar producto: $e');
      return false;
    }
  }

  // READ: Obtener un producto por ID
  ProductoInventario? obtenerProductoPorId(String id) {
    try {
      return _productos.firstWhere((p) => p.id == id);
    } catch (e) {
      return null; // No se encontró el producto
    }
  }

  // UPDATE: Actualizar un producto existente
  Future<bool> actualizarProducto(ProductoInventario producto) async {
    try {
      final index = _productos.indexWhere((p) => p.id == producto.id);
      if (index >= 0) {
        _productos[index] = producto;
        notifyListeners();
        return true;
      }
      return false; // No se encontró el producto para actualizar
    } catch (e) {
      print('Error al actualizar producto: $e');
      return false;
    }
  }

  // DELETE: Eliminar un producto
  Future<bool> eliminarProducto(String id) async {
    try {
      final removedCount = _productos.where((p) => p.id == id).length;
      _productos.removeWhere((p) => p.id == id);
      if (removedCount > 0) {
        notifyListeners();
        return true;
      }
      return false; // No se eliminó ningún producto
    } catch (e) {
      print('Error al eliminar producto: $e');
      return false;
    }
  }

  // BÚSQUEDA Y FILTRADO

  // Filtrar productos por texto y categoría
  List<ProductoInventario> filtrarProductos({
    required String query,
    required String categoria,
  }) {
    return _productos.where((producto) {
      // Filtro por texto (nombre o ID)
      final bool matchesQuery = query.isEmpty ||
          producto.nombre.toLowerCase().contains(query.toLowerCase()) ||
          producto.id.toLowerCase().contains(query.toLowerCase());

      // Filtro por categoría
      final bool matchesCategory = categoria == 'Todas' ||
          producto.categoria == categoria;

      return matchesQuery && matchesCategory;
    }).toList();
  }

  // INVENTARIO Y STOCK

  // Verificar productos con stock bajo
  List<ProductoInventario> obtenerProductosStockBajo() {
    return _productos.where((p) => p.existencias <= p.stock_minimo).toList();
  }

  // Actualizar existencias de un producto
  Future<bool> actualizarExistencias(String id, int nuevaCantidad) async {
    try {
      final index = _productos.indexWhere((p) => p.id == id);
      if (index >= 0) {
        _productos[index].existencias = nuevaCantidad;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print('Error al actualizar existencias: $e');
      return false;
    }
  }

  // Generar un nuevo ID para productos
  String generarNuevoId() {
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
  String? validarProducto(ProductoInventario producto) {
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
}