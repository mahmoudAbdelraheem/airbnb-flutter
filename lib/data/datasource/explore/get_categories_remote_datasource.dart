import 'package:cloud_firestore/cloud_firestore.dart';

abstract class GetCategoriesRemoteDatasource {
  Future<List<Map<String, dynamic>>> getCategories();
}

class GetCategoriesRemoteDatasourceImp
    implements GetCategoriesRemoteDatasource {
  final FirebaseFirestore firestore;

  GetCategoriesRemoteDatasourceImp({required this.firestore});

  @override
  Future<List<Map<String, dynamic>>> getCategories() async {
    try {
      // Reference to the 'categories' collection in Firestore
      CollectionReference categoriesRef = firestore.collection('categories');

      // Fetch documents from the collection
      QuerySnapshot querySnapshot = await categoriesRef.get();

      // Map Firestore documents to List<Map<String, dynamic>>
      List<Map<String, dynamic>> categories = querySnapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();
      return categories;
    } catch (e) {
      print('Error fetching categories: $e');
      return [];
    }
  }
}
