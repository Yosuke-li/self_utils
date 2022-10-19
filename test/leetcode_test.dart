import 'package:flutter_test/flutter_test.dart';
import 'package:self_utils/leetcode/leetcode.dart';

void main() {
  test('977', () {
    final result = Solution.sortedSquaresSec([-7, -3, 2, 3, 11]);
    expect(result, [4, 9, 9, 49, 121]);
  });

  test('989', () {
    final result = Solution.addToArrayFormSec(
        [1, 2, 6, 3, 0, 7, 1, 7, 1, 9, 7, 5, 6, 6, 4, 4, 0, 0, 6, 3], 516);
    expect(
        result, [1, 2, 6, 3, 0, 7, 1, 7, 1, 9, 7, 5, 6, 6, 4, 4, 0, 5, 7, 9]);
  });

  test('1002', () {
    final result = Solution.commonChars(["bella", "label", "roller"]);
    print(result);
  });

  test('1005', () {
    final result = Solution.largestSumAfterKNegations([2, -3, -1, 5, -4], 2);
    expect(result, 13);
  });

  test('1009', () {
    final result = Solution.bitwiseComplement(10);
    expect(result, 5);
  });

  test('1013', () {
    final result = Solution.canThreePartsEqualSum(
        [0, 2, 1, -6, 6, -7, 9, 1, 2, 0, 1, 0, 0]);
    expect(result, true);
  });

  test('1018', () {
    final result = Solution.prefixesDivBy5Sec(
        [1,0,1,1,1,1,0,0,0,0,1,0,0,0,0,0,1,0,0,1,1,1,1,1,0,0,0,0,1,1,1,0,0,0,0,0,1,0,0,0,1,0,0,1,1,1,1,1,1,0,1,1,0,1,0,0,0,0,0,0,1,0,1,1,1,0,0,1,0]);
    expect(result, [false,false,true,false,false,false,false,false,false,false,true,true,true,true,true,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true,false,false,false,true,false,false,true,false,false,true,true,true,true,true,true,true,false,false,true,false,false,false,false,true,true]);
  });

  test('1021', () {
    final result = Solution.removeOuterParentheses('(()())(())(()(()))');
    expect(result, '()()()()(())');
  });

  test('1037', () {
    final result = Solution.isBoomerang([[0,1],[0,1],[2,1]]);
    expect(result, false);
  });

  test('1046', () {
    final result = Solution.lastStoneWeight([2,2]);
    expect(result, 0);
  });

  test('1047', () {
    final result = Solution.removeDuplicates("aababaab");
    expect(result, 'ba');
  });
}
