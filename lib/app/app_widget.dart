import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:penilaian/app/data/extensions/extensions.dart';
import 'package:penilaian/app/blocs/session/session_cubit.dart';
import 'package:penilaian/app/pages/connectivity/cubit/connectivity_cubit.dart';
import 'package:penilaian/app/pages/connectivity/cubit/connectivity_state.dart';

import 'core/theme/theme.dart';
import 'routes/app_routes.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final messengerKey = GlobalKey<ScaffoldMessengerState>();
    final sessionBloc = SessionCubit();
    Modular.setInitialRoute('/');

    return MultiBlocProvider(
      providers: [
        BlocProvider<ConnectivityCubit>(create: (context) => Modular.get<ConnectivityCubit>()),
        BlocProvider(create: (context) => sessionBloc),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<ConnectivityCubit, ConnectivityState>(
            listener: (context, state) {
              if (state is ConnectivityNoInternetState) {
                context.to.pushNamed(AppRoutes.NO_INTERNET);
              }
            },
          ),
          BlocListener<SessionCubit, SessionState>(
            listener: (context, state) {
              if (state is SessionReadyState) {
                // var app = locator.get<App>();

                // Todo: rollbar
              }

              if (state is SessionUnAuthorizedTokenState) {
                sessionBloc.deleteSession();
                context.to.pushNamedAndRemoveUntil(AppRoutes.LOGIN, (route) => false);
              }
            },
          ),
        ],
        child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          builder: (_, child) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              scaffoldMessengerKey: messengerKey,
              title: 'Pemilihan Batuan Sosial',
              theme: colorTheme,
              routeInformationParser: Modular.routeInformationParser,
              routerDelegate: Modular.routerDelegate,
            );
          },
        ),
      ),
    );
  }
}
