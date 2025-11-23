import 'package:armpet_wash_mobile/app_page.dart';
import 'package:armpet_wash_mobile/dictionaries.dart';
import 'package:armpet_wash_mobile/fr/goods_group.dart';
import 'package:armpet_wash_mobile/utilities.dart';
import 'package:flutter/material.dart';

import 'fr/goods.dart';

class GoodsPage extends AppPage {
  const GoodsPage({super.key});

  @override
  Widget body(BuildContext context) => GoodsPageContent();
}

class GoodsPageContent extends StatefulWidget {
  const GoodsPageContent({super.key});

  @override
  State<StatefulWidget> createState() => _GoodsPageContentState();
}

class _GoodsPageContentState extends State<GoodsPageContent> {
  static const goodsGroupMinWidth = 150;
  static const spacing = 5.0;
  final gl = <Goods>[];

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          flex: 1,
          child:  SizedBox(width: double.infinity, child: SingleChildScrollView(child:
              Wrap(
                spacing: spacing,
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                children: [
                  for (final gg in goodsGroups)...[
                    goodsGroupWidget(gg)
                  ]
                ],
              )),
          )),
        const SizedBox(width: 5),
        Flexible(
            flex: 5,child: SingleChildScrollView(child: Wrap(spacing: spacing,
          children: [
            for (final g in gl)...[
              goodsWidget(g)
            ]
          ],
        ))),
      ],
    );
  }

  Widget goodsGroupWidget(GoodsGroup gg) {
    final screenWidth = MediaQuery.of(context).size.width;
    final int countPerRow = screenWidth ~/ (goodsGroupMinWidth + spacing);
    final double adjustedWidth = screenWidth  / countPerRow;
    final remain = (screenWidth  - (adjustedWidth * countPerRow)) / countPerRow;
    return InkWell(
      onTap: ()=> getListOfGoods(gg.f_id),
        child:  Container(
      width: adjustedWidth + remain - spacing,
      height: 70,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Colors.amberAccent
      ),
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.all(5),
      child: Text(gg.f_am, textAlign: TextAlign.center),
    ));
  }

  Widget goodsWidget(Goods g) {
    final screenWidth = MediaQuery.of(context).size.width;
    final int countPerRow = screenWidth ~/ (goodsGroupMinWidth + spacing);
    final double adjustedWidth = screenWidth  / countPerRow;
    final remain = (screenWidth  - (adjustedWidth * countPerRow)) / countPerRow;
    return InkWell(
        onTap: ()=> Navigator.pop(context, g),
        child:  Container(
          width: adjustedWidth + remain - spacing,
          height: 140,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              color: Colors.green
          ),
          margin: const EdgeInsets.only(bottom: 5),
          padding: const EdgeInsets.all(5),
          child: Column(children: [ Text(g.f_en, textAlign: TextAlign.center),
            Text(sp.df(g.f_price.toString()), style: const TextStyle(fontWeight: FontWeight.bold))])
        ));
  }

  void getListOfGoods(int groupId) {
   gl.clear();
   gl.addAll( goods.where((e) => e.f_type == groupId).toList());
   setState(() {

   });
  }
}
