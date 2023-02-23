
import 'package:flutter/cupertino.dart';

import 'fonts_manager.dart';

TextStyle _getTextStyle({required Color color , required double fontSize,required FontWeight fontWeight}){
  return TextStyle(
    color: color,
  fontSize: fontSize,
    fontWeight: fontWeight,
  );
}
// Regular Style
TextStyle getRegularStyle({required Color color ,double fontSize = FontSize.s16 }){
  return _getTextStyle(color: color, fontSize: fontSize, fontWeight: FontsWeightManager.regular);
}

// Medium Style
TextStyle getMediumStyle({required Color color ,double fontSize = FontSize.s14 }){
  return _getTextStyle(color: color, fontSize: fontSize, fontWeight: FontsWeightManager.medium);
}

// Bold Style
TextStyle getBoldStyle({required Color color ,double fontSize = FontSize.s24 }){
  return _getTextStyle(color: color, fontSize: fontSize, fontWeight: FontsWeightManager.bold);
}

// Italic
TextStyle getItalicStyle({required Color color ,double fontSize = FontSize.s12 }){
  return _getTextStyle(color: color, fontSize: fontSize, fontWeight: FontsWeightManager.italic);
}
