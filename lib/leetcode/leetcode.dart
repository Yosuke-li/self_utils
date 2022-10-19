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

  static int largestSumAfterKNegations(List<int> nums, int k) {
    int result = 0;

    for (int i = 0; i < k; i++) {
      nums.sort((a, b) => a - b);
      nums[0] = -nums[0];
    }

    nums.map((e) => result += e).toList();
    return result;
  }

  /// toRadixString 进制转换
  /// int.parse radix 定义进制
  static int bitwiseComplement(int n) {
    late int result;
    String twoWise = n.toRadixString(2);
    List<String> wiseList = twoWise.split('');
    for (int i = 0; i < wiseList.length; i++) {
      if (wiseList[i] == '1') {
        wiseList[i] = '0';
      } else {
        wiseList[i] = '1';
      }
    }
    String tenWise = int.parse(wiseList.join(''), radix: 2).toRadixString(10);
    result = int.parse(tenWise);
    return result;
  }

  /// 本地没遇到问题，但跑不过leetcode测试
  ///
  static bool canThreePartsEqualSum(List<int> arr) {
    int sum = 0;
    for (int val in arr) {
      sum += val;
    }

    if (sum % 3 == 0) {
      int times = 0;
      while (times < 3) {
        int i = 0;
        int partSum = 0;
        for (int j = i; j < arr.length; j++) {
          partSum += arr[j];
          if (times < 2) {
            if (partSum == sum / 3) {
              i = j;
              times++;
              partSum = 0;
              continue;
            }
          } else if (j == arr.length - 1) {
            if (partSum == sum / 3) {
              i = j;
              times++;
              partSum = 0;
              break;
            } else {
              return false;
            }
          }
        }
      }
      return true;
    } else {
      return false;
    }
  }

  /// 超出整数范围
  static List<bool> prefixesDivBy5(List<int> nums) {
    List<bool> result = [];
    String numString = '';
    for (var element in nums) {
      numString += '$element';
      int val = int.parse(int.parse(numString, radix: 2).toRadixString(10));
      if (val % 5 == 0) {
        result.add(true);
      } else {
        result.add(false);
      }
    }

    return result;
  }

  /// 移位运算符
  /// 直接计算会溢出，每次只保存余数
  static List<bool> prefixesDivBy5Sec(List<int> nums) {
    List<bool> result = [];
    int val = 0;
    for (var element in nums) {
      print(((val << 1) + element));
      val = ((val << 1) + element) % 5;
      if (val == 0) {
        result.add(true);
      } else {
        result.add(false);
      }
    }

    return result;
  }

  /// 堆栈
  static String removeOuterParentheses(String s) {
    String result = '';
    List<String> list = [];
    s.split('').forEach((element) {
      if (element == ')') {
        list.removeLast();
      }
      if (list.isNotEmpty) {
        result += element;
      }
      if (element == '(') {
        list.add(element);
      }
    });
    return result;
  }

  /// 数学方法 -- 直线方程
  static bool isBoomerang(List<List<int>> points) {
    late bool result;
    if ((points[1][1] - points[0][1]) * (points[2][0] - points[0][0]) ==
        (points[1][0] - points[0][0]) * (points[2][1] - points[0][1])) {
      result = false;
    } else {
      result = true;
    }

    return result;
  }

  /// 排序 计算 删减 循环以上操作
  static int lastStoneWeight(List<int> stones) {
    int result = 0;
    while (stones.length > 1) {
      stones.sort((a, b) => b - a);
      int val = stones[0] - stones[1];
      if (val != 0) {
        stones.add(val);
      }
      stones.removeRange(0, 2);
    }
    result = stones.isNotEmpty ? stones[0] : 0;
    return result;
  }

  /// 堆栈
  static String removeDuplicates(String s) {
    String result = '';
    List<String> list = s.split('');
    int last = 0;
    int first = list.length;
    do {
      int first = list.length;

    } while(last != first);

    result = list.join('');
    return result;
  }
}
