import 'package:flutter_test/flutter_test.dart';

import 'api_client.dart';

void main() {
  test('adds one to input values', () async {
//    final calculator = Calculator();
//    expect(calculator.addOne(2), 3);
//    expect(calculator.addOne(-7), -6);
//    expect(calculator.addOne(0), 1);
//    expect(() => calculator.addOne(null), throwsNoSuchMethodError);

    await ApiClient.getInstance()
        .get("https://www.baidu.com/wd=sdsdf", (data) => data.toString());
  });
}
