import 'package:flutter_test/flutter_test.dart';
import 'package:self_utils/init.dart';

void main() {

  test('array_unique', () {
    List<String> a = ['ab', 'c', 'd','d', 'e', 'ab','d'];
    print(ArrayHelper.unique(listData: a, getKey: (String item) => item));
  });

  test('lock test', () async {
    Lock lock = Lock();
    int count=0;
    int i=0;

    await Future.wait(Iterable.generate(3,(_)=>Future(()async{
      await lock.lock();

      ///Func
      count ++;
      print('add$count');
      await Future.delayed(const Duration(milliseconds: 10));
      count --;
      print('cut$count');
      expect(count, 0);

      lock.unlock();
      i++;

      print('fin$i');
    })));
    expect(i,3);
  });

  test('mixin', () {
    A a = A();
    B b = B();
    D d = D();
    a.eat();
    b.eat();
    d.eat();
  });

  test('containList', () {
    final result = ArrayHelper.containList(['0', 4], [0, 4, 8]);
    expect(result, false);
  });
}