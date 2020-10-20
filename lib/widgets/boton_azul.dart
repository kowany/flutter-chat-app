import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget {
  final String label;
  final Function onPressed;
  const BotonAzul({
    Key key,
    @required this.label,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 2.0,
      highlightElevation: 5.0,
      color: Colors.blue,
      shape: StadiumBorder(),
      onPressed: onPressed,
      child: Container(
        width: double.infinity,
        height: 55.0,
        child: Center(
          child: Text(
            this.label,
            style: TextStyle(color: Colors.white, fontSize: 17.0),
          ),
        ),
      ),
    );
  }
}
