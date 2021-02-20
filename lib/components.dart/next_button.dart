import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  final Function nextPage;
  NextButton(this.nextPage);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
      margin: EdgeInsets.all(10),
      child: RaisedButton(
        onPressed: () {
          nextPage();
        },
        color: Theme.of(context).accentColor,
        child: Padding(
          padding: EdgeInsets.all(0),
          child: Container(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
