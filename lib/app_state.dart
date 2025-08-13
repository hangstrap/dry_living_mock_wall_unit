import 'package:flutter/material.dart';
import 'dart:async';

enum Mode { off, fanOnly, humidifierAndFan, humidifierOnly }

enum PowerRelay { on, off }

enum FanSpeed { low, auto, high }

enum FanRelay { high, low }

enum ExternalVent { open, closed }

enum ExternalVenRelay { open, closed }

enum DeHumidifierRelay { off, on }

class AppState extends ChangeNotifier {
  Mode _mode = Mode.off;
  FanSpeed _fanSpeed = FanSpeed.low;
  ExternalVent _externalVent = ExternalVent.closed;
  int _humidity = 45;
  int _targetHumidity = 60;

  PowerRelay _powerRelay = PowerRelay.off;
  FanRelay _fanRelay = FanRelay.low;
  ExternalVenRelay _externalVentRelay = ExternalVenRelay.closed;
  DeHumidifierRelay _deHumidifierRelay = DeHumidifierRelay.off;

  DateTime _simulatedTime = DateTime.now();

  DateTime get simulatedTime => _simulatedTime;

  late final Timer _timer;

  AppState() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _simulatedTime = _simulatedTime.add(const Duration(minutes: 1));
      _update();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

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
      case Mode.humidifierAndFan:
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
      case Mode.humidifierOnly:
        _fanRelay = switch (_fanSpeed) {
          FanSpeed.low => FanRelay.low,
          FanSpeed.auto => FanRelay.low,
          FanSpeed.high => FanRelay.high,
        };
        _externalVentRelay =
            _externalVent == ExternalVent.open
                ? ExternalVenRelay.open
                : ExternalVenRelay.closed;

        final minute = _simulatedTime.minute;
        if (minute < 5) {
          _powerRelay = PowerRelay.on;
          _deHumidifierRelay = DeHumidifierRelay.off;
        } else {
          if (_powerRelay == PowerRelay.on) {
            if (humidity > targetHumidity) {
              _fanRelay = switch (_fanSpeed) {
                FanSpeed.low => FanRelay.low,
                FanSpeed.auto => FanRelay.high,
                FanSpeed.high => FanRelay.high,
              };

              _deHumidifierRelay = DeHumidifierRelay.on;
            } else {
              _deHumidifierRelay = DeHumidifierRelay.off;
              _powerRelay = PowerRelay.off;
              _fanRelay = switch (_fanSpeed) {
                FanSpeed.low => FanRelay.low,
                FanSpeed.auto => FanRelay.low,
                FanSpeed.high => FanRelay.high,
              };
            }
          }
        }
    }
    notifyListeners();
  }

  Mode get mode => _mode;
  void setMode(Mode mode) {
    _mode = mode;
    _update();
  }



  FanSpeed get fanSpeed => _fanSpeed;
  void setFanSpeed(FanSpeed speed) {
    _fanSpeed = speed;
    _update();
  }


  ExternalVent get externalVent => _externalVent;
  void setExternalVent(ExternalVent vent) {
    _externalVent = vent;
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

  bool get displayFanSpeed =>
      _mode == Mode.fanOnly ||
      _mode == Mode.humidifierAndFan ||
      _mode == Mode.humidifierOnly;
  bool get displayExternalVent => mode != Mode.off;
  bool get displayHumifity =>
      _mode == Mode.humidifierAndFan || _mode == Mode.humidifierOnly;

  String get modalDisplay {
    switch (_mode) {
      case Mode.off:
        return "Unit off";
      case Mode.fanOnly:
        return "Fan only";
      case Mode.humidifierAndFan:
        if (humidity > targetHumidity) {
          return "Dehumidifier running";
        } else {
          return "Dehumidifier idle";
        }
      case Mode.humidifierOnly:
        if (_simulatedTime.minute < 5) {
          return "Eco checking humidity";
        } else if (deHumidifierRelay == DeHumidifierRelay.on) {
          return "Eco running";
        } else {
          return "Eco idle";
        }
    }
  }
}
