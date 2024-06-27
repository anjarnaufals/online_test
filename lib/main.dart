import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_test/presentation/contact/cubit/contact_cubit.dart';
import 'package:online_test/routes/app_auto_routes.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  static final AppAutoRouter router = AppAutoRouter();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (_) => ContactCubit(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router.config(),
      ),
    );
  }
}
