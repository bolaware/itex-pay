class ChargeRequestBody {
  Transaction transaction;
  Order order;
  Source source;

  ChargeRequestBody({this.transaction, this.order, this.source});

  ChargeRequestBody.fromJson(Map<String, dynamic> json) {
    transaction = json['transaction'] != null
        ? new Transaction.fromJson(json['transaction'])
        : null;
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
    source =
        json['source'] != null ? new Source.fromJson(json['source']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.transaction != null) {
      data['transaction'] = this.transaction.toJson();
    }
    if (this.order != null) {
      data['order'] = this.order.toJson();
    }
    if (this.source != null) {
      data['source'] = this.source.toJson();
    }
    return data;
  }
}

class Transaction {
  String paymentlinkreference;
  String modalreference;
  String paymentid;
  String callbackurl;
  String redirecturl;
  String paymentmethod;

  Transaction(
      {this.paymentlinkreference,
      this.modalreference,
      this.paymentid,
      this.callbackurl,
      this.redirecturl,
      this.paymentmethod});

  Transaction.fromJson(Map<String, dynamic> json) {
    paymentlinkreference = json['paymentlinkreference'];
    modalreference = json['modalreference'];
    paymentid = json['paymentid'];
    callbackurl = json['callbackurl'];
    redirecturl = json['redirecturl'];
    paymentmethod = json['paymentmethod'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['paymentlinkreference'] = this.paymentlinkreference;
    data['modalreference'] = this.modalreference;
    data['paymentid'] = this.paymentid;
    data['callbackurl'] = this.callbackurl;
    data['redirecturl'] = this.redirecturl;
    data['paymentmethod'] = this.paymentmethod;
    return data;
  }
}

class Order {
  String amount;
  String description;
  String currency;
  String country;

  Order({this.amount, this.description, this.currency, this.country});

  Order.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    description = json['description'];
    currency = json['currency'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['description'] = this.description;
    data['currency'] = this.currency;
    data['country'] = this.country;
    return data;
  }
}

class Source {
  Customer customer;

  Source({this.customer});

  Source.fromJson(Map<String, dynamic> json) {
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.customer != null) {
      data['customer'] = this.customer.toJson();
    }
    return data;
  }
}

class Customer {
  String firstname;
  String lastname;
  String email;
  String msisdn;
  Card card;
  Device device;

  Customer(
      {this.firstname,
      this.lastname,
      this.email,
      this.msisdn,
      this.card,
      this.device});

  Customer.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    msisdn = json['msisdn'];
    card = json['card'] != null ? new Card.fromJson(json['card']) : null;
    device =
        json['device'] != null ? new Device.fromJson(json['device']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['email'] = this.email;
    data['msisdn'] = this.msisdn;
    if (this.card != null) {
      data['card'] = this.card.toJson();
    }
    if (this.device != null) {
      data['device'] = this.device.toJson();
    }
    return data;
  }
}

class Card {
  String number;
  String expirymonth;
  String expiryyear;
  String cvv;

  Card({this.number, this.expirymonth, this.expiryyear, this.cvv});

  Card.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    expirymonth = json['expirymonth'];
    expiryyear = json['expiryyear'];
    cvv = json['cvv'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number'] = this.number;
    data['expirymonth'] = this.expirymonth;
    data['expiryyear'] = this.expiryyear;
    data['cvv'] = this.cvv;
    return data;
  }
}

class Device {
  String fingerprint;
  String ip;

  Device({this.fingerprint, this.ip});

  Device.fromJson(Map<String, dynamic> json) {
    fingerprint = json['fingerprint'];
    ip = json['ip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fingerprint'] = this.fingerprint;
    data['ip'] = this.ip;
    return data;
  }
}
