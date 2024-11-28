import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/presentController.dart';
import '../models/present.dart';

// Página para adicionar ou editar um item da lista de compras
class EditPage extends StatelessWidget {
  final Present? present;
  final TextEditingController descriptionController = TextEditingController();
  final PresentController presentController = Get.find();
  final isGiven = false.obs;

  EditPage({Key? key, this.present}) : super(key: key) {
    if (present != null) {
      descriptionController.text = present!.description;
      isGiven.value = present!.isGiven;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          present == null ? 'Adicionar Item' : 'Editar Item',
          style: const TextStyle(fontWeight: FontWeight.bold),
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Campo de texto para descrição
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Descrição do Item',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              // Checkbox para marcar item comprado
              Obx(() => CheckboxListTile(
                title: const Text('Item Comprado'),
                value: isGiven.value,
                onChanged: (bool? value) {
                  if (value != null) {
                    isGiven.value = value;
                  }
                },
                activeColor: Colors.green,
              )),
              const SizedBox(height: 20),
              // Botão de ação principal
              ElevatedButton(
                onPressed: () {
                  if (descriptionController.text.trim().isEmpty) {
                    Get.snackbar('Erro', 'A descrição não pode estar vazia.',
                        backgroundColor: Colors.red.shade300,
                        colorText: Colors.white,
                        snackPosition: SnackPosition.BOTTOM);
                    return;
                  }

                  if (present == null) {
                    presentController.addPresent(
                      descriptionController.text,
                      DateTime.now(), // Data não é mais usada, então uma default
                      isGiven.value,
                    );
                  } else {
                    presentController.updatePresent(
                      present!.id,
                      descriptionController.text,
                      DateTime.now(), // Data não é mais usada, então uma default
                      isGiven.value,
                    );
                  }
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: Text(
                  present == null ? 'Adicionar' : 'Atualizar',
                  style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}