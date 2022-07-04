import 'package:flutter/material.dart';

import '../theme/theme.dart';

class KeysState {
  KeyStateEnum plu = KeyStateEnum.inactive;
  KeyStateEnum sub = KeyStateEnum.active;
  KeyStateEnum ac = KeyStateEnum.active;
  KeyStateEnum back = KeyStateEnum.inactive;
  KeyStateEnum plusV = KeyStateEnum.active;
  KeyStateEnum minusV = KeyStateEnum.active;
  KeyStateEnum plusP = KeyStateEnum.active;
  KeyStateEnum minusP = KeyStateEnum.active;
  KeyStateEnum multiply = KeyStateEnum.inactive;
  KeyStateEnum one = KeyStateEnum.active;
  KeyStateEnum two = KeyStateEnum.active;
  KeyStateEnum three = KeyStateEnum.active;
  KeyStateEnum four = KeyStateEnum.active;
  KeyStateEnum five = KeyStateEnum.active;
  KeyStateEnum six = KeyStateEnum.active;
  KeyStateEnum seven = KeyStateEnum.active;
  KeyStateEnum eight = KeyStateEnum.active;
  KeyStateEnum nine = KeyStateEnum.active;
  KeyStateEnum doublezero = KeyStateEnum.active;
  KeyStateEnum zero = KeyStateEnum.active;
  KeyStateEnum comma = KeyStateEnum.active;
  KeyStateEnum department = KeyStateEnum.inactive;

  inputState() {
    back = KeyStateEnum.active;
    plu = (sub != KeyStateEnum.hold) ? KeyStateEnum.active : KeyStateEnum.inactive;
    sub = (sub != KeyStateEnum.hold) ? KeyStateEnum.inactive : sub;
    plusV = KeyStateEnum.active;
    minusV = KeyStateEnum.active;
    plusP = KeyStateEnum.active;
    minusP = KeyStateEnum.active;
    multiply = (sub == KeyStateEnum.hold) ? KeyStateEnum.inactive : KeyStateEnum.active;
    department = (sub == KeyStateEnum.hold)
        ? KeyStateEnum.inactive
        : KeyStateEnum.active;
  }

  errorState() {
    back = KeyStateEnum.active;
    plu = KeyStateEnum.inactive;
    sub = (sub != KeyStateEnum.hold) ? KeyStateEnum.inactive : sub;
    plusV = KeyStateEnum.inactive;
    minusV = KeyStateEnum.inactive;
    plusP = KeyStateEnum.inactive;
    minusP = KeyStateEnum.inactive;
    multiply = KeyStateEnum.inactive;
    department = KeyStateEnum.inactive;
  }

  departmentState() {
    back = KeyStateEnum.active;
    plu = KeyStateEnum.inactive;
    sub = (sub != KeyStateEnum.hold) ? KeyStateEnum.inactive : sub;
    plusV = KeyStateEnum.inactive;
    minusV = KeyStateEnum.inactive;
    plusP = KeyStateEnum.inactive;
    minusP = KeyStateEnum.inactive;
    multiply = KeyStateEnum.inactive;
    department = (sub == KeyStateEnum.hold)
        ? KeyStateEnum.inactive
        : KeyStateEnum.active;
  }

  static ButtonStyle stateStyleOrDefault(KeyStateEnum state,
      {ButtonStyle? defaults = null}) {
    switch (state) {
      case KeyStateEnum.inactive:
        return IncassaTheme.inactiveTextButtonStyle;
      case KeyStateEnum.hold:
        return IncassaTheme.holdindTextButtonStyle;
      default:
        return defaults ?? IncassaTheme.lightTextButtonStyle;
    }
  }
}

enum KeyStateEnum { active, inactive, hold }
