import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final String titulo;
  const Logo({
    Key key,
    @required this.titulo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 170.0,
        margin: EdgeInsets.only(top: 50.0),
        child: Column(
          children: [
            Image(image: AssetImage('assets/tag-logo.png')),
            Text(
              this.titulo,
              style: TextStyle(fontSize: 30.0),
            ),
          ],
        ),
      ),
    );
  }
}
