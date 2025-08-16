import '../app_state.dart';

extension ModeDisplay on Mode {
  String get displayName {
    switch (this) {
      case Mode.off:
        return "Off";
      case Mode.fanOnly:
        return "Fan Only";
      case Mode.humidifierAndFan:
        return "Dehumidifier and Fan";
      case Mode.humidifierOnly:
        return "Dehumidifier Only";
    }
  }
}

extension FanSpeedDisplay on FanSpeed {
  String get displayName {
    switch (this) {
      case FanSpeed.low:
        return "Low";
      case FanSpeed.auto:
        return "Auto";
      case FanSpeed.high:
        return "High";
    }
  }
}

extension ExternalVentDisplay on ExternalVent {
  String get displayName {
    switch (this) {
      case ExternalVent.open:
        return "Open";
      case ExternalVent.closed:
        return "Closed";
    }
  }
}