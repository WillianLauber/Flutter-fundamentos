
import 'package:bytebank/main.dart';
import 'package:flutter/material.dart';

bool featureMatcher(Widget widget, nome, icon) {
  if(widget is FeatureItem){
    return (widget.nome == nome &&  widget.icone == icon);
  }

  return false;
}