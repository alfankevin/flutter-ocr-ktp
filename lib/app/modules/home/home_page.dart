import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_pagination/firebase_pagination.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart' show Modular;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:penilaian/app/blocs/session/session_cubit.dart';
import 'package:penilaian/app/core/permission/permission.dart';
import 'package:penilaian/app/core/theme/theme.dart';
import 'package:penilaian/app/core/widgets/base/base_app_bar.dart';
import 'package:penilaian/app/core/widgets/base/base_scaffold.dart';
import 'package:penilaian/app/core/widgets/text/no_found_widget.dart';
import 'package:penilaian/app/data/extensions/extensions.dart';
import 'package:penilaian/app/data/models/data_model.dart';
import 'package:penilaian/app/data/services/local_services/selected_local_services.dart';
import 'package:penilaian/app/routes/app_routes.dart';
import 'package:penilaian/app/data/models/ktp_model.dart';
import 'package:penilaian/app/core/config/app_asset.dart';
import 'package:penilaian/app/modules/home/ktp_scan/cubit/ktp_scan_cubit.dart';
import 'package:penilaian/app/core/widgets/camera_overlay/camera_overlay_widget.dart';
import 'package:penilaian/app/core/storage/storage_interface.dart';

import 'cubit/home_cubit.dart';
import 'widgets/home_card.dart';
import 'alternatif/widgets/alternatif_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  String file = '';

  final KtpScanCubit bloc = Modular.get<KtpScanCubit>();
  OverlayFormat format = OverlayFormat.cardID2;
  final storage = Modular.get<StorageInterface>();

  final controller = Modular.get<HomeCubit>();
  late final CollectionReference _penilaianRef;
  late final CollectionReference _alternatifRef;
  late final CollectionReference _kriteriaRef;
  late final String _refKey;
  late final User user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser!;
    _refKey = Modular.get<SelectedLocalServices>().selected;
    _alternatifRef = FirebaseFirestore.instance.collection('$_refKey/alternatif');
    _penilaianRef = FirebaseFirestore.instance.collection('$_refKey/nilai');
    _kriteriaRef = FirebaseFirestore.instance.collection('$_refKey/kriteria');
    permission();
  }

  permission() async {
    await Modular.get<PermissionInterface>().camera();
    await Modular.get<PermissionInterface>().storage();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Color.fromRGBO(0,0,0,0.25),
      builder: (BuildContext context) {
        return Stack(
          children: [
            Positioned(
              bottom: 120,
              left: 30,
              right: MediaQuery.of(context).size.width / 2 + 7.5,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.ktpScanHome).then((value) {
                    setState(() {});
                  });
                },
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color(0xffF7F8FD),
                    borderRadius: BorderRadius.circular(16)
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/img/camera.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 120,
              right: 30,
              left: MediaQuery.of(context).size.width / 2 + 7.5,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.ktpPickHome).then((value) {
                    setState(() {});
                  });
                },
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color(0xffF7F8FD),
                    borderRadius: BorderRadius.circular(16)
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/img/gallery.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _recentContainer(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: Stack(
        children: [
          Positioned(
            top: 20,
            right: 0,
            bottom: 20,
            child: Container(
              width: 175,
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
                      'assets/img/image3.png',
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(16),
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Scan 01:11:2020 03:57:06',
                              style: TextStyle(
                                fontSize: 12,
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
                                    fontSize: 10,
                                    color: Colors.grey
                                  )
                                ),
                                Text(
                                  '1 page',
                                  style: TextStyle(
                                    fontSize: 10,
                                  )
                                ),
                              ],
                            )
                          ]
                        ),
                      ),
                    )
                  ],
                ),
              )
            ),
          ),
          Positioned(
            top: 10,
            left: MediaQuery.of(context).size.width / 2 - 110,
            right: MediaQuery.of(context).size.width / 2 - 150,
            bottom: 10,
            child: Container(
              width: 200,
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
                      'assets/img/image2.png',
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(16),
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Scan 20:02:2021 01:36:43',
                              style: TextStyle(
                                fontSize: 14,
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
                                    fontSize: 12,
                                    color: Colors.grey
                                  )
                                ),
                                Text(
                                  '1 page',
                                  style: TextStyle(
                                    fontSize: 12,
                                  )
                                ),
                              ],
                            )
                          ]
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            child: Container(
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
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(16),
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                      ),
                    ),
                  ],
                ),
              )
            ),
          ),
        ],
      ),
    );
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
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: IconButton(
              icon: Image.asset(
                'assets/img/search.png',
                height: 24,
              ),
              onPressed: () async {
                await context.read<SessionCubit>().deleteSession();
              },
            ),
          )
        ],
        titleSpacing: 30,
        backgroundColor: Color(0xffF7F8FD),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
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
            _recentContainer(context),
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
              _showDialog(context);
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