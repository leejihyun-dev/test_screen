import 'package:flutter_riverpod/flutter_riverpod.dart';

final numberProvider = StateProvider<int>((ref) => 0); //관리하고 싶은 값을 반환해주면 된다.
//StateProvider의 파라미터 안에는 하나의 함수가 들어간다.
//제너릭은 어떤 타입값을 관리할 건지 ->  <int>이렇게 선언한거