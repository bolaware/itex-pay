import 'dart:async';

import 'package:itex_pay/blocs/bloc.dart';
import 'package:itex_pay/models/api/response_base.dart';
import 'package:itex_pay/models/charge_request_body.dart';
import 'package:itex_pay/services/network.dart';

class CardBloc implements Bloc {

  final _controller = StreamController<BaseResponse<GenericResponse>>();
  final _networkClient = Network();

  Stream<BaseResponse<GenericResponse>> get stream => _controller.stream;

  void chargeCard(String cardNumber, String cvv, String expiry) async {
    _controller.sink.add(showLoading());
    ChargeRequestBody body = ChargeRequestBody(
      transaction: Transaction(
        paymentlinkreference: "M1603t798eg9106n10m_y121",
        modalreference: "M1603t798eg9106n10m_y121",
        paymentid: "M1603t79w8een10m_y12",
        callbackurl: "https://google.com",
        redirecturl: "https://yahoo.com",
        paymentmethod: "card"
      ),
      order: Order(
        amount: "100",
        description: "Something",
        currency: "NGN",
        country: "NG"
      ),
      source: Source(
          customer: Customer(
              firstname: "Bola",
              lastname: "Kass",
              email: "jsjsj@yahoo.co",
              msisdn: "sjjs",
              card: Card(
                  number: cardNumber.replaceAll(" ", ""),
                  expirymonth: expiry.split("/")[0],
                  expiryyear: expiry.split("/")[1],
                  cvv: cvv
              ),
            device: Device(fingerprint: "djjd", ip: "sjjsjs")
          )
      )
    );
    final result = await _networkClient.chargeCard(body);
    _controller.sink.add(result);
  }

  void hasReadData(BaseResponse<GenericResponse> loginResponse) {
    _controller.sink.add(loginResponse.clone());
  }

  @override
  Loading<T> showLoading<T>() {
    return Loading();
  }

  @override
  void dispose() {
    print("DISPOSED");
    _controller.close();
  }
}
