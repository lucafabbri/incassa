import 'package:RCHGatewayClient/api.dart';
import 'package:oauth2/oauth2.dart' as oauth2;

import '../common/errors/advanced_error.dart';

class BaseService {
  final tokenEndpoint = Uri.parse('http://192.168.1.4:5080/auth/token');
  final clientId = "postman";
  final clientSecret = "postman-secret";

  BaseService() {
    if (defaultApiClient.authentication == null) {
      initAuth().whenComplete(() => print('Logged in'));
    }
  }

  Future initAuth() async {
    var client = await oauth2.clientCredentialsGrant(
        tokenEndpoint, clientId, clientSecret);
    var token = HttpBearerAuth();
    token.accessToken = client.credentials.accessToken;
    defaultApiClient = ApiClient(authentication: token);
  }

  AdvancedError manageApiErrorResult(int code) {
    switch (code) {
      case 400:
        return AdvancedError.validation;
      case 403:
        return AdvancedError.conflict;
      case 404:
        return AdvancedError.notFound;
      case 409:
        return AdvancedError.conflict;
      case 422:
        return AdvancedError.conflict;
      default:
        return AdvancedError.unexpected;
    }
  }
}
