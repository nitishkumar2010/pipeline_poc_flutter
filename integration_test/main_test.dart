import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:testing_app/main.dart' as app;

import 'scripts/flow_main.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;
  testWidgets('Login and create new request', (tester) async {
    app.main();
    await tester.pumpAndSettle(const Duration(seconds: 1));
    //Login
    await SampleTest().execute(tester);
  });
}
