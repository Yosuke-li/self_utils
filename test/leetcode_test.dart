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
    final result = Solution().largestSumAfterKNegations([2, -3, -1, 5, -4], 2);
    expect(result, 13);
  });
}
