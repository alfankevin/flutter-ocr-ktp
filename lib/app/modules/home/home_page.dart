import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:penilaian/app/core/theme/theme.dart';
import 'package:penilaian/app/core/widgets/base/base_app_bar.dart';
import 'package:penilaian/app/core/widgets/base/base_scaffold.dart';
import 'package:penilaian/app/data/extensions/extensions.dart';
import 'package:penilaian/app/data/models/data_model.dart';
import 'package:penilaian/app/data/services/local_services/selected_local_services.dart';
import 'package:penilaian/app/routes/app_routes.dart';

import 'cubit/home_cubit.dart';
import 'widgets/home_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Modular.get<HomeCubit>();
  String file = '';
  late final DatabaseReference _penilaianRef;
  late final User user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser!;
    _penilaianRef = FirebaseDatabase.instance.ref('data/${user.uid}');
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: const BaseAppBar(
        title: "Beranda",
        isBack: false,
      ),
      body: FirebaseAnimatedList(
        sort: (a, b) => (DataModel.fromMap(a.value as Map<Object?, Object?>).createdAt)
            .compareTo(DataModel.fromMap(b.value as Map<Object?, Object?>).createdAt),
        query: _penilaianRef,
        itemBuilder: (context, snapshot, anim, i) {
          final data = DataModel.fromMap(snapshot.value as Map<Object?, Object?>);
          return HomeCard(
            title: data.name,
            subTitle: data.deskripsi,
            color: data.color,
            onDelete: () {
              _penilaianRef.child(snapshot.key!).remove();
            },
            onChange: () {
              showDialog(
                context: context,
                builder: (context) {
                  final nameCont = TextEditingController(text: data.name);
                  final textCont = TextEditingController(text: data.deskripsi);

                  return AlertDialog(
                    title: const Text('Ubah data'),
                    content: IntrinsicHeight(
                      child: Column(
                        children: [
                          TextField(
                            decoration: GenerateTheme.inputDecoration("Nama Jenis"),
                            style: AppStyles.text16Px.copyWith(color: ColorTheme.black),
                            controller: nameCont,
                          ),
                          16.verticalSpacingRadius,
                          TextField(
                            maxLines: 4,
                            decoration: GenerateTheme.inputDecoration("Deskripsi"),
                            style: AppStyles.text16Px.copyWith(color: ColorTheme.black),
                            controller: textCont,
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          final model = data.copyWith(
                            name: nameCont.text,
                            deskripsi: textCont.text,
                            color: data.color,
                          );
                          _penilaianRef
                              .child(snapshot.key!)
                              .set(model.toMap())
                              .then((value) => Modular.to.pop());
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.save_rounded),
                            Text('Simpan'),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            onTap: () async {
              final key = snapshot.key!;
              await Modular.get<SelectedLocalServices>().setSelected("data/${user.uid}/$key");
              Modular.to.pushNamed(AppRoutes.kriteriaHome);
            },
          ).py(8);
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Tambah data',
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              final nameCont = TextEditingController();
              final textCont = TextEditingController();

              return AlertDialog(
                title: const Text('Tambah data'),
                content: IntrinsicHeight(
                  child: Column(
                    children: [
                      TextField(
                        decoration: GenerateTheme.inputDecoration("Nama Jenis"),
                        style: AppStyles.text16Px.copyWith(color: ColorTheme.black),
                        controller: nameCont,
                      ),
                      16.verticalSpacingRadius,
                      TextField(
                        maxLines: 4,
                        decoration: GenerateTheme.inputDecoration("Deskripsi"),
                        style: AppStyles.text16Px.copyWith(color: ColorTheme.black),
                        controller: textCont,
                      ),
                    ],
                  ),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      final data = DataModel.initial(nameCont.text, textCont.text, 6.randColor);
                      _penilaianRef.push().set(data.toMap()).then((value) => Modular.to.pop());
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.save_rounded),
                        Text('Simpan'),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
        // child: const Icon(Icons.qr_code_scanner_rounded),
        child: const Icon(
          Icons.add_circle_outline_outlined,
          size: 30,
        ),
      ),
    );
  }
}
