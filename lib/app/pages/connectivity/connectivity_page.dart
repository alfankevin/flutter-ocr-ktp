import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:penilaian/app/data/extensions/extensions.dart';

import 'cubit/connectivity_cubit.dart';
import 'cubit/connectivity_state.dart';

class ConnectivityPage extends StatefulWidget {
  const ConnectivityPage({super.key});

  @override
  State<ConnectivityPage> createState() => _ConnectivityPageState();
}

class _ConnectivityPageState extends State<ConnectivityPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectivityCubit, ConnectivityState>(
      listener: (context, state) {
        if (state is ConnectivityHasInternetState) {
          context.to.pop();
        }
      },
      child: PopScope(
        canPop: false,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "No Internet Connection",
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text(
                    "Your connection appears to be offline\n Try to refresh the page",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                    width: 173,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () => context
                          .read<ConnectivityCubit>()
                          .recheckInternetConnection(),
                      child: const Text(
                        "Try Again",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
