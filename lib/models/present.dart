import 'package:cloud_firestore/cloud_firestore.dart';

// Criação do Construtor de itens da lista de compras
class Present {
  String id;
  String description;
  DateTime dateToGive;
  bool isGiven;

  Present({
    required this.id,
    required this.description,
    required this.dateToGive,
    required this.isGiven,
  });

  factory Present.fromMap(Map<String, dynamic> data, String documentId) {
    return Present(
      id: documentId,
      description: data['description'] ?? '',
      dateToGive: (data['dateToGive'] as Timestamp).toDate(),
      isGiven: data['isGiven'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'dateToGive': dateToGive,
      'isGiven': isGiven,
    };
  }
}
