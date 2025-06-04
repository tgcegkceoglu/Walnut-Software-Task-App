import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:walnut_task_app/core/services/token_service.dart';

@immutable
class ApplicationStart {
  const ApplicationStart._();

  // Initializes essential services and configurations before the app runs
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

  
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);

    await TokenService.instance.init();
  }
}
