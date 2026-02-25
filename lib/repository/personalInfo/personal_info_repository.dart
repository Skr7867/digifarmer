import '../../model/personalInfo/personal_details_response_model.dart';

abstract class PersonalInfoRepository {
  Future<PersonalDetailsResponseModel> personalInfoApi(dynamic data);
}
