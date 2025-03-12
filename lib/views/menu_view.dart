import 'package:flutter/material.dart';

class MenuView extends StatelessWidget {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    // Colores de la aplicación
    final Color azulPrimario = const Color(0xFF1E4D8C); // #1E4D8C
    final Color azulFondo = const Color(0xFFEBF2FE);    // Fondo claro
    final Color azulOscuro = const Color(0xFF004689);   // Azul para botones #004689

    // Colores personalizados para los botones en degradado de oscuro a claro
    final Color colorPuntoVenta = const Color(0xFF0F2D5A); // Azul muy oscuro
    final Color colorInventario = const Color(0xFF27518D); // Azul oscuro
    final Color colorReportes = const Color(0xFF3A7CC7);   // Azul medio
    final Color colorConfiguracion = const Color(0xFF64A0E3); // Azul claro

    return Scaffold(
      backgroundColor: azulFondo,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // Espacio superior para separar del borde
                const SizedBox(height: 20),

                // Banner de imagen
                Container(
                  height: 200, // Altura más pequeña para el banner
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 16), // Márgenes horizontales
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8), // Bordes redondeados
                    child: Image.asset(
                      'assets/images/banner.png',
                      fit: BoxFit.cover, // Cubre el espacio disponible
                    ),
                  ),
                ),

                // Espacio entre el banner y los botones
                const SizedBox(height: 30),

                // Botones del menú apilados verticalmente
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        // Hacemos que el ancho sea responsivo: 80% del ancho disponible
                        final buttonWidth = constraints.maxWidth * 0.8;

                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                            _buildMenuButton(
                            context,
                            'Punto de Venta',
                            Icons.point_of_sale,
                            '/punto_venta',  // Esta es la ruta que conecta con PuntoVentaView
                            colorPuntoVenta,
                            Colors.white,
                            buttonWidth,
                          ),
                              const SizedBox(height: 16),
                              _buildMenuButton(
                                context,
                                'Inventario',
                                Icons.inventory,
                                '/inventario',
                                colorInventario,
                                Colors.white,
                                buttonWidth,
                              ),
                              const SizedBox(height: 16),
                              _buildMenuButton(
                                context,
                                'Reportes',
                                Icons.bar_chart,
                                '/reportes',
                                colorReportes,
                                Colors.white,
                                buttonWidth,
                              ),
                              const SizedBox(height: 16),
                              _buildMenuButton(
                                context,
                                'Configuración',
                                Icons.settings,
                                '/configuracion',
                                colorConfiguracion,
                                Colors.white,
                                buttonWidth,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            // Botón de cierre de sesión en la esquina superior derecha
            Positioned(
              top: 10,
              right: 16,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.logout,
                    color: azulOscuro,
                    size: 28,
                  ),
                  onPressed: () {
                    // Volver a la pantalla de login
                    Navigator.of(context).pushReplacementNamed('/login');
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(
      BuildContext context,
      String title,
      IconData icon,
      String route,
      Color backgroundColor,
      Color textColor,
      double width,
      ) {
    return SizedBox(
      width: width,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushNamed(route);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 24,
              color: textColor,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}