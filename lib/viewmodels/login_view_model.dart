import 'package:flutter/foundation.dart';

class Usuario {
  final String nombre;
  final String password;

  Usuario({required this.nombre, required this.password});
}

class LoginViewModel extends ChangeNotifier {
  bool _isLoading = false;
  String _errorMessage = '';

  // Lista de usuarios permitidos
  final List<Usuario> _usuariosAutorizados = [
    Usuario(nombre: 'jorge', password: 'jorge123'),
    Usuario(nombre: 'carlos', password: 'carlos123'),
    Usuario(nombre: 'erick', password: 'erick123'),
    Usuario(nombre: 'raquel', password: 'raquel123'),
  ];

  // Getters
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Método para iniciar sesión
  Future<bool> login(String usuario, String password) async {
    if (usuario.isEmpty || password.isEmpty) {
      _errorMessage = 'Por favor completa todos los campos';
      notifyListeners();
      return false;
    }

    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      // Simulamos un delay para la petición
      await Future.delayed(const Duration(seconds: 1));

      // Verificar si el usuario existe y la contraseña es correcta
      final usuarioValido = _usuariosAutorizados.any(
              (u) => u.nombre.toLowerCase() == usuario.toLowerCase() &&
              u.password == password
      );

      if (usuarioValido) {
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = 'Usuario o contraseña incorrectos';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'Error al iniciar sesión: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Método para limpiar el estado
  void reset() {
    _isLoading = false;
    _errorMessage = '';
    notifyListeners();
  }
}