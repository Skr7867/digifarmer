import 'package:digifarmer/config/apiUrls/api_urls.dart';
import 'package:digifarmer/config/data/network/network_services_api.dart';
import 'package:digifarmer/model/chooseRole/choose_role_model.dart';
import 'package:digifarmer/repository/chooseRole/choose_role_repository.dart';

class ChooseRoleHttpRepository implements ChooseRoleRepository {
  final _apiServices = NetworkApiServices();

  @override
  Future<ChooseRoleModel> chooseRoleApi(dynamic data) async {
    final response = await _apiServices.postApi(data, ApiUrls.chooseRoleApi);
    return ChooseRoleModel.fromJson(response);
  }
}
