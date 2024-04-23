import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:getwidget/components/dropdown/gf_dropdown.dart';
import 'package:itckfa/contants.dart';

class dropdown_shape_of_land extends StatefulWidget {
  const dropdown_shape_of_land({super.key});

  @override
  State<dropdown_shape_of_land> createState() => _dropdown_shape_of_landState();
}

class _dropdown_shape_of_landState extends State<dropdown_shape_of_land> {
  final String dropdownValue = 'koko';
  late List<dynamic> _list = [];
  @override
  void initState() {
    super.initState();

    _list = [
      {
        "shape_of_land": 1,
        "shape_of_land_name": RPSCustomPainter1(),
      },
      {
        "shape_of_land": 2,
        "shape_of_land_name": RPSCustomPainter2(),
      },
      {
        "shape_of_land": 3,
        "shape_of_land_name": RPSCustomPainter3(),
      },
      {
        "shape_of_land": 4,
        "shape_of_land_name": RPSCustomPainter4(),
      },
      {
        "shape_of_land": 5,
        "shape_of_land_name": RPSCustomPainter5(),
      },
      {
        "shape_of_land": 6,
        "shape_of_land_name": RPSCustomPainter6(),
      },
      {
        "shape_of_land": 7,
        "shape_of_land_name": RPSCustomPainter7(),
      },
      {
        "shape_of_land": 8,
        "shape_of_land_name": RPSCustomPainter8(),
      },
      {
        "shape_of_land": 9,
        "shape_of_land_name": RPSCustomPainter9(),
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 57,
      margin: EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: DropdownButtonFormField<String>(
          isExpanded: true,
          //value: genderValue,
          onTap: () {
            setState(() {});
          },
          onChanged: (newValue) {
            setState(() {});
          },

          items: _list
              .map<DropdownMenuItem<String>>(
                (value) => DropdownMenuItem<String>(
                  value: value["shape_of_land"].toString(),
                  child: CustomPaint(
                    size: Size(60, (60 * 0.5833333333333334).toDouble()),
                    painter: value["shape_of_land_name"],
                  ),
                ),
              )
              .toList(),
          // add extra sugar..
          icon: Icon(
            Icons.arrow_drop_down,
            color: kImageColor,
          ),

          decoration: InputDecoration(
            filled: true,
            contentPadding: EdgeInsets.symmetric(vertical: 8),
            fillColor: Colors.white,
            labelText: 'Sharp Property',
            hintText: 'Select one',
            labelStyle: TextStyle(color: kPrimaryColor),
            prefixIcon: Icon(
              Icons.shape_line_outlined,
              color: kImageColor,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: kPrimaryColor, width: 2.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: kPrimaryColor,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: kerror,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 5,
                color: kerror,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ),
    );
  }
}

class RPSCustomPainter1 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    Paint paint_fill_0 = Paint()
      ..color = const Color.fromARGB(0, 255, 255, 255)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(size.width * -0.0041812, size.height * -0.0001022);
    path_0.lineTo(size.width * 1.0010724, size.height * -0.0001022);
    path_0.lineTo(size.width * 1.0027500, size.height * 0.9981956);
    path_0.lineTo(size.width * -0.0041812, size.height * 1.0010714);
    path_0.lineTo(size.width * -0.0041812, size.height * -0.0001022);
    path_0.close();

    canvas.drawPath(path_0, paint_fill_0);

    // Layer 1

    Paint paint_stroke_0 = Paint()
      ..color = const Color.fromARGB(200, 7, 9, 145)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.03
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_0, paint_stroke_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class RPSCustomPainter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    Paint paint_fill_0 = Paint()
      ..color = const Color.fromARGB(0, 255, 255, 255)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(size.width * 0.1672750, size.height * -0.0012286);
    path_0.lineTo(size.width * 1.0010737, size.height * 0.0006672);
    path_0.lineTo(size.width * 0.8309583, size.height * 0.9982000);
    path_0.lineTo(size.width * -0.0034074, size.height * 1.0010714);
    path_0.lineTo(size.width * 0.1672750, size.height * -0.0012286);
    path_0.close();

    canvas.drawPath(path_0, paint_fill_0);

    // Layer 1

    Paint paint_stroke_0 = Paint()
      ..color = const Color.fromARGB(200, 7, 9, 145)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.03
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_0, paint_stroke_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class RPSCustomPainter3 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    Paint paint_fill_0 = Paint()
      ..color = const Color.fromARGB(0, 7, 9, 145)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(size.width * -0.0034083, size.height * 0.0025714);
    path_0.lineTo(size.width * 1.0010737, size.height * 0.0006672);
    path_0.lineTo(size.width * 0.8320667, size.height * 1.0001000);
    path_0.lineTo(size.width * 0.1684083, size.height * 0.9991714);
    path_0.lineTo(size.width * -0.0034083, size.height * 0.0025714);
    path_0.close();

    canvas.drawPath(path_0, paint_fill_0);

    // Layer 1

    Paint paint_stroke_0 = Paint()
      ..color = const Color.fromARGB(200, 7, 9, 145)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.03
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_0, paint_stroke_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class RPSCustomPainter4 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    Paint paint_fill_0 = Paint()
      ..color = Color.fromARGB(0, 7, 9, 145)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(size.width * 0.0010250, size.height * 0.4188143);
    path_0.lineTo(size.width * 1.0010737, size.height * 0.0006672);
    path_0.lineTo(size.width * 0.9994250, size.height * 0.9982000);
    path_0.lineTo(size.width * 0.0010000, size.height * 0.9991714);
    path_0.lineTo(size.width * 0.0010250, size.height * 0.4188143);
    path_0.close();

    canvas.drawPath(path_0, paint_fill_0);

    // Layer 1

    Paint paint_stroke_0 = Paint()
      ..color = const Color.fromARGB(200, 7, 9, 145)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.03
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_0, paint_stroke_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class RPSCustomPainter5 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    Paint paint_fill_0 = Paint()
      ..color = const Color.fromARGB(0, 7, 9, 145)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(size.width * 0.4188167, size.height * -0.0004714);
    path_0.lineTo(0, size.height * 0.3557143);
    path_0.lineTo(0, size.height * 0.9985714);
    path_0.lineTo(size.width * 0.9991667, size.height * 1.0028571);
    path_0.lineTo(size.width, 0);
    path_0.lineTo(size.width * 0.4188167, size.height * -0.0004714);
    path_0.close();

    canvas.drawPath(path_0, paint_fill_0);

    // Layer 1

    Paint paint_stroke_0 = Paint()
      ..color = const Color.fromARGB(200, 7, 9, 145)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.03
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_0, paint_stroke_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class RPSCustomPainter6 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    Paint paint_fill_0 = Paint()
      ..color = const Color.fromARGB(0, 7, 9, 145)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(size.width * 0.3346167, size.height * -0.0057000);
    path_0.lineTo(size.width * 0.3340583, size.height * 0.5028429);
    path_0.lineTo(0, size.height * 0.4971429);
    path_0.lineTo(size.width * 0.0008333, size.height);
    path_0.lineTo(size.width, size.height);
    path_0.lineTo(size.width * 1.0011083, size.height * 0.4938286);
    path_0.lineTo(size.width * 0.6274917, size.height * 0.4985571);
    path_0.lineTo(size.width * 0.6266667, 0);
    path_0.lineTo(size.width * 0.3346167, size.height * -0.0057000);
    path_0.close();

    canvas.drawPath(path_0, paint_fill_0);

    // Layer 1

    Paint paint_stroke_0 = Paint()
      ..color = const Color.fromARGB(200, 7, 9, 145)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.03
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_0, paint_stroke_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class RPSCustomPainter7 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    Paint paint_fill_0 = Paint()
      ..color = const Color.fromARGB(0, 7, 9, 145)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(size.width * 0.5000000, size.height * 0.0014286);
    path_0.lineTo(size.width * 0.0008333, size.height);
    path_0.lineTo(size.width * 0.9991667, size.height);
    path_0.lineTo(size.width * 0.5000000, size.height * 0.0014286);
    path_0.close();

    canvas.drawPath(path_0, paint_fill_0);

    // Layer 1

    Paint paint_stroke_0 = Paint()
      ..color = const Color.fromARGB(200, 7, 9, 145)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.03
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_0, paint_stroke_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class RPSCustomPainter8 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    Paint paint_fill_0 = Paint()
      ..color = const Color.fromARGB(0, 7, 9, 145)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(size.width * 0.2908333, size.height * -0.0014286);
    path_0.lineTo(size.width * 0.2908333, size.height * 0.9985714);
    path_0.lineTo(size.width * 0.7075000, size.height * 0.9985714);
    path_0.lineTo(size.width * 0.7091667, 0);
    path_0.lineTo(size.width * 0.2908333, size.height * -0.0014286);
    path_0.close();

    canvas.drawPath(path_0, paint_fill_0);

    // Layer 1

    Paint paint_stroke_0 = Paint()
      ..color = const Color.fromARGB(200, 7, 9, 145)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.03
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_0, paint_stroke_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class RPSCustomPainter9 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    Paint paint_fill_0 = Paint()
      ..color = const Color.fromARGB(0, 7, 9, 145)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(size.width * 0.2510083, size.height * -0.0004714);
    path_0.lineTo(0, size.height * 0.0014286);
    path_0.lineTo(0, size.height);
    path_0.lineTo(size.width, size.height);
    path_0.lineTo(size.width * 0.9991667, size.height * 0.0014286);
    path_0.lineTo(size.width * 0.7503833, size.height * 0.0033286);
    path_0.lineTo(size.width * 0.7503833, size.height * 0.5039143);
    path_0.lineTo(size.width * 0.2507250, size.height * 0.5048714);
    path_0.lineTo(size.width * 0.2510083, size.height * -0.0004714);
    path_0.close();

    canvas.drawPath(path_0, paint_fill_0);

    // Layer 1

    Paint paint_stroke_0 = Paint()
      ..color = const Color.fromARGB(200, 7, 9, 145)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.03
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_0, paint_stroke_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
