import 'package:auto_route/auto_route.dart';
import 'package:crypto_saving_app/pages/home/widget/transaction_button.dart';
import 'package:crypto_saving_app/pages/home/widget/transaction_list.dart';
import 'package:flutter/material.dart';

import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_router.dart';
import '../../models/balance.dart';
import '../../models/user.dart';
import '../../services/auth_services.dart';
import '../../styles/colors.dart';
import '../../styles/text_style.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = true;
  User? _user;
  String? _totalIdr;

  @override
  void initState() {
    super.initState();
    fetchUser();
    fetchSaldo();
  }

  Future<void> fetchUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('id');

      if (userId == null) {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      final user = await AuthService().getUser(int.parse(userId));
      setState(() {
        _user = user;
      });
    } catch (e) {
      // Handle error
      print('Error fetching user: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> fetchSaldo() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('id');

      if (userId == null) {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      final response = await AuthService().fetchSaldo(int.parse(userId));
      if (response != null) {
        final balanceResponse = BalanceResponse.fromJson(response);
        setState(() {
          _totalIdr = balanceResponse.totalIdr;
        });
      }
    } catch (e) {
      print('Error fetching saldo: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              color: kBgColor.withOpacity(0.5),
              child: Stack(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, top: 35, right: 30),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Welcome',
                                    style: kBody1.copyWith(
                                        color: kMatterhornBlack)),
                                Text(
                                  _user?.name ?? 'Guest', // Gunakan _user.name
                                  style: kHeading6.copyWith(
                                      color: kMatterhornBlack),
                                ),
                                if (_user != null) ...[
                                  Text(
                                    'Member since ${_user!.createdAt}',
                                    style: kCaption.copyWith(color: kGrey),
                                  )
                                ]
                              ],
                            ),
                            Container(
                              constraints: BoxConstraints.expand(
                                height: 40,
                                width: 40,
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/profile.jpg'),
                                    fit: BoxFit.cover,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: kGrey,
                                      blurRadius: 5,
                                      offset: Offset.fromDirection(2),
                                    ),
                                  ]),
                            )
                          ],
                        ),
                        SizedBox(height: 28),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          constraints: BoxConstraints.expand(height: 170),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(25),
                            ),
                            image: DecorationImage(
                              image:
                                  AssetImage('assets/images/bg-container.png'),
                              fit: BoxFit.cover,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: kGrey,
                                blurRadius: 5,
                                offset: Offset.fromDirection(2),
                              )
                            ],
                          ),
                          child: InkWell(
                            hoverDuration: Duration(milliseconds: 100),
                            onTap: () {
                              context.router.push(BalanceRoute());
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'My savings',
                                  style: kSubtitle2.copyWith(color: kWhite),
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  _totalIdr != null
                                      ? 'Rp. ${_totalIdr}'
                                      : 'N/A',
                                  style: kHeading5.copyWith(
                                    color: kWhite,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                LinearPercentIndicator(
                                  lineHeight: 4,
                                  padding: EdgeInsets.symmetric(horizontal: 0),
                                  progressColor: kEgyptianBlue,
                                  percent: 0.3,
                                  backgroundColor: kWhite,
                                ),
                                SizedBox(height: 16),
                                Text(
                                  _totalIdr != null
                                      ? 'Rp. ${_totalIdr}'
                                      : 'N/A' + ' of 40.000.000',
                                  style: kCaption.copyWith(
                                    color: kWhite,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Row(
                          children: [
                            TransactionButton(
                                icon: 'assets/icons/save.png', text: 'Deposit'),
                            SizedBox(
                              width: 25,
                            ),
                            TransactionButton(
                                icon: 'assets/icons/pay.png', text: 'Withdraw'),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 450),
                    child: Container(
                      decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(40),
                        ),
                      ),
                      padding: const EdgeInsets.only(
                        left: 30,
                        right: 30,
                        top: 21,
                      ),
                      child: Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 14 + 4),
                            child: Column(
                              children: [
                                Center(
                                  child: Text(
                                    'Recent Transactions',
                                    style: kHeading6.copyWith(
                                      color: kLuckyBlue,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 31,
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        TransactionList(
                                          bgColor: kTreeGreen.withOpacity(0.2),
                                          icon: 'assets/icons/triangle-up.png',
                                          title: 'Success!',
                                          sub: 'February 19, 03:25 PM',
                                          amount: '+ 100.000',
                                        ),
                                        TransactionList(
                                          bgColor: kTreeGreen.withOpacity(0.2),
                                          icon: 'assets/icons/triangle-up.png',
                                          title: 'Success!',
                                          sub: 'February 16, 01:25 PM',
                                          amount: '+ 150.000',
                                        ),
                                        TransactionList(
                                          bgColor: kOrange.withOpacity(0.2),
                                          icon:
                                              'assets/icons/triangle-down.png',
                                          title: 'Starbucks Drinks',
                                          sub: 'February 10, 12:25 PM',
                                          amount: '- 110.000',
                                        ),
                                        TransactionList(
                                          bgColor: kOrange.withOpacity(0.2),
                                          icon:
                                              'assets/icons/triangle-down.png',
                                          title: 'Payment #Invest',
                                          sub: 'February 5, 11:05 PM',
                                          amount: '- 130.000',
                                        ),
                                        TransactionList(
                                          bgColor: kOrange.withOpacity(0.2),
                                          icon:
                                              'assets/icons/triangle-down.png',
                                          title: 'Payment #Invest',
                                          sub: 'February 5, 11:05 PM',
                                          amount: '- 130.000',
                                        ),
                                        TransactionList(
                                          bgColor: kOrange.withOpacity(0.2),
                                          icon:
                                              'assets/icons/triangle-down.png',
                                          title: 'Payment #Invest',
                                          sub: 'February 5, 11:05 PM',
                                          amount: '- 130.000',
                                        ),
                                        TransactionList(
                                          bgColor: kOrange.withOpacity(0.2),
                                          icon:
                                              'assets/icons/triangle-down.png',
                                          title: 'Payment #Invest',
                                          sub: 'February 5, 11:05 PM',
                                          amount: '- 130.000',
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              height: 4,
                              width: 49,
                              color: kEgyptianBlue.withOpacity(0.1),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
