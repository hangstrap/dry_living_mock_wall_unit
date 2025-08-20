enum DisplayEnum {
  home,
  editMenu,
  mode,
  fanSpeed,
  externalVent,
  targetHumidity,
  infoMenu,
  version,
  contact
}
extension DisplayEnumUsage on DisplayEnum {
  bool get isEditable {
    switch (this) {
      case DisplayEnum.mode:
      case DisplayEnum.fanSpeed:
      case DisplayEnum.externalVent:
      case DisplayEnum.targetHumidity:
        return true;
      default:
        return false;
    }
  }

  bool get isInfo {
    switch (this) {
      case DisplayEnum.version:
      case DisplayEnum.contact:
        return true;
      default:
        return false;
    }
  }
}