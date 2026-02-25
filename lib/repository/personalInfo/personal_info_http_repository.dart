import 'package:digifarmer/config/apiUrls/api_urls.dart';
import 'package:digifarmer/config/data/network/network_services_api.dart';
import 'package:digifarmer/repository/personalInfo/personal_info_repository.dart';

import '../../model/personalInfo/personal_details_response_model.dart';

class PersonalInfoHttpRepository implements PersonalInfoRepository {
  final _apiServices = NetworkApiServices();

  @override
  Future<PersonalDetailsResponseModel> personalInfoApi(dynamic data) async {
    final response = await _apiServices.postApi(data, ApiUrls.personalInfoApi);
    return PersonalDetailsResponseModel.fromJson(response);
  }
}
