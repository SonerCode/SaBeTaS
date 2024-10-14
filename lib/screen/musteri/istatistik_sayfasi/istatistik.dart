import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../provider/firebaseistatik_provide.dart';
import 'ogunleregore_liste/is_activite.dart';
import 'ogunleregore_liste/is_aksam_listesi.dart';
import 'ogunleregore_liste/is_kahvalti_listesi.dart';
import 'ogunleregore_liste/is_oglen_listesi.dart';

class StatistikPage extends StatefulWidget {
  const StatistikPage({super.key});

  @override
  State<StatistikPage> createState() => _StatistikPageState();
}

class _StatistikPageState extends State<StatistikPage> {
  int _elevatedContainerIndex = 6;
  bool _initialized = false;

  // Türkçe kısa gün adlarını içeren harita
  final Map<String, String> shortTurkishDays = {
    'Monday': 'Pzt',
    'Tuesday': 'Sal',
    'Wednesday': 'Çar',
    'Thursday': 'Per',
    'Friday': 'Cum',
    'Saturday': 'Cmt',
    'Sunday': 'Pzr',
  };

  String getShortTurkishDay(String englishDay) {
    return shortTurkishDays[englishDay] ?? englishDay;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      DateTime today = DateTime.now();
      List<DateTime> pastWeekDates = List.generate(
        7,
        (index) => today.subtract(Duration(days: index + 1)),
      ).reversed.toList();
      Provider.of<FireIstatik>(context, listen: true)
        ..gunlukData(
            dayName: DateFormat('yyyyMMdd')
                .format(pastWeekDates[_elevatedContainerIndex]))
        ..getistatikfoodAksam(
            dayName: DateFormat('yyyyMMdd')
                .format(pastWeekDates[_elevatedContainerIndex]))
        ..getistatikfoodKahvalti(
            dayName: DateFormat('yyyyMMdd')
                .format(pastWeekDates[_elevatedContainerIndex]))
        ..getistatikfoodOglen(
            dayName: DateFormat('yyyyMMdd')
                .format(pastWeekDates[_elevatedContainerIndex]))
        ..getistatikactivite(
            dayName: DateFormat('yyyyMMdd')
                .format(pastWeekDates[_elevatedContainerIndex]));
      _initialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final heig = MediaQuery.of(context).size.height;
    final widt = MediaQuery.of(context).size.width;
    DateTime today = DateTime.now();
    List<DateTime> pastWeekDates = List.generate(
      7,
      (index) => today.subtract(Duration(days: index + 1)),
    ).reversed.toList();
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(5),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white, // Konteyner rengi
                  borderRadius: BorderRadius.circular(10), // Köşe yarıçapı
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.55), // Gölge rengi
                      spreadRadius: 5, // Yayılma yarıçapı
                      blurRadius: 7, // Bulanıklık yarıçapı
                      offset: const Offset(0, 3), // Gölgenin konumu
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: List.generate(
                    7,
                    (index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_elevatedContainerIndex == index) {
                            // If the tapped container is already elevated, bring it down
                            _elevatedContainerIndex = index;
                          } else {
                            // Set the tapped container index to elevate it
                            _elevatedContainerIndex = index;
                          }
                          Provider.of<FireIstatik>(context, listen: false)
                            ..gunlukData(
                                dayName: DateFormat('yyyyMMdd').format(
                                    pastWeekDates[_elevatedContainerIndex]))
                            ..getistatikfoodAksam(
                                dayName: DateFormat('yyyyMMdd').format(
                                    pastWeekDates[_elevatedContainerIndex]))
                            ..getistatikfoodKahvalti(
                                dayName: DateFormat('yyyyMMdd').format(
                                    pastWeekDates[_elevatedContainerIndex]))
                            ..getistatikfoodOglen(
                                dayName: DateFormat('yyyyMMdd').format(
                                    pastWeekDates[_elevatedContainerIndex]))
                            ..getistatikactivite(
                                dayName: DateFormat('yyyyMMdd').format(
                                    pastWeekDates[_elevatedContainerIndex]));
                        });
                      },
                      child: AnimatedContainer(
                        decoration: _elevatedContainerIndex == index
                            ? BoxDecoration(
                                color: _elevatedContainerIndex == index
                                    ? const Color.fromARGB(255, 2, 161, 63)
                                    : Colors.grey
                                        .withOpacity(0.55), // Konteyner rengi
                                borderRadius:
                                    BorderRadius.circular(10), // Köşe yarıçapı
                              )
                            : BoxDecoration(
                                color: _elevatedContainerIndex == index
                                    ? const Color.fromARGB(148, 134, 241, 175)
                                    : Colors.grey
                                        .withOpacity(0.55), // Konteyner rengi
                                borderRadius:
                                    BorderRadius.circular(10), // Köşe yarıçapı
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey
                                        .withOpacity(0.55), // Gölge rengi
                                    spreadRadius: 5, // Yayılma yarıçapı
                                    blurRadius: 7, // Bulanıklık yarıçapı
                                    offset:
                                        const Offset(0, 3), // Gölgenin konumu
                                  ),
                                ],
                              ),
                        duration: const Duration(milliseconds: 400),
                        transform: _elevatedContainerIndex == index
                            ? Matrix4.translationValues(0.0, -20.0, 0.0)
                            : Matrix4.translationValues(0.0, 0.0, 0.0),
                        height: heig / 12,
                        width: widt / 9,
                        margin: const EdgeInsets.all(5),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              getShortTurkishDay(DateFormat('EEEE')
                                  .format(pastWeekDates[index])),
                              style: TextStyle(
                                color: _elevatedContainerIndex == index
                                    ? Colors.white
                                    : Colors.blueGrey,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              DateFormat('dd').format(pastWeekDates[index]),
                              style: TextStyle(
                                  color: _elevatedContainerIndex == index
                                      ? Colors.white
                                      : Colors.blueGrey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )),
          Consumer<FireIstatik>(builder: (context, value, child) {
            return Padding(
                padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
                child: Column(
                  children: [
                    Container(
                      height: heig / 7,
                      width: widt,
                      decoration: BoxDecoration(
                        color: Colors.white, // Konteyner rengi
                        borderRadius:
                            BorderRadius.circular(10), // Köşe yarıçapı
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.55), // Gölge rengi
                            spreadRadius: 5, // Yayılma yarıçapı
                            blurRadius: 7, // Bulanıklık yarıçapı
                            offset: const Offset(0, 3), // Gölgenin konumu
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            width: widt,
                            height: heig / 14,
                            child: Center(
                              child: Text(
                                value.myData?.alinankalori == -1
                                    ? 'Bu tarihte Veri Girişi olmamıştır.'
                                    : 'Alınan kalori: ${value.myData?.alinankalori}',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: widt,
                            height: heig / 14,
                            child: Center(
                              child: Text(
                                value.myData?.gereklikalori == -1
                                    ? 'Bu tarihte Veri Girişi olmamıştır.'
                                    : 'Alınması Geren kalori: ${value.myData?.gereklikalori}',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    IsKahvalti(kahvaltim: value.kahvaltiList),
                    IsOglen(
                      oglenim: value.oglenList,
                    ),
                    IsAksam(
                      aksamim: value.aksamList,
                    ),
                    IsActivite(activitem: value.activiteler),
                  ],
                ));
          })
        ],
      ),
    );
  }
}
