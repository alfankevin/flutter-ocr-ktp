import 'dart:io' show Platform;

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:penilaian/app/data/services/local_services/flavor_local_services.dart';

abstract class StoragePathInterface {
  final String temporary;
  final String cache;
  final String document;
  final String external;
  final String externalCache;

  const StoragePathInterface({
    required this.temporary,
    required this.cache,
    required this.document,
    required this.external,
    required this.externalCache,
  });

  StoragePathInterface copyWith({
    String? temporary,
    String? cache,
    String? document,
    String? external,
    String? externalCache,
  });

  Future<StoragePathInterface> initialize();

  String fromTemporary([String? path]);
  String fromCache([String? path]);
  String fromDocument([String? path]);
  String fromExternal([String? path]);
  String fromExternalCache([String? path]);
}

class StoragePathImpl extends StoragePathInterface {
  final FlavorLocalServices app = FlavorLocalServicesImpl();

  StoragePathImpl({
    super.temporary = '',
    super.cache = '',
    super.document = '',
    super.external = '',
    super.externalCache = '',
  });

  @override
  StoragePathInterface copyWith({
    String? temporary,
    String? cache,
    String? document,
    String? external,
    String? externalCache,
  }) =>
      StoragePathImpl(
        temporary: temporary ?? this.temporary,
        cache: cache ?? this.cache,
        document: document ?? this.document,
        external: external ?? this.external,
        externalCache: externalCache ?? this.externalCache,
      );

  @override
  String fromTemporary([String? path]) => p.join(temporary, path);

  @override
  String fromCache([String? path]) => p.join(cache, path);

  @override
  String fromDocument([String? path]) => p.join(document, path);

  @override
  String fromExternal([String? path]) => p.join(external, path);

  @override
  String fromExternalCache([String? path]) => p.join(externalCache, path);

  @override
  Future<StoragePathInterface> initialize() async {
    String temporary = this.temporary;
    String cache = this.cache;
    String document = this.document;
    String external = this.external;
    String externalCache = this.externalCache;

    temporary = (await getTemporaryDirectory()).path;
    cache = (await getApplicationSupportDirectory()).path;
    document = (await getApplicationDocumentsDirectory()).path;

    if (Platform.isAndroid) {
      external = document;
      external = p.join(external, app.name.trim().replaceAll(' ', '-'));
    } else if (Platform.isIOS) {
      external = p.join(document, app.name.trim().replaceAll(' ', '-'));
    }

    externalCache = p.join(external, '.caches');
    print(external);

    return copyWith(
      temporary: temporary,
      cache: cache,
      document: document,
      external: external,
      externalCache: externalCache,
    );
  }

  @override
  String toString() {
    return 'StoragePathInterface{temporary: $temporary, cache: $cache, '
        'document: $document, extenal: $external, externalCache: $externalCache,}';
  }
}
