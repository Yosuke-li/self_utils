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
    final result = Solution.prefixesDivBy5Sec([
      1,
      0,
      1,
      1,
      1,
      1,
      0,
      0,
      0,
      0,
      1,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
      0,
      1,
      1,
      1,
      1,
      1,
      0,
      0,
      0,
      0,
      1,
      1,
      1,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
      0,
      0,
      1,
      0,
      0,
      1,
      1,
      1,
      1,
      1,
      1,
      0,
      1,
      1,
      0,
      1,
      0,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
      1,
      1,
      1,
      0,
      0,
      1,
      0
    ]);
    expect(result, [
      false,
      false,
      true,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      true,
      true,
      true,
      true,
      true,
      true,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      true,
      false,
      false,
      false,
      true,
      false,
      false,
      true,
      false,
      false,
      true,
      true,
      true,
      true,
      true,
      true,
      true,
      false,
      false,
      true,
      false,
      false,
      false,
      false,
      true,
      true
    ]);
  });

  test('1021', () {
    final result = Solution.removeOuterParentheses('(()())(())(()(()))');
    expect(result, '()()()()(())');
  });

  test('1037', () {
    final result = Solution.isBoomerang([
      [0, 1],
      [0, 1],
      [2, 1]
    ]);
    expect(result, false);
  });

  test('1046', () {
    final result = Solution.lastStoneWeight([2, 2]);
    expect(result, 0);
  });

  test('1047', () {
    final result = Solution.removeDuplicates("aababaab");
    expect(result, 'ba');
  });

  test('1051', () {
    final result = Solution.heightChecker([1, 1, 4, 2, 1, 3]);
    expect(result, 3);
  });

  test('1078', () {
    final result =
        Solution.findOcurrences('we we we we will rock you', 'we', 'we');
    expect(result, ['we', 'we', 'will']);
  });

  test('1103', () {
    final result = Solution.distributeCandies(10, 3);
    expect(result, [5, 2, 3]);
  });

  test('1137', () {
    final result = Solution.tribonacci(25);
    expect(result, 4);
  });

  test('1154', () {
    final result = Solution.dayOfYear('2006-09-20');
    expect(result, 4);
  });

  test('1184', () {
    final result =
        Solution.distanceBetweenBusStops([7, 10, 1, 12, 11, 14, 5, 0], 7, 2);
    expect(result, 4);
  });

  test('1185', () {
    final result = Solution.dayOfTheWeek(18, 7, 1999);
    expect(result, 'Sunday');
  });

  test('1200', () {
    final result = Solution.minimumAbsDifference([4, 2, 1, 3]);
    expect(result, [[1,2],[2,3],[3,4]]);
  });
}
