import 'package:flutter/material.dart';

class AuthenticationBackground extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var sh = size.height;
    var sw = size.width;
    var paint = Paint();
    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, sw, sh));
    paint.color = Colors.white;
    canvas.drawPath(mainBackground, paint);

    Path greyWave = Path();
    greyWave.lineTo(sw, 0);
    greyWave.lineTo(sw, sh * 0.04);

    greyWave.cubicTo(sw * .2, sh * .15, sw * .65, sh * .1, sw * .6, sh * .23);
    greyWave.cubicTo(sw * .52, sh * .12, sw * .09, sh * .4, 0, sh * .2);

    greyWave.close();
    paint.color = Colors.blue.shade800;
    canvas.drawPath(greyWave, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
