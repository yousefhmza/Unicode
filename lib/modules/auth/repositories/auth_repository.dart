import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:unicode/core/base/repositories/base_repository.dart';
import 'package:unicode/core/services/local/local_database.dart';
import 'package:unicode/core/utils/constants.dart';
import 'package:unicode/modules/auth/models/requests/auth_body.dart';
import 'package:unicode/modules/profile/models/response/user_model.dart';

import '../../../core/services/error/error_handler.dart';
import '../../../core/services/error/failure.dart';
import '../../../core/services/local/cache_client.dart';
import '../../../core/services/local/storage_keys.dart';

class AuthRepository extends BaseRepository {
  final CacheClient _cacheClient;
  final LocalDatabase _localDatabase;

  AuthRepository(this._cacheClient, this._localDatabase, super.networkInfo);

  bool get isAuthed => _cacheClient.get(StorageKeys.isAuthed) ?? false;

  Future<Either<Failure, UserModel>> signup(AuthBody authBody) async {
    return super.call<UserModel>(
      firebaseRequest: () async {
        // Authenticate using firebase auth to get a unique id and enable password authentication
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: authBody.email?.toLowerCase() ?? "",
          password: authBody.password ?? "",
        );

        // Save the user to firestore to get his categories and todos when he sign in again
        final String userId = credential.user!.uid;
        await FirebaseFirestore.instance
            .collection(FirebaseConstants.usersCollection)
            .doc(userId)
            .set({"id": userId, "email": authBody.email?.toLowerCase()});

        // Save auth data locally to enter to home screen directly in th next time when the user launches the app
        await _cacheClient.save(StorageKeys.userId, userId);
        await _cacheClient.save(StorageKeys.isAuthed, true);

        return UserModel(id: userId, email: authBody.email!.toLowerCase());
      },
    );
  }

  Future<Either<Failure, UserModel>> login(AuthBody authBody) async {
    return super.call<UserModel>(
      firebaseRequest: () async {
        // Authenticate using firebase auth to get the data of the user he signed in using it before and make sure
        // He is entering his data correctly using his password
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: authBody.email?.toLowerCase() ?? "",
          password: authBody.password ?? "",
        );
        final String userId = credential.user!.uid;

        // Save auth data locally to enter to home screen directly in th next time when the user launches the app
        await _cacheClient.save(StorageKeys.userId, userId);
        await _cacheClient.save(StorageKeys.isAuthed, true);

        return UserModel(id: userId, email: authBody.email!);
      },
    );
  }

  Future<Either<Failure, String>> logout() async {
    try {
      await _localDatabase.clearDatabase();
      await _cacheClient.delete(StorageKeys.isAuthed);
      await _cacheClient.delete(StorageKeys.userId);
      return const Right("");
    } on Exception catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
