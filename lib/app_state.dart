import 'package:flutter/material.dart';

enum Mode { off, fanOnly, humidifier }

enum PowerRelay { on, off}

enum FanSpeed { low, auto, high }

enum FanRelay { high, low }

enum ExternalVent { open, closed }

enum ExternalVenRelay { open, closed }

enum DeHumidifierRelay { off, on }

class AppState extends ChangeNotifier {
  Mode _mode = Mode.humidifier;
  FanSpeed _fanSpeed = FanSpeed.low;
  ExternalVent _externalVent = ExternalVent.closed;
  int _humidity = 45;
  int _targetHumidity = 60;

  PowerRelay _powerRelay = PowerRelay.off;
  FanRelay _fanRelay = FanRelay.low;
  ExternalVenRelay _externalVentRelay = ExternalVenRelay.closed;
  DeHumidifierRelay _deHumidifierRelay = DeHumidifierRelay.off;

  void _update() {
    switch (mode) {
      case Mode.off:
        _powerRelay = PowerRelay.off;
        _fanRelay = FanRelay.low;
        _externalVentRelay = ExternalVenRelay.closed;
        _deHumidifierRelay = DeHumidifierRelay.off;
        break;
      case Mode.fanOnly:
        _powerRelay = PowerRelay.on;
        _fanRelay = switch (_fanSpeed) {
          FanSpeed.low => FanRelay.low,
          FanSpeed.auto => FanRelay.low,
          FanSpeed.high => FanRelay.high,
        };
        _externalVentRelay =
            _externalVent == ExternalVent.open
                ? ExternalVenRelay.open
                : ExternalVenRelay.closed;
        _deHumidifierRelay = DeHumidifierRelay.off;
        break;
      case Mode.humidifier:
        _powerRelay = PowerRelay.on;
        _externalVentRelay =
            _externalVent == ExternalVent.open
                ? ExternalVenRelay.open
                : ExternalVenRelay.closed;
        if (humidity > targetHumidity) {
          _fanRelay = switch (_fanSpeed) {
            FanSpeed.low => FanRelay.low,
            FanSpeed.auto => FanRelay.high,
            FanSpeed.high => FanRelay.high,
          };
          _deHumidifierRelay = DeHumidifierRelay.on;
        } else {
          _fanRelay = switch (_fanSpeed) {
            FanSpeed.low => FanRelay.low,
            FanSpeed.auto => FanRelay.low,
            FanSpeed.high => FanRelay.high,
          };
          _deHumidifierRelay = DeHumidifierRelay.off;
        }
    }
    notifyListeners();
  }

  Mode get mode => _mode;
  void setMode(Mode mode) {
    _mode = mode;
    _update();
  }
  void toggleMode(){
    switch(_mode){
      case Mode.off:
        _mode = Mode.fanOnly;
      case Mode.fanOnly:
        _mode = Mode.humidifier;
      case Mode.humidifier:
        _mode = Mode.off;
    }
    _update();    
  }

  FanSpeed get fanSpeed => _fanSpeed;
  void setFanSpeed(FanSpeed speed) {
    _fanSpeed = speed;
    _update();
  }

  void toggleFanSpeed() {
    switch(_fanSpeed){
      case FanSpeed.low:
        _fanSpeed = FanSpeed.auto;
        break;
      case FanSpeed.auto: 
        _fanSpeed = FanSpeed.high;
        break;
      case FanSpeed.high: 
        _fanSpeed = FanSpeed.low;
        break;
    }
    _update();
  }

  ExternalVent get externalVent => _externalVent;
  void setExternalVent(ExternalVent vent) {
    _externalVent = vent;
    _update();
  }

  void toggleExternalVent() {
    if (_externalVent == ExternalVent.open) {
      _externalVent = ExternalVent.closed;
    } else {
      _externalVent = ExternalVent.open;
    }
    _update();
  }

  int get humidity => _humidity;
  void setHumidity(int level) {
    _humidity = level;
    _update();
  }

  int get targetHumidity => _targetHumidity;
  void setTargetHumidity(int level) {
    _targetHumidity = level;
    _update();
  }

  PowerRelay get powerRelay => _powerRelay;
  FanRelay get fanRelay => _fanRelay;
  ExternalVenRelay get externalVentRelay => _externalVentRelay;
  DeHumidifierRelay get deHumidifierRelay => _deHumidifierRelay;


  bool get displayFanSpeed => _mode == Mode.fanOnly || _mode == Mode.humidifier;
  bool get displayExternalVent => mode != Mode.off;
  bool get displayHumifity => _mode == Mode.humidifier;

  String get modalDisplay {
    switch (_mode) {
      case Mode.off:
        return "Unit Off";
      case Mode.fanOnly:
        return "Fan Only";
      case Mode.humidifier:
        if( humidity > targetHumidity){
          return "Dehumidifier Running";
        }
        else{
          return "Dehumidifier Idle";
        }
    }
  }

}
