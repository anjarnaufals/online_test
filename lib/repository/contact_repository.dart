import 'dart:developer';

import 'package:either_dart/either.dart';
import 'package:online_test/data/model/contact_model.dart';
import 'package:online_test/data/model/error_model.dart';
import 'package:online_test/infra/json_handler.dart';

class ContactRepository {
  static const String jsonDataAssetUrl = 'assets/data.json';

  Future<Either<ErrorModel, List<ContactModel>>> getListContact({
    bool? showLog = false,
  }) async {
    try {
      var raw = await JsonHandler.loadJsonFromAssets(jsonDataAssetUrl);

      var listContactModel =
          List.from(raw).map((e) => ContactModel.fromMap(e)).toList();

     if (showLog== true) {
       log('${listContactModel.toList()}', name: 'ContactRepository/getListContact');
     }     

      return Right(listContactModel);
    } catch (e) {
      return Left(
        ErrorModel(
          message: e.toString(),
        ),
      );
    }
  }
}
