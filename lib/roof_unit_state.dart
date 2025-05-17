
import 'package:flutter/material.dart';

enum Mode { off, fanOnly, humidifier }

enum FanSpeed { low, auto, high }

enum ExternalVent { open, closed }

class RoofUnitState extends ChangeNotifier {
  Mode _mode = Mode.humidifier;
  FanSpeed _fanSpeed = FanSpeed.low;
  ExternalVent _externalVent = ExternalVent.closed;
  int _humidity = 45;
  int _targetHumidity = 60  ;

  Mode get mode => _mode;
  void setMode(Mode mode) {
    _mode = mode;
    notifyListeners();
  }

  FanSpeed get fanSpeed => _fanSpeed;
  void setFanSpeed(FanSpeed speed) {
    _fanSpeed = speed;
    notifyListeners();
  }

  ExternalVent get externalVent => _externalVent;
  void setExternalVent(ExternalVent vent) {
    _externalVent = vent;
    notifyListeners();
  }

  int get humidity => _humidity;
  void setHumidity(int level) {
    _humidity = level;
    notifyListeners();
  }

  int get targetHumidity => _targetHumidity;
  void setTargetHumidity(int level) {
    _targetHumidity = level;
    notifyListeners();
  }
}
