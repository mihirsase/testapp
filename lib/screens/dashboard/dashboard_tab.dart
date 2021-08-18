import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum DashboardTab {
  home,
  album,
  todo,
  profile,
}

extension DashboardTabExtension on DashboardTab {
  static DashboardTab get origin {
    return DashboardTab.home;
  }

  String? get title {
    switch (this) {
      case DashboardTab.home:
        return 'Home';
      case DashboardTab.album:
        return 'Albums';
      case DashboardTab.todo:
        return 'To do list';
      case DashboardTab.profile:
        return 'Profile';
      default:
        return null;
    }
  }

  Widget? get icon {
    switch (this) {
      case DashboardTab.home:
        return SvgPicture.asset("lib/assets/home_icon_active.svg");
      case DashboardTab.album:
        return SvgPicture.asset("lib/assets/album_icon_active.svg");
      case DashboardTab.todo:
        return SvgPicture.asset("lib/assets/todo_icon_active.svg");
      case DashboardTab.profile:
        return SvgPicture.asset("lib/assets/profile_icon_active.svg");
      default:
        return null;
    }
  }

  Widget? get inactiveIcon {
    switch (this) {
      case DashboardTab.home:
        return SvgPicture.asset("lib/assets/home_icon_inactive.svg");
      case DashboardTab.album:
        return SvgPicture.asset("lib/assets/album_icon_inactive.svg");
      case DashboardTab.todo:
        return SvgPicture.asset("lib/assets/todo_icon_inactive.svg");
      case DashboardTab.profile:
        return SvgPicture.asset("lib/assets/profile_icon_inactive.svg");
      default:
        return null;
    }
  }
}
