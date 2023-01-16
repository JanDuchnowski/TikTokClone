import 'package:tiktok_clone/firebase/storage.dart';
import 'package:tiktok_clone/models/user.dart';

class ProfileController {
  final String userId;
  User? currentUser;
  ProfileController({required this.userId});

  Future<void> getCurrentUser() async {
    print("was called");
    final userSnapshot =
        await Storage().firestore.collection('users').doc(userId).get();
    currentUser = User.fromSnap(userSnapshot);
  }
}
