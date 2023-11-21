import 'package:flutter/material.dart';
import 'package:penilaian/app/core/widgets/text/header_title.dart';

import '../../../core/widgets/base/base_scaffold.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: Column(
        children: <Widget>[
          const HeaderTitle(title: 'Register'),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
            child: const Text('Daftar'),
          ),
        ],
      ),
    );
  }
}
