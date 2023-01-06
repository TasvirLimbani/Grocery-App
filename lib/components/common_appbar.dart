import 'package:flutter/material.dart';

class CommonAppbar extends StatelessWidget {
  late Widget? title;
  late Widget? leading;
  late List<Widget>? actions;
  late bool centerTitle;
  late int? elevation;
  CommonAppbar(
      {this.title,
      this.leading,
      this.actions,
      this.centerTitle = false,
      this.elevation});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("${title}"),
      leading: leading,
      actions: actions,
      centerTitle: !centerTitle,
      elevation: elevation!.toDouble(),
    );
  }
}
