import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addUserDetails({int? age}) async {
  final userDocRef =
      FirebaseFirestore.instance.collection('Users').doc('your_user_id');

  // Update only the age in Firestore
  await userDocRef.update({
    if (age != null) 'Age': age,
  });
}
