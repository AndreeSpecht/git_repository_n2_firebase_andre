import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/presentController.dart';
import 'editPage.dart';

// Página inicial com design moderno para lista de compras
class HomePage extends StatelessWidget {
  final PresentController presentController = Get.put(PresentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lista de Compras',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade100, Colors.green.shade50],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Obx(() {
          if (presentController.presents.isEmpty) {
            return Center(
              child: Text(
                'Nenhum item encontrado. Adicione um novo item à lista!',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey.shade700,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }
          return ListView.builder(
            itemCount: presentController.presents.length,
            itemBuilder: (context, index) {
              final present = presentController.presents[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                elevation: 3,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: present.isGiven
                        ? Colors.green.shade300
                        : Colors.red.shade300,
                    child: Icon(
                      present.isGiven ? Icons.check : Icons.shopping_cart,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    present.description,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    present.isGiven
                        ? 'Comprado'
                        : 'Pendente',
                    style: TextStyle(
                      color: present.isGiven
                          ? Colors.green.shade700
                          : Colors.red.shade700,
                    ),
                  ),
                  trailing: PopupMenuButton(
                    onSelected: (value) {
                      if (value == 'edit') {
                        Get.to(() => EditPage(present: present));
                      } else if (value == 'delete') {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Confirmar'),
                              content: const Text(
                                  'Você tem certeza que deseja excluir este item?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text('Não'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    presentController.deletePresent(present.id);
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Sim'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'edit',
                        child: Text('Editar'),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Text('Excluir'),
                      ),
                    ],
                  ),
                  onTap: () => Get.to(() => EditPage(present: present)),
                ),
              );
            },
          );
        }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => EditPage(present: null)),
        backgroundColor: Colors.green,
        child: const Icon(Icons.shopping_cart, color: Colors.white),
      ),
    );
  }
}