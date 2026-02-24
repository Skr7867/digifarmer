import 'package:digifarmer/model/chooseRole/choose_role_model.dart';

abstract class ChooseRoleRepository {
  Future<ChooseRoleModel> userRegisterApi(dynamic data);
}
