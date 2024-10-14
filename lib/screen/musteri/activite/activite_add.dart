import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../model/food.dart';
import '../../../provider/firebasefoods.dart';
import '../../homescreen/navigation_bar.dart';
import 'activiteitem.dart';

// ignore: must_be_immutable
class ActiviteAdd extends StatefulWidget {
  ActiviteAdd({super.key, required this.searchList, required this.ogun});
  final String ogun;
  List<FoodModel?> searchList = [];

  @override
  State<ActiviteAdd> createState() => _ActiviteAddState();
}

class _ActiviteAddState extends State<ActiviteAdd> {
  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    Provider.of<FireFood>(context, listen: false).activiteler();
  }

  late FocusNode _focusNode = FocusNode();
  @override
  void dispose() {
    _focusNode.dispose();

    super.dispose();
  }

  bool isSearch = false;
  void searchFunc(String value, List<FoodModel> foods) {
    for (var yemek in foods) {
      if (yemek.name
          .toLowerCase()
          .trim()
          .contains(value.toLowerCase().trim())) {
        if (!widget.searchList.contains(yemek)) {
          widget.searchList.add(yemek);
          setState(() {});
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FireFood>(builder: (context, value, child) {
      return Scaffold(
          appBar: CupertinoNavigationBar(
            leading: geriGit(),
            middle: appbarTitle(value.yiyecekler!),
            trailing: searchIconWidget(),
          ),
          body: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: widget.searchList.isNotEmpty
                  ? widget.searchList.length
                  : value.yiyecekler!.length,
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 15);
              },
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return ActiviteItem(
                    ogun: widget.ogun,
                    food: widget.searchList.isNotEmpty
                        ? widget.searchList[index]!
                        : value.yiyecekler![index]);
              }));
    });
  }

  Widget appbarTitle(List<FoodModel> foods) {
    if (isSearch) {
      return CupertinoTextField(
        focusNode: _focusNode,
        textInputAction: TextInputAction.search,
        placeholder: 'Ara',
        onSubmitted: (value) {
          searchFunc(value, foods);
        },
      );
    } else {
      return const Text('Ana Sayfa');
    }
  }

  Widget geriGit() {
    return IconButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const MNavigationBarim()),
          );
          widget.searchList.clear();
        },
        icon: const Icon(Icons.keyboard_double_arrow_left_sharp));
  }
Widget searchIconWidget() {
    if (isSearch) {
      return GestureDetector(
         onTap: () {
          setState(() {
            _focusNode.unfocus();
            isSearch = false;
            widget.searchList.clear();
          });
        },
        child: Container(
        padding: const EdgeInsets.only(left: 10),
        child: const Icon(CupertinoIcons.clear, size: 24),
       
      ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          setState(() {
            _focusNode.requestFocus();
            isSearch = true;
          });
        },
        child: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Icon(
            CupertinoIcons.search,
            size: 24,
          ),
        ),
      );
    }
  }
}