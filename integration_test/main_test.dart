import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:testing_app/main.dart' as app;
//import 'package:shared_preferences/shared_preferences.dart';

import 'scripts/app_test.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;
  testWidgets('Login and create new request', (tester) async {
    app.main();
    //await SharedPreferences.getInstance().then((value) => value.clear());
    await tester.pumpAndSettle(const Duration(seconds: 1));
    //Login
    await SampleTest().execute(tester);
  });
}
