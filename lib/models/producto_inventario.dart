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