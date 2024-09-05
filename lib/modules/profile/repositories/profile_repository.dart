import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:unicode/core/base/repositories/base_repository.dart';
import 'package:unicode/core/utils/constants.dart';
import 'package:unicode/modules/profile/models/response/user_model.dart';

import '../../../core/services/error/failure.dart';
import '../../../core/services/local/cache_client.dart';
import '../../../core/services/local/storage_keys.dart';

class ProfileRepository extends BaseRepository {
  final CacheClient _cacheClient;

  ProfileRepository(this._cacheClient, super.networkInfo);

  Future<Either<Failure, UserModel>> getCurrentUser() async {
    return super.call<UserModel>(
      firebaseRequest: () async {
        final String userId = await _cacheClient.get(StorageKeys.userId);
        final docSnapshot =
            await FirebaseFirestore.instance.collection(FirebaseConstants.usersCollection).doc(userId).get();
        return UserModel.fromJson(docSnapshot.data() ?? {});
      },
    );
  }
}
