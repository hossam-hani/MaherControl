import 'package:flutter/material.dart';

const primaryColor = Color(0xFF3498db);
const gray = Color(0xFFB4ACAC);
const gray2 = Color(0xFFE2E2E2);
const gray3 = Color(0xFFDFDFDF);
const grayWhite = Color(0xFFecf0f1);

const blackgrey = Color(0xFF5C5959);

const iconColor = Color(0xFF6F6767);

const shadow = [
                  BoxShadow(
                    color: Color(0xFFf2f2f2),
                    blurRadius: 5.0, // has the effect of softening the shadow
                    spreadRadius: 0.1, // has the effect of extending the shadow
                    offset: Offset(
                      2.0, // horizontal, move right 10
                      6.0, // vertical, move down 10
                    ),
                  ),
                 ];
const shadowTop = [
                  BoxShadow(
                    color: Color(0xFFf2f2f2),
                    blurRadius: 5.0, // has the effect of softening the shadow
                    spreadRadius: 0.1, // has the effect of extending the shadow
                    offset: Offset(
                      0.0, // horizontal, move right 10
                      -4.0, // vertical, move down 10
                    ),
                  ),
                 ];
ShapeBorder shapOFButton = RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(5),
              );