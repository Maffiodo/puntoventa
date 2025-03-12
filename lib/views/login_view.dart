import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/login_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _usuarioController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;

  // Colores personalizados
  final Color azulPrimario = const Color(0xFF1E4D8C);
  final Color azulFondo = const Color(0xFFEBF2FE);

  @override
  void dispose() {
    _usuarioController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login(LoginViewModel viewModel) async {
    if (_formKey.currentState!.validate()) {
      // Usar el ViewModel para manejar el login
      final success = await viewModel.login(
        _usuarioController.text,
        _passwordController.text,
      );

      if (success && mounted) {
        // Navegar a la pantalla de menú
        Navigator.of(context).pushReplacementNamed('/menu');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: azulFondo,
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: 320, // Ancho fijo más estrecho
                child: Card(
                  elevation: 3, // Elevación reducida
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Icono dentro de la card
                          Icon(
                            Icons.storefront,
                            size: 80,
                            color: azulPrimario,
                          ),
                          const SizedBox(height: 20),

                          Text(
                            'Inicio de Sesión',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: azulPrimario,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),

                          // Mostrar mensaje de error si existe
                          if (viewModel.errorMessage.isNotEmpty)
                            Container(
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsets.only(bottom: 16),
                              decoration: BoxDecoration(
                                color: Colors.red.shade50,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.red.shade200),
                              ),
                              child: Text(
                                viewModel.errorMessage,
                                style: TextStyle(color: Colors.red.shade700),
                                textAlign: TextAlign.center,
                              ),
                            ),

                          // Campo de usuario
                          TextFormField(
                            controller: _usuarioController,
                            decoration: InputDecoration(
                              labelText: 'Usuario',
                              labelStyle: TextStyle(color: azulPrimario.withOpacity(0.7)),
                              prefixIcon: Icon(Icons.person, color: azulPrimario),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: azulPrimario),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: azulPrimario, width: 2),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingresa tu usuario';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // Campo de contraseña
                          TextFormField(
                            controller: _passwordController,
                            obscureText: _obscureText,
                            decoration: InputDecoration(
                              labelText: 'Contraseña',
                              labelStyle: TextStyle(color: azulPrimario.withOpacity(0.7)),
                              prefixIcon: Icon(Icons.lock, color: azulPrimario),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: azulPrimario,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: azulPrimario),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: azulPrimario, width: 2),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingresa tu contraseña';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 24),

                          // Botón de inicio de sesión
                          SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              onPressed: viewModel.isLoading
                                  ? null
                                  : () => _login(viewModel),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: azulPrimario,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: viewModel.isLoading
                                  ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                                  : const Text(
                                'INGRESAR',
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
              ),
            ),
          ),
        );
      },
    );
  }
}