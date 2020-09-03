import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class BasicListRow extends StatelessWidget {
  final String rowText;
  final GestureTapCallback onTap;

  BasicListRow({
    @required this.rowText,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: onTap,
          child: Column(
            children: <Widget>[
              Container(
                height: 55,
                color: Colors.white,
                child: ListTile(
                  title: Text(
                    rowText,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
              ),
            ],
          ),
        ),
        Divider(
          height: .1,
          color: Colors.black38,
        )
      ],
    );
  }
}
