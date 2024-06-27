// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;
import 'package:online_test/data/model/contact_model.dart' as _i5;
import 'package:online_test/presentation/contact/ui/contact_screen.dart' as _i2;
import 'package:online_test/presentation/contact_manage/ui/contact_manage_screen.dart'
    as _i1;

abstract class $AppAutoRouter extends _i3.RootStackRouter {
  $AppAutoRouter({super.navigatorKey});

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    ContactManageRoute.name: (routeData) {
      final args = routeData.argsAs<ContactManageRouteArgs>();
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.ContactManageScreen(
          key: args.key,
          contact: args.contact,
          manageType: args.manageType,
        ),
      );
    },
    ContactRoute.name: (routeData) {
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.ContactScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.ContactManageScreen]
class ContactManageRoute extends _i3.PageRouteInfo<ContactManageRouteArgs> {
  ContactManageRoute({
    _i4.Key? key,
    _i5.ContactModel? contact,
    required String manageType,
    List<_i3.PageRouteInfo>? children,
  }) : super(
          ContactManageRoute.name,
          args: ContactManageRouteArgs(
            key: key,
            contact: contact,
            manageType: manageType,
          ),
          initialChildren: children,
        );

  static const String name = 'ContactManageRoute';

  static const _i3.PageInfo<ContactManageRouteArgs> page =
      _i3.PageInfo<ContactManageRouteArgs>(name);
}

class ContactManageRouteArgs {
  const ContactManageRouteArgs({
    this.key,
    this.contact,
    required this.manageType,
  });

  final _i4.Key? key;

  final _i5.ContactModel? contact;

  final String manageType;

  @override
  String toString() {
    return 'ContactManageRouteArgs{key: $key, contact: $contact, manageType: $manageType}';
  }
}

/// generated route for
/// [_i2.ContactScreen]
class ContactRoute extends _i3.PageRouteInfo<void> {
  const ContactRoute({List<_i3.PageRouteInfo>? children})
      : super(
          ContactRoute.name,
          initialChildren: children,
        );

  static const String name = 'ContactRoute';

  static const _i3.PageInfo<void> page = _i3.PageInfo<void>(name);
}
