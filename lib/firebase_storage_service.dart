import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  static Future<void> uploadImage(File imageFile) async {
    try {
      // Crea un nombre único para la imagen
      final fileName = DateTime.now().toIso8601String() +
          '_' +
          imageFile.uri.pathSegments.last;
      final ref = FirebaseStorage.instance.ref().child('images/$fileName');

      // Subir el archivo
      final uploadTask = ref.putFile(imageFile);

      // Opcional: Puedes usar el método `whenComplete` para realizar acciones después de la carga
      await uploadTask.whenComplete(() async {
        print('Image uploaded successfully!');
      });

      // Verificar el estado del upload
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();
      print('Image URL: $downloadUrl');
    } catch (e) {
      print('Error al subir la imagen: $e');
    }
  }
}
