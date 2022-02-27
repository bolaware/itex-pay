import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:itex_pay/models/api/response_base.dart';
import 'package:itex_pay/models/charge_request_body.dart';

class Network {

  Map<String, String> _header =
  {'content-type': 'application/json'};

  final deviceKey = "ODgzODM4Mzh8fFNhbXN1bmcgUzEwfHxhbmRyb2lkfHwxMHx8ODM4MzgzaGhkaGQ=";
  final baseUrl = "staging.itex-pay.com";
  final chargeUrl = "/ipg/api/v1/transaction/charge";

  Future<BaseResponse<GenericResponse>> chargeCard(ChargeRequestBody body) async {

    http.Response response = await http.post(
        Uri.https(baseUrl, chargeUrl, getPubKeyQuery()),
        body: json.encode(body.toJson()),
        headers: _header
    );

    print(response.request.url);
    print(response.statusCode);
    print(json.encode(body.toJson()));
    print(response.body);

    if(response.statusCode == HttpStatus.ok){
      return Success(GenericResponse.fromJson(json.decode(response.body)));
    } else {
      return _errorHandler(response, "An error occurred while charging this card.");
    }
  }


  Future<Error<T>> _errorHandler<T>(http.Response response, String msg) async {
    try {
      final errorResponse = GenericResponse.fromJson(json.decode(response.body));
      return Error(errorResponse);
    } catch(e){
      return Error(GenericResponse(status: "fail", statusCode: "0", message: "$e----->${response.body}"));
    }
  }

  Map<String, String> getPubKeyQuery() {
    return {"publickey":"ipub_GG032APUQGTVBOOB1RYAMX6Z0MLTWNTRIJ3SDDQN-X-5-R94WQIBLN7YKR9_3"};
  }

}