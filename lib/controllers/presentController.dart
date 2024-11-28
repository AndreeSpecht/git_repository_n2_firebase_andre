import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/present.dart';

// Controlador para gerenciar o estado dos itens da lista de compras
class PresentController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var presents = <Present>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchPresents();
  }

  // Busca os itens do Firestore e atualiza a lista observável
  void fetchPresents() {
    _firestore.collection('presents').snapshots().listen((snapshot) {
      presents.value = snapshot.docs
          .map((doc) => Present.fromMap(doc.data(), doc.id))
          .toList();
    });
  }

  // Adiciona um novo item à lista de compras no Firestore
  Future<void> addPresent(String description, DateTime dateToGive, bool isGiven) async {
    await _firestore.collection('presents').add({
      'description': description,
      'dateToGive': dateToGive,
      'isGiven': isGiven,
    });
    Get.snackbar('Sucesso', 'Item adicionado com sucesso!',
        snackPosition: SnackPosition.BOTTOM);
  }

  // Atualiza um item existente na lista de compras no Firestore
  Future<void> updatePresent(String id, String description, DateTime dateToGive, bool isGiven) async {
    await _firestore.collection('presents').doc(id).update({
      'description': description,
      'dateToGive': dateToGive,
      'isGiven': isGiven,
    });
    Get.snackbar('Sucesso', 'Item atualizado com sucesso!',
        snackPosition: SnackPosition.BOTTOM);
  }

  // Deleta um item da lista de compras do Firestore
  Future<void> deletePresent(String id) async {
    await _firestore.collection('presents').doc(id).delete();
    Get.snackbar('Sucesso', 'Item deletado com sucesso!',
        snackPosition: SnackPosition.BOTTOM);
  }
}
