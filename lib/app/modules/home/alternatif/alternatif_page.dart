import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_pagination/firebase_pagination.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:penilaian/app/core/helpers/string_helper.dart';
import 'package:penilaian/app/core/theme/theme.dart';
import 'package:penilaian/app/core/widgets/base/base_app_bar.dart';
import 'package:penilaian/app/core/widgets/base/base_scaffold.dart';
import 'package:penilaian/app/core/widgets/text/no_found_widget.dart';
import 'package:penilaian/app/data/extensions/extensions.dart';
import 'package:penilaian/app/data/models/kriteria_model.dart';
import 'package:penilaian/app/data/models/ktp_model.dart';
import 'package:penilaian/app/data/models/penilaian_model.dart';
import 'package:penilaian/app/data/services/local_services/selected_local_services.dart';
import 'package:penilaian/app/routes/app_routes.dart';
import 'package:penilaian/app/blocs/session/session_cubit.dart';
import 'package:penilaian/app/core/permission/permission.dart';
import 'package:penilaian/app/core/config/app_asset.dart';

import 'widgets/alternatif_card.dart';

class AlternatifPage extends StatefulWidget {
  const AlternatifPage({super.key});

  @override
  State<AlternatifPage> createState() => _AlternatifPageState();
}

class _AlternatifPageState extends State<AlternatifPage> {
  int _currentIndex = 0;

  late final CollectionReference _alternatifRef;
  late final CollectionReference _penilaianRef;
  late final CollectionReference _kriteriaRef;
  late final Reference _storageRef;
  late final String _refKey;

  @override
  void initState() {
    super.initState();
    _refKey = Modular.get<SelectedLocalServices>().selected;
    _alternatifRef = FirebaseFirestore.instance.collection('$_refKey/alternatif');
    _penilaianRef = FirebaseFirestore.instance.collection('$_refKey/nilai');
    _kriteriaRef = FirebaseFirestore.instance.collection('$_refKey/kriteria');
    _storageRef = FirebaseStorage.instance.ref(StringHelper.imageStorage);
  }

  permission() async {
    await Modular.get<PermissionInterface>().camera();
    await Modular.get<PermissionInterface>().storage();
  }

  Future<void> penilaian() async {
    context.showLoadingIndicator();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF7F8FD),
      appBar: AppBar(
        title: Text(
          'FlamScan',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2F4FCD)
          )
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await context.read<SessionCubit>().deleteSession();
            },
            icon: const Icon(Icons.logout_rounded, color: ColorTheme.black),
            tooltip: "Logout",
          ).pOnly(right: 12),
        ],
        titleSpacing: 24,
        backgroundColor: Color(0xffF7F8FD),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(24, 0, 24, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12),
            Text(
              'Recent',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 16),
            Container(
              width: 225,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xffDDDBFF).withOpacity(0.5), width: 1),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xffDDDBFF).withOpacity(0.2),
                    spreadRadius: 0.1,
                    blurRadius: 10,
                    offset: Offset(5, 5),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/img/image1.png',
                    ),
                    Container(
                      padding: EdgeInsets.all(16),
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Scan 01:11:2020 03:57:06',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                            )
                          ),
                          SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Today',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey
                                )
                              ),
                              Text(
                                '1 page',
                                style: TextStyle(
                                  fontSize: 14,
                                )
                              ),
                            ],
                          )
                        ]
                      ),
                    )
                  ],
                ),
              )
            ),
            SizedBox(height: 24),
            Text(
              'Documents',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: FirestorePagination(
                query: _alternatifRef.orderBy('created_at'),
                isLive: true,
                onEmpty: const NoFoundWidget(),
                // separatorBuilder: (p0, p1) => 8.verticalSpacingRadius,
                itemBuilder: (context, snapshot, i) {
                  final data = KtpModel.fromMap(snapshot.data() as Map<Object?, Object?>);
                  return Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: AlternatifCard(
                      number: i + 1,
                      data: data,
                      onDelete: () async {
                        await _alternatifRef.doc(snapshot.id).delete();
                        await _penilaianRef.doc(snapshot.id).delete();
                        // await _storageRef.child('${snapshot.id}.jpg').delete();
                      },
                      onEdit: () async {
                        await Modular.get<SelectedLocalServices>().setSelectedEdit(snapshot.id);
                        Modular.to.pushNamed(AppRoutes.ktpResultHome, arguments: data);
                      },
                      onTap: () async {
                        await Modular.to.pushNamed(AppRoutes.penilaianHome, arguments: snapshot.id);
                        final pen =
                            await _penilaianRef.where('alternatif_id', isEqualTo: snapshot.id).count().get();
                        final kriteria = await _kriteriaRef.count().get();
                        bool filled = pen.count == kriteria.count;
                        await _alternatifRef.doc(snapshot.id).update({'filled': filled});
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: Padding(
      //   padding: 0.all.copyWith(top: 0),
      //   child: Row(
      //     children: [
      //       Expanded(
      //         child: ElevatedButton(
      //           style: ElevatedButton.styleFrom(
      //             backgroundColor: ColorTheme.green,
      //             foregroundColor: Colors.white,
      //             shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.only(
      //                 topLeft: Radius.circular(16.r),
      //                 bottomLeft: Radius.circular(16.r),
      //               ),
      //             ),
      //             textStyle: AppStyles.text16PxMedium,
      //             minimumSize: Size(200.r, 48.r),
      //           ),
      //           onPressed: () {
      //             context.to.pushNamed(AppRoutes.ktpScanHome).then((value) => setState(() {}));
      //           },
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               const Icon(Icons.qr_code_scanner_rounded),
      //               6.horizontalSpaceRadius,
      //               const Text('Tambah'),
      //             ],
      //           ),
      //         ),
      //       ),
      //       12.horizontalSpaceRadius,
      //       Expanded(
      //         child: ElevatedButton(
      //           style: ElevatedButton.styleFrom(
      //             backgroundColor: ColorTheme.primary,
      //             foregroundColor: Colors.white,
      //             shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.only(
      //                 topRight: Radius.circular(16.r),
      //                 bottomRight: Radius.circular(16.r),
      //               ),
      //             ),
      //             textStyle: AppStyles.text16PxMedium,
      //             minimumSize: Size(200.r, 48.r),
      //           ),
      //           onPressed: () {
      //             penilaian();
      //           },
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               const Text('Hitung'),
      //               6.horizontalSpaceRadius,
      //               const Icon(Icons.calculate),
      //             ],
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      bottomNavigationBar: SizedBox(
        height: 100,
        child: BottomNavigationBar(
          backgroundColor: Color(0xFFDDDBFF),
          selectedItemColor: Color(0xff2F4FCD),
          unselectedItemColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (index) {
            if (index == 1) {
              Navigator.of(context).pushNamed(AppRoutes.ktpScanHome).then((value) {
                setState(() {});
              });
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(AppAsset.icon_files)),
              label: 'Files',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(AppAsset.icon_create)),
              label: 'Scan',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(AppAsset.icon_settings)),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
