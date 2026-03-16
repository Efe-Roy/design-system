import 'package:design_system/app/app.dart';
import 'package:design_system/blocs/theme/gb_theme_cubit.dart';
import 'package:design_system/gitit/gitit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await getItInit();

  runApp(BlocProvider(create: (context) => ThemeCubit(), child: const App()));
}
