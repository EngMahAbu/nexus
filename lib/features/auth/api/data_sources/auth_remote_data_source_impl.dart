import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:nexus/core/contansts/app_constants.dart';
import 'package:nexus/features/auth/api/client/firebase_auth_client.dart';
import 'package:nexus/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:nexus/features/auth/data/models/user_profile_model.dart';
import '../../data/models/user_credential_model.dart';

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuthClient _client;

  AuthRemoteDataSourceImpl(this._client);

  @override
  Future<UserCredentialModel> createUser({
    required String email,
    required String password,
  }) async {
    final userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return UserCredentialModel(userCredential);
  }

  @override
  Future<void> updateDisplayName({required String name}) async {
    return await FirebaseAuth.instance.currentUser?.updateDisplayName(name);
  }

  @override
  Future<UserCredentialModel> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _client.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (userCredential.user == null) {
        throw Exception('User was not found in Firebase');
      }

      return UserCredentialModel(userCredential);
    } on Exception catch (e) {
      throw Exception('Authentication Failed. Error: ${e.toString()}');
    }
  }

  @override
  Future<void> updateUserProfile({required UserProfileModel profile}) {
    return FirebaseFirestore.instance
        .collection(AppConstants.userProfilesCollection)
        .doc(profile.uid)
        .set(profile.toFirestore());
  }
}
