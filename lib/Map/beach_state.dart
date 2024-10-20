import 'package:flutter/material.dart';
import 'package:shoreguard/Map/services.dart';

class BeachState extends ChangeNotifier {
  Beach? _selectedBeach;

  Beach? get selectedBeach => _selectedBeach;

  void setSelectedBeach(Beach beach) {
    _selectedBeach = beach;
    notifyListeners();
  }

  void clear() {
    _selectedBeach = null;
    notifyListeners();
  }
}