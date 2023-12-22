import 'package:flutter_modular/flutter_modular.dart';
import 'package:penilaian/app/core/module/application_module.dart';
import 'package:penilaian/app/core/storage/storage_interface.dart';
import 'package:penilaian/app/core/storage/storage_path.dart';
import 'package:penilaian/app/data/models/ktm_model.dart';
import 'package:penilaian/app/data/models/ktp_model.dart';
import 'package:penilaian/app/data/services/local_services/selected_local_services.dart';
import 'package:penilaian/app/modules/home/detail_ktp/detail_ktp_page.dart';
import 'package:penilaian/app/routes/app_routes.dart';

import 'cubit/home_cubit.dart';
import 'home_page.dart';
import 'ktp_scan/cubit/ktp_scan_cubit.dart';
import 'ktp_scan/ktp_scan_page.dart';
import 'ktp_scan/ktp_pick_page.dart';

class HomeModule extends Module {
  @override
  List<Module> get imports => [ApplicationModule()];

  @override
  void binds(i) {
    i.add(HomeCubit.new);
    i.add(KtpScanCubit.new);
    i.addLazySingleton<SelectedLocalServices>(SelectedLocalServicesImpl.new);
    i.addLazySingleton<StoragePathInterface>(StoragePathImpl.new);
    i.addLazySingleton<StorageInterface>(Storage.new);
  }

  @override
  void routes(r) {
    r.child(AppRoutes.home, child: (context) => const HomePage());
    r.child(AppRoutes.ktpScanHome, child: (context) => const KtpScanPage());
    r.child(AppRoutes.ktpPickHome, child: (context) => const KtpPickPage());
    r.child(AppRoutes.ktpResultHome, child: (context) {
      final args = r.args.data as Map<String, dynamic>;
      return DetailKtpPage(
        nikResult: args['item'] as KtmModel,
        docKey: args['key'] as String,
      );
    });
  }
}
