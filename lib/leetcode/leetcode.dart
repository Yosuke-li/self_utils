import 'dart:math';

class Solution {
  /// 暴力破解
  static List<int> sortedSquares(List<int> nums) {
    List<int> result = <int>[];
    result = nums.map((e) => e * e).toList();
    result.sort((a, b) => a - b);

    return result;
  }

  /// 双指针解法
  static List<int> sortedSquaresSec(List<int> nums) {
    List<int> result = List.filled(nums.length, 0);
    int i = 0;
    int j = nums.length - 1;
    int k = nums.length - 1;
    for (; i <= j;) {
      if (nums[i] * nums[i] > nums[j] * nums[j]) {
        result[k] = nums[i] * nums[i];
        k--;
        i++;
      } else {
        result[k] = nums[j] * nums[j];
        k--;
        j--;
      }
    }

    return result;
  }

  /// 暴力解法不可取，超出长度了
  static List<int> addToArrayForm(List<int> num, int k) {
    List<int> result = <int>[];
    String f = '';
    for (var e in num) {
      f = f + e.toString();
    }
    final r = int.parse(f) + k;
    result = r.toString().split('').map((e) => int.parse(e)).toList();

    return result;
  }

  /// 逐位相加
  static List<int> addToArrayFormSec(List<int> num, int k) {
    List<int> result = <int>[];
    final int n = num.length;
    for (int i = n - 1; i >= 0 || k > 0; --i, k = k ~/ 10) {
      if (i >= 0) {
        k += num[i];
      }
      result.add(k % 10);
    }
    result = result.reversed.toList();
    return result;
  }

  /// todo map方法和ascii使用
  /// String.fromCharCode(i) ascii码的转译
  ///
  static List<String> commonChars(List<String> words) {
    List<String> result = [];
    Map<String, dynamic> hashWords = {};

    for (int i = 97; i < 123; i++) {
      hashWords[String.fromCharCode(i)] = 0;
    }

    final String first = words.first;
    first.split('').forEach((element) {
      if (hashWords.keys.contains(element) == true) {
        hashWords[element] += 1;
      }
    });

    for (int j = 1; j < words.length; j++) {
      final Map<String, dynamic> test = {};
      for (int i = 97; i < 123; i++) {
        test[String.fromCharCode(i)] = 0;
      }

      words[j].split('').forEach((element) {
        if (test.keys.contains(element) == true) {
          test[element] += 1;
        }
      });

      hashWords.forEach((key, value) {
        hashWords[key] = min(value as int, test[key] as int);
      });
    }

    hashWords.forEach((key, value) {
      for (int v = 0; v < value; v++) {
        result.add(key);
      }
    });

    return result;
  }

  int largestSumAfterKNegations(List<int> nums, int k) {
    int result = 0;

    for (int i = 0; i < k; i++) {
      nums.sort((a, b) => a - b);
      nums[0] = -nums[0];
    }

    nums.map((e) => result += e).toList();
    return result;
  }


}
