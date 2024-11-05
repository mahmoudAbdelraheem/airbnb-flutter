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
        // Add the document ID as an 'id' field to the category data
        Map<String, dynamic> categoryData = doc.data() as Map<String, dynamic>;
        categoryData['id'] = doc.id;
        return categoryData;
      }).toList();

      return categories;
    } catch (e) {
      return [];
    }
  }
}
