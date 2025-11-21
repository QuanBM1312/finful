import 'package:finful_app/app/data/datasource/local/auth_local_datasource.dart';
import 'package:finful_app/core/datasource/base_local.dart';
import 'package:finful_app/core/datasource/base_remote.dart';
import 'package:finful_app/core/datasource/config.dart';
import 'package:finful_app/core/entity/mapper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDatasourceImpl extends BaseLocal<Authorization>
    implements AuthLocalDatasource {
  AuthLocalDatasourceImpl({
    required SharedPreferences preferences,
  }) : super(
    mapper: Mapper<Authorization>(parse: Authorization.fromJson),
    prefs: preferences,
  );

  @override
  Future<void> clearAuthorization() async {
    await clearObjectOrEntity(currentAuthorizationKey);
  }

  @override
  Authorization? loadAuthorization() {
    return getItem(currentAuthorizationKey);
  }

  @override
  Future<void> saveAuthorization(Authorization authorization) async {
    await clearObjectOrEntity(currentAuthorizationKey);
    await saveEntity(authorization, currentAuthorizationKey);
  }
}
