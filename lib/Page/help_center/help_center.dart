import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:grocery_app/constant/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpScreen extends StatefulWidget {
  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  int curruntindex = -1;
  String email = "tasvirlimbani111@gmail.com";
  void _launchcall() async {
    if (!await launch("tel://+91 9664917815")) throw 'Could not Call !';
  }

  void _launchemail() async {
    if (!await launch("mailto:$email")) throw 'Could not find This Email !';
  }

  void _launchsms() async {
    if (!await launch("sms:+91 9664917815?body=hello"))
      throw 'Could not send SMS !';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: colors.appcolor,
      appBar: AppBar(
        backgroundColor: colors.appcolor,
        centerTitle: true,
        title: Text(
          "Help Center",
          style: TextStyle(
              color: colors.black.withOpacity(0.6),
              letterSpacing: 2,
              fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: colors.black.withOpacity(0.6),
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Center(
              child: Image.asset(
                "assets/images/help.png",
                width: 210,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Expanded(
              child: GridView.builder(
                itemCount: Helplist.length,
                gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCountAndCentralizedLastElement(
                        itemCount: Helplist.length,
                        crossAxisCount: 2,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        curruntindex = index;
                      });
                      if (curruntindex == 0) {
                        _launchcall();
                      }
                      if (curruntindex == 1) {
                        _launchemail();
                      }
                      if (curruntindex == 2) {
                        _launchsms();
                      }
                    },
                    child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Helplist[index].icon,
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${Helplist[index].name}",
                              style: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1),
                            )
                          ],
                        )),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.place_outlined,
                  color: colors.appbarcolor,
                ),
                Text(
                  "- VIP circle  near Power station , Mota-\nvarachha SURAT - 395006.",
                  textAlign: TextAlign.center,
                  style: TextStyle(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Help {
  Icon icon;
  String name;
  Help({required this.name, required this.icon});
}

List<Help> Helplist = [
  Help(
      name: "Talk to us",
      icon: Icon(
        Icons.phone_in_talk_outlined,
        size: 50,
        color: colors.appbarcolor,
      )),
  Help(
      name: "Send Email",
      icon: Icon(
        Icons.mail_outline_outlined,
        size: 50,
        color: colors.appbarcolor,
      )),
  Help(
      name: "Chat with us",
      icon: Icon(
        Icons.question_answer_outlined,
        size: 50,
        color: colors.appbarcolor,
      )),
];

class SliverGridWithCustomGeometryLayout extends SliverGridRegularTileLayout {
  /// The builder for each child geometry.
  final SliverGridGeometry Function(
    int index,
    SliverGridRegularTileLayout layout,
  ) geometryBuilder;

  SliverGridWithCustomGeometryLayout({
    required this.geometryBuilder,
    required int crossAxisCount,
    required double mainAxisStride,
    required double crossAxisStride,
    required double childMainAxisExtent,
    required double childCrossAxisExtent,
    required bool reverseCrossAxis,
  })  : assert(geometryBuilder != null),
        assert(crossAxisCount != null && crossAxisCount > 0),
        assert(mainAxisStride != null && mainAxisStride >= 0),
        assert(crossAxisStride != null && crossAxisStride >= 0),
        assert(childMainAxisExtent != null && childMainAxisExtent >= 0),
        assert(childCrossAxisExtent != null && childCrossAxisExtent >= 0),
        assert(reverseCrossAxis != null),
        super(
          crossAxisCount: crossAxisCount,
          mainAxisStride: mainAxisStride,
          crossAxisStride: crossAxisStride,
          childMainAxisExtent: childMainAxisExtent,
          childCrossAxisExtent: childCrossAxisExtent,
          reverseCrossAxis: reverseCrossAxis,
        );

  @override
  SliverGridGeometry getGeometryForChildIndex(int index) {
    return geometryBuilder(index, this);
  }
}

/// Creates grid layouts with a fixed number of tiles in the cross axis, such
/// that fhe last element, if the grid item count is odd, is centralized.
class SliverGridDelegateWithFixedCrossAxisCountAndCentralizedLastElement
    extends SliverGridDelegateWithFixedCrossAxisCount {
  /// The total number of itens in the layout.
  final int itemCount;

  SliverGridDelegateWithFixedCrossAxisCountAndCentralizedLastElement({
    required this.itemCount,
    required int crossAxisCount,
    double mainAxisSpacing = 0.0,
    double crossAxisSpacing = 0.0,
    double childAspectRatio = 1.0,
  })  : assert(itemCount != null && itemCount > 0),
        assert(crossAxisCount != null && crossAxisCount > 0),
        assert(mainAxisSpacing != null && mainAxisSpacing >= 0),
        assert(crossAxisSpacing != null && crossAxisSpacing >= 0),
        assert(childAspectRatio != null && childAspectRatio > 0),
        super(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: mainAxisSpacing,
          crossAxisSpacing: crossAxisSpacing,
          childAspectRatio: childAspectRatio,
        );

  bool _debugAssertIsValid() {
    assert(crossAxisCount > 0);
    assert(mainAxisSpacing >= 0.0);
    assert(crossAxisSpacing >= 0.0);
    assert(childAspectRatio > 0.0);
    return true;
  }

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    assert(_debugAssertIsValid());
    final usableCrossAxisExtent = max(
      0.0,
      constraints.crossAxisExtent - crossAxisSpacing * (crossAxisCount - 1),
    );
    final childCrossAxisExtent = usableCrossAxisExtent / crossAxisCount;
    final childMainAxisExtent = childCrossAxisExtent / childAspectRatio;
    return SliverGridWithCustomGeometryLayout(
      geometryBuilder: (index, layout) {
        return SliverGridGeometry(
          scrollOffset: (index ~/ crossAxisCount) * layout.mainAxisStride,
          crossAxisOffset: itemCount.isOdd && index == itemCount - 1
              ? layout.crossAxisStride / 2
              : _getOffsetFromStartInCrossAxis(index, layout),
          mainAxisExtent: childMainAxisExtent,
          crossAxisExtent: childCrossAxisExtent,
        );
      },
      crossAxisCount: crossAxisCount,
      mainAxisStride: childMainAxisExtent + mainAxisSpacing,
      crossAxisStride: childCrossAxisExtent + crossAxisSpacing,
      childMainAxisExtent: childMainAxisExtent,
      childCrossAxisExtent: childCrossAxisExtent,
      reverseCrossAxis: axisDirectionIsReversed(constraints.crossAxisDirection),
    );
  }

  double _getOffsetFromStartInCrossAxis(
    int index,
    SliverGridRegularTileLayout layout,
  ) {
    final crossAxisStart = (index % crossAxisCount) * layout.crossAxisStride;

    if (layout.reverseCrossAxis) {
      return crossAxisCount * layout.crossAxisStride -
          crossAxisStart -
          layout.childCrossAxisExtent -
          (layout.crossAxisStride - layout.childCrossAxisExtent);
    }
    return crossAxisStart;
  }
}
