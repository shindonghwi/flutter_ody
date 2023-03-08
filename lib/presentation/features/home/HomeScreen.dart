import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeContent();
  }
}

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Provider를 호출해 접근, listen: false를 통해 구독된 모든 위젯들에게 알림을 보내지 않게 한다.

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
              // _loginProvider.add(); // 클릭 되었을 때 add()
            },
          ),
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: () {
              // _loginProvider.remove(); // 클릭 되었을 때 remove()
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
      child: Text("Hi"),
    );
  }
}
