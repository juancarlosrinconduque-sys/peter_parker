import 'package:flutter/material.dart';

void main() {
  runApp(const MiAplicacion());
}

class MiAplicacion extends StatelessWidget {
  const MiAplicacion({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplicación con 3 Menús',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PaginaPrincipal(),
    );
  }
}

class PaginaPrincipal extends StatefulWidget {
  const PaginaPrincipal({super.key});

  @override
  State<PaginaPrincipal> createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal> {
  int paginaSeleccionada = 0;

  final List<String> titulos = ['Inicio', 'Explorar', 'Perfil'];

  final List<IconData> iconos = [Icons.home, Icons.explore, Icons.person];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // =========================================================
      // 1. DRAWER - MENÚ LATERAL
      // =========================================================
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple, Colors.purpleAccent],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.flutter_dash,
                      size: 40,
                      color: Colors.deepPurple,
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(
                    'Mi Aplicación',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text('Menú lateral', style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),

            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Inicio'),
              onTap: () {
                setState(() {
                  paginaSeleccionada = 0;
                });

                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.explore),
              title: const Text('Explorar'),
              onTap: () {
                setState(() {
                  paginaSeleccionada = 1;
                });

                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Perfil'),
              onTap: () {
                setState(() {
                  paginaSeleccionada = 2;
                });

                Navigator.pop(context);
              },
            ),

            const Divider(),

            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configuración'),
              onTap: () {
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Configuración seleccionada')),
                );
              },
            ),
          ],
        ),
      ),

      // =========================================================
      // BARRA SUPERIOR
      // =========================================================
      appBar: AppBar(
        title: Text(
          titulos[paginaSeleccionada],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),

        // =======================================================
        // 2. POPUP MENU - MENÚ DE TRES PUNTOS
        // =======================================================
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),

            onSelected: (String opcion) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Seleccionaste: $opcion')));
            },

            itemBuilder: (BuildContext context) {
              return const [
                PopupMenuItem(
                  value: 'Editar',
                  child: Row(
                    children: [
                      Icon(Icons.edit),
                      SizedBox(width: 10),
                      Text('Editar'),
                    ],
                  ),
                ),

                PopupMenuItem(
                  value: 'Compartir',
                  child: Row(
                    children: [
                      Icon(Icons.share),
                      SizedBox(width: 10),
                      Text('Compartir'),
                    ],
                  ),
                ),

                PopupMenuItem(
                  value: 'Configuración',
                  child: Row(
                    children: [
                      Icon(Icons.settings),
                      SizedBox(width: 10),
                      Text('Configuración'),
                    ],
                  ),
                ),
              ];
            },
          ),
        ],
      ),

      // =========================================================
      // CONTENIDO PRINCIPAL
      // =========================================================
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 55,
              backgroundColor: Colors.deepPurple.shade100,
              child: Icon(
                iconos[paginaSeleccionada],
                size: 65,
                color: Colors.deepPurple,
              ),
            ),

            const SizedBox(height: 25),

            Text(
              titulos[paginaSeleccionada],
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            const Text(
              'Aplicación con 3 tipos de menú',
              style: TextStyle(fontSize: 17, color: Colors.grey),
            ),

            const SizedBox(height: 30),

            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('¡Botón presionado correctamente!'),
                  ),
                );
              },
              icon: const Icon(Icons.touch_app),
              label: const Text('Presionar'),
            ),
          ],
        ),
      ),

      // =========================================================
      // 3. BOTTOM NAVIGATION BAR - MENÚ INFERIOR
      // =========================================================
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: paginaSeleccionada,

        onTap: (int index) {
          setState(() {
            paginaSeleccionada = index;
          });
        },

        type: BottomNavigationBarType.fixed,

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),

          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explorar'),

          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}
