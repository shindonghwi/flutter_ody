import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier{
  int _count = 0;
  int get count => _count; // get 함수를 사용해 외부에서 접근이 가능하게 한다.

  // 더하기
  add(){
    _count++;
    notifyListeners(); // notifyListeners 호출해 업데이트된 값을 구독자에게 알림
  }

  // 빼기
  remove(){
    _count--;
    notifyListeners(); // notifyListeners 호출해 업데이트된 값을 구독자에게 알림
  }

}