import 'package:fl/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDropdown extends StatefulWidget {
  final String text;

  const CustomDropdown({Key key, @required this.text}) : super(key: key);

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  GlobalKey actionKey;
  double height, width, xPos, yPos;
  bool isOpened = false;
  OverlayEntry floatingDropdown;

  @override
  void initState() {
    actionKey = LabeledGlobalKey(widget.text);
    super.initState();
  }

  void showDropdownData() {
    RenderBox renderBox = actionKey.currentContext.findRenderObject();
    height = renderBox.size.height;
    width = renderBox.size.width;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    xPos = offset.dx;
    yPos = offset.dy;
  }

  OverlayEntry _createFloatingDropdown() {
    return OverlayEntry(builder: (context) {
      return Positioned(
        top: yPos + height,
        left: xPos,
        width: width,
        height: 2 * height,
        child: Dropdown(
          itemHeight: height,
        ),
      );
    });
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      key: actionKey,
      onTap: () {
        setState(() {
          if (isOpened) {
            floatingDropdown.remove();
          } else {
            showDropdownData();
            floatingDropdown = _createFloatingDropdown();
            Overlay.of(context).insert(floatingDropdown);
          }

          isOpened = !isOpened;
        });
      },
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          width: size.width * 0.69,
          //height: size.height * 0.062,
          height: 51,
          decoration: BoxDecoration(
            color: aPrimaryLightColor,
            borderRadius: BorderRadius.circular(29),
          ),
          child: Row(
            children: <Widget>[
              Text(
                widget.text,
                style: TextStyle(
                  fontFamily: GoogleFonts.raleway(fontWeight: FontWeight.w600)
                      .fontFamily,
                  fontSize: 13,
                  color: aPrimaryColor,
                ),
              ),
              Spacer(),
              Icon(
                Icons.arrow_drop_down_rounded,
                size: 25.0,
                color: aPrimaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Dropdown extends StatelessWidget {
  final double itemHeight;

  const Dropdown({Key key, this.itemHeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 2 * itemHeight,
          decoration: BoxDecoration(
            color: aPrimaryLightColor,
            borderRadius: BorderRadius.circular(29),
          ),
          child: Column(
            children: <Widget>[
              DropdownItem(
                text: "Dog",
              ),
              DropdownItem(
                text: "Cat",
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DropdownItem extends StatelessWidget {
  final String text;
  final bool isSelected;

  const DropdownItem({Key key, this.text, this.isSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.69,
      //height: size.height * 0.062,
      height: 51,
      decoration: BoxDecoration(
        color: aPrimaryLightColor,
        borderRadius: BorderRadius.circular(29),
      ),
      child: Row(
        children: <Widget>[
          Text(
            text,
            style: TextStyle(
              fontFamily:
                  GoogleFonts.raleway(fontWeight: FontWeight.w300).fontFamily,
              fontSize: 13,
              color: aPrimaryColor,
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
