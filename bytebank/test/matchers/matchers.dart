
import 'package:bytebank/main.dart';
import 'package:flutter/material.dart';

bool featureMatcher(Widget widget, nome, icon) {
  if(widget is FeatureItem){
    return (widget.nome == nome &&  widget.icone == icon);
  }

  return false;
}

bool textFieldMatcher(Widget widget, String _textFildMatcher) {
  if (widget is TextField) {
    return widget.decoration.labelText ==  _textFildMatcher;
  }
  return false;
}
