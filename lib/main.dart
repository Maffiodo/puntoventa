import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'views/login_view.dart';
import 'views/menu_view.dart';
import 'views/punto_venta_view.dart';
import 'views/inventario_view.dart';
import 'viewmodels/login_view_model.dart';  // Corregido: viewmodels en lugar de view_model
import 'viewmodels/inventario_viewmodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => InventarioViewModel()),
      ],
      child: MaterialApp(
        title: 'Punto de Venta',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF1E4D8C),
            primary: const Color(0xFF1E4D8C),
          ),
          useMaterial3: true,
        ),
        initialRoute: '/login',
        routes: {
          '/login': (context) => const LoginView(),
          '/menu': (context) => const MenuView(),
          '/punto_venta': (context) => const PuntoVentaView(),
          '/inventario': (context) => const InventarioView(),
          // Las siguientes rutas serán implementadas más adelante
          '/reportes': (context) => const Placeholder(),
          '/configuracion': (context) => const Placeholder(),
        },
      ),
    );
  }
}