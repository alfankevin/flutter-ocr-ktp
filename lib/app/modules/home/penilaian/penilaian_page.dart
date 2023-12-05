import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penilaian/app/core/widgets/base/base_app_bar.dart';
import 'package:penilaian/app/core/widgets/base/base_loading_indicator.dart';
import 'package:penilaian/app/core/widgets/base/base_scaffold.dart';
import 'package:penilaian/app/data/models/kriteria_model.dart';
import 'package:penilaian/app/data/models/penilaian_model.dart';
import 'package:penilaian/app/data/services/local_services/selected_local_services.dart';

import 'widgets/penilaian_form_card.dart';

class PenilaianPage extends StatefulWidget {
  const PenilaianPage({super.key});

  @override
  State<PenilaianPage> createState() => _PenilaianPageState();
}

class _PenilaianPageState extends State<PenilaianPage> {
  late final String _refKey;
  late final DatabaseReference _penilaianRef;
  late final DatabaseReference _kriteriaRef;
  bool filledAll = true;

  @override
  void initState() {
    super.initState();
    _refKey = Modular.get<SelectedLocalServices>().selected;
    _penilaianRef = FirebaseDatabase.instance.ref('$_refKey/penilaian');
    _kriteriaRef = FirebaseDatabase.instance.ref('$_refKey/kriteria');
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: const BaseAppBar(
        title: 'Penilaian',
      ),
      body: FutureBuilder(
          future: _penilaianRef.once(),
          builder: (context, snapshot) {
            final Map<String, num> inputs = {};
            if (snapshot.hasData) {
              if (snapshot.data!.snapshot.exists && snapshot.data?.snapshot.value is Map) {
                final stream = snapshot.data?.snapshot.value as Map<Object?, dynamic>;
                stream.forEach((key, value) {
                  final val = value as Map<dynamic, dynamic>;
                  inputs[key as String] = val['nilai'] ?? 0;
                });
              }
              return FirebaseAnimatedList(
                query: _kriteriaRef.orderByChild('created_at'),
                itemBuilder: (context, snap, animation, index) {
                  final data = KriteriaModel.fromMap(snap.value as Map<Object?, Object?>);
                  return PenilaianFormCard(
                    label: data.name,
                    value: inputs[snap.key!].toString(),
                    onChanged: (value) {
                      PenilaianModel model =
                          PenilaianModel.initial(snap.key!, double.tryParse(value) ?? 0);
                      _penilaianRef.child(snap.key!).set(model.toJson());
                    },
                  );
                },
              );
            } else {
              return const BaseLoadingIndicator();
            }
          }),
    );
  }
}
