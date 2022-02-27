import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:itex_pay/ui/cards/card_screen.dart';
import 'package:itex_pay/ui/cards/otp_screen.dart';
import 'package:itex_pay/ui/cards/pin_screen.dart';
import 'package:itex_pay/ui/cards/success_screen.dart';
import 'package:itex_pay/ui/consts.dart';

const home = "/";
const pin = "/pin";
const otp = "/otp";
const success = "/success";

class ItexContainerScreen extends StatefulWidget {
  const ItexContainerScreen({Key key}) : super(key: key);

  @override
  State<ItexContainerScreen> createState() => _ItexContainerScreenState();
}

class _ItexContainerScreenState extends State<ItexContainerScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      onGenerateRoute: (settings) {
        Widget page;
        page = SetupFlow(
          setupPageRoute: settings.name,
        );

        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return Scaffold(
              body: SafeArea(
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      height: height / 3,
                      decoration: BoxDecoration(
                        color: Colors.greenAccent.withAlpha(50),
                        borderRadius: BorderRadius.only(topRight: Radius.circular(12), topLeft: Radius.circular(12)),
                      ),
                    ),
                    Positioned(
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 60,
                                    width: 60,
                                    padding: EdgeInsets.all(10.0),
                                    child: Image.asset(
                                      "assets/atica_logo2.png",
                                      package: 'itex_pay',
                                    ),
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 2,
                                            blurRadius: 4,
                                            offset: Offset(1, 3), // changes position of shadow
                                          ),
                                        ],
                                        color: Colors.white,
                                        shape: BoxShape.circle
                                    ),
                                  ),
                                  SizedBox(height: 8.0,),
                                  Text("Atica Softwares".replaceAll("", "\u{200B}"), maxLines: 1, overflow: TextOverflow.ellipsis,),
                                ],
                              ),
                            ),
                            SizedBox(width: 12.0,),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 44.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text("NGN 2100".replaceAll("", "\u{200B}"), maxLines: 1, overflow: TextOverflow.ellipsis,),
                                    Text("kassim.bolaji@yahoo.com".replaceAll("", "\u{200B}"), maxLines: 1, overflow: TextOverflow.ellipsis,),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Flexible(child: page),
                        SizedBox(height: 16.0,),
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0xFF5DCC97),
                              borderRadius: BorderRadius.all(Radius.circular(8))
                          ),
                          padding: EdgeInsets.all(8.0),
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Icon(Icons.lock, color: Colors.white, size: 16,),
                              Text("Secured by ", style: textBody1.copyWith(color: Colors.white),),
                              Image.asset("assets/itex_logo.png", width:50, package: 'itex_pay',)
                            ],
                          ),
                        ),
                        SizedBox(height: 16.0,),
                        RaisedButton(
                          color: Colors.white,
                          onPressed: () => print("Button Pressed"),
                          child: new Text("Cancel Payment"),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
          settings: settings,
        );
      },
    );
  }
}


@immutable
class SetupFlow extends StatefulWidget {
  static SetupFlowState of(BuildContext context) {
    return context.findAncestorStateOfType<SetupFlowState>();
  }

  const SetupFlow({
    Key key,
    @required this.setupPageRoute,
  }) : super(key: key);

  final String setupPageRoute;

  @override
  SetupFlowState createState() => SetupFlowState();
}

class SetupFlowState extends State<SetupFlow> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
  }

  Future<bool> _isExitDesired() async {
    return await showDialog<bool>(
        context: context,
        builder: (context) {return AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text(
                'If you exit device setup, your progress will be lost.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text('Leave'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('Stay'),
              ),
            ],
          );}) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    // return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
    //   return WillPopScope(
    //       onWillPop: _isExitDesired,
    //       child: ConstrainedBox(
    //         constraints: BoxConstraints(minHeight: constraints.minHeight, maxHeight: constraints.maxHeight),
    //         child: Navigator(
    //           key: _navigatorKey,
    //           initialRoute: widget.setupPageRoute,
    //           onGenerateRoute: _onGenerateRoute,
    //         ),
    //       )
    //   );
    // });
    // return Column(
    //   children: [
    //     Navigator(
    //       key: _navigatorKey,
    //       initialRoute: widget.setupPageRoute,
    //       onGenerateRoute: _onGenerateRoute,
    //     ),
    //     Text("Bolaji")
    //   ],
    // );
    return WillPopScope(
      onWillPop: _isExitDesired,
      child: Navigator(
        key: _navigatorKey,
        initialRoute: widget.setupPageRoute,
        onGenerateRoute: _onGenerateRoute,
      ),
    );
  }

  Route _onGenerateRoute(RouteSettings settings) {
    Widget page;
    switch (settings.name) {
      case home:
        page = CardScreen();
        break;
      case pin:
        page = PinScreen();
        break;
      case otp:
        page = OtpScreen();
        break;
      case success:
        page = SuccessScreen();
        break;
    }


    return MaterialPageRoute<dynamic>(
      builder: (context) {
        return Align(
          alignment: Alignment.topCenter,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            margin: EdgeInsets.only(top: 100.0, left: 16.0, right: 16.0),
            width: double.infinity,
            child: ListView(
              shrinkWrap: true,
              children: [
                page
              ],
            ),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: Offset(1, 3), // changes position of shadow
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12))
            ),
          ),
        );
      },
      settings: settings,
    );
  }
}
