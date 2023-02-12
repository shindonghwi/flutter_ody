import 'package:flutter/material.dart';
import 'package:odac_flutter_app/app/feature/home/provider/LoginProvider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        // ChangeNotifierProvider를 통해 변화에 대해 구독(하나만 구독 가능)
        create: (BuildContext context) => LoginProvider(),
        // count_provider.dart
        child:
            HomeContent() // home.dart // child 하위에 모든 것들은 CountProvider에 접근 할 수 있다.
        );
  }
}

class HomeContent extends StatelessWidget {
  late LoginProvider _loginProvider;

  @override
  Widget build(BuildContext context) {
    // Provider를 호출해 접근, listen: false를 통해 구독된 모든 위젯들에게 알림을 보내지 않게 한다.
    _loginProvider = Provider.of<LoginProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text("Provider Sample"),
      ),
      body: CountHomeWidget(), // count_home_widget.dart
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _loginProvider.add(); // 클릭 되었을 때 add()
            },
          ),
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: () {
              _loginProvider.remove(); // 클릭 되었을 때 remove()
            },
          )
        ],
      ),
    );
  }
}

class CountHomeWidget extends StatelessWidget {
  const CountHomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child:
          Consumer<LoginProvider>(// Consumer를 활용해서 provider에 접근하여 데이터를 받아올 수 있다
              builder: (context, provider, child) {
        return Text(
          provider.count.toString(), // count를 화면에 출력
          style: TextStyle(fontSize: 40.0),
        );
      }),
    );
  }
}
