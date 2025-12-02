import 'package:design_system/app/app.dart';
import 'package:design_system/blocs/theme/theme_cubit.dart';
import 'package:design_system/gitit/gitit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await getItInit(); // sets up locator/navigatorKey etc.

  runApp(
    BlocProvider(
      create: (context) => ThemeCubit(),
      child: const App(),
    ),
  );
}