import 'dart:developer' as dev;
import 'dart:math' as math;

import 'package:flutter/material.dart';


// import '../global/services/intersperse.dart' as core; // TODO

enum ANSICOLOR { reset, black, white, red, green, yellow, blue, cyan, purple }

const Map<ANSICOLOR, dynamic> _colors = {
  ANSICOLOR.reset: '\x1B[0m',
  ANSICOLOR.black: ['\x1B[30m', '\x1B[40m'],
  ANSICOLOR.red: ['\x1B[31m', '\x1B[41m'],
  ANSICOLOR.green: ['\x1B[32m', '\x1B[42m'],
  ANSICOLOR.yellow: ['\x1B[33m', '\x1B[43m'],
  ANSICOLOR.purple: ['\x1B[35m', '\x1B[45m'],
  ANSICOLOR.blue: ['\x1B[34m', '\x1B[44m'],
  ANSICOLOR.cyan: ['\x1B[36m', '\x1B[46m'],
  ANSICOLOR.white: ['\x1B[37m', '\x1B[47m'],
};

extension IndexedIterable<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }
}

// extension ResponsiveSized on num {
//   SizedBox get hSpace => SizedBox(height: h);
//   SizedBox get rHSpace => SizedBox(height: r);
//   SizedBox get wSpace => SizedBox(width: w);
//   SizedBox get rWSpace => SizedBox(width: w);
// }

// extension ResponsiveRadiuse on num {
//   BorderRadius get bRadius => BorderRadius.circular(r);
// }

extension NumbersConverter on num? {
  String toApproximate([int decimalPlaces = 2]) {
    final int? exp;
    final number = this;
    final suffixes = ['k', 'M', 'B', 'T', 'Qa', 'Qi'];
    if (number == null || number.isNaN) return 'NaN';
    if (number < 1000) return number.toString();

    exp = (math.log(number) / math.log(1000)).floor();
    final result =
        (number / math.pow(1000, exp)).toStringAsFixed(decimalPlaces) + suffixes[exp - 1];
    return result;
  }

  num toPercentage(num maxValue) {
    if (this == null) 0;
    return this! / maxValue;
  }
}

extension StringColor on String {
  Color toColor() {
    var hexString = this;
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

extension StringConverter on String {
  String get toUpperCaseFirstChar {
    if (isEmpty) return this;

    List<String> words = split(' ');
    for (int i = 0; i < words.length; i++) {
      if (words[i].isNotEmpty) {
        words[i] = words[i][0].toUpperCase() + words[i].substring(1);
      }
    }

    return words.join(' ');
  }
}

extension StringToNumber on String? {
  int toInt() {
    return int.tryParse(this ?? '0') ?? 0;
  }

  int? toNullableInt() {
    return this == null ? null : int.tryParse(this!);
  }

  double toDouble() {
    return double.tryParse(this ?? '0.0') ?? 0.0;
  }

  num toNumber() {
    return num.tryParse(this ?? '0') ?? 0;
  }
}

extension ColoredLog on Object? {
  // void log() => dev.log(toString());

  void printLog({
    String name = 'DEBUG_LOG',
    ANSICOLOR color = ANSICOLOR.yellow,
    ANSICOLOR? bgColor,
  }) {
    dev.log(
      '${bgColor == null ? _colors[ANSICOLOR.reset] : _colors[bgColor][1]}${_colors[color][0]}${toString()}${_colors[ANSICOLOR.reset]}',
      name:
          '${bgColor == null ? _colors[ANSICOLOR.reset] : _colors[bgColor][1]}${_colors[color][0]}$name${_colors[ANSICOLOR.reset]}',
    );
  }
}

extension ColorToMaterialStateProperty on Color {
  MaterialStateProperty<Color> toMaterialStateColor() =>
      MaterialStateColor.resolveWith((states) => this);
}

extension TimeConverter on int {
  String get formatDuration {
    final duration = Duration(seconds: this);
    final minutes = duration.inMinutes;
    final seconds = this % 60;

    final minutesString = '$minutes'.padLeft(2, '0');
    final secondsString = '$seconds'.padLeft(2, '0');
    return '$minutesString:$secondsString';
  }
}

extension SliversConverter on Widget {
  SliverToBoxAdapter get toSliverToBoxAdapter => SliverToBoxAdapter(child: this);
}

// extension BorderRadiusAnyWidget on Widget {
//   ClipRRect borderRadius(int borderRadius, [Clip clip = Clip.antiAlias]) => ClipRRect(
//         clipBehavior: clip,
//         borderRadius: borderRadius(),
//         child: this,
//       );
// }

extension ExpandedWidget on Widget {
  Expanded get expanded => Expanded(child: this);
}

// extension IntersperseExtensions<T> on Iterable<T> {
//   /// Puts [element] between every element in [list].
//   ///
//   /// Example:
//   ///
//   ///     final list1 = <int>[].intersperse(2); // [];
//   ///     final list2 = [0].intersperse(2); // [0];
//   ///     final list3 = [0, 0].intersperse(2); // [0, 2, 0];
//   ///
//   Iterable<T> intersperse(T element) {
//     return core.intersperse(element, this);
//   }
//
//   /// Puts [element] between every element in [list] and at the bounds of [list].
//   ///
//   /// Example:
//   ///
//   ///     final list1 = <int>[].intersperseOuter(2); // [];
//   ///     final list2 = [0].intersperseOuter(2); // [2, 0, 2];
//   ///     final list3 = [0, 0].intersperseOuter(2); // [2, 0, 2, 0, 2];
//   ///
//   Iterable<T> intersperseOuter(T element) {
//     return core.intersperseOuter(element, this);
//   }
// }

extension MapWithIndexWithSeparator<T> on List<T> {
  List<R> mapWithIndex<R>({
    required R Function(T element, int index) callback,
    R Function(int index)? separatorCallback,
  }) {
    List<R> result = [];
    if (separatorCallback == null) {
      for (int i = 0; i < length; i++) {
        R item = callback(this[i], i);
        result.add(item);
      }
    } else {
      for (int i = 0; i < length; i++) {
        R item = callback(this[i], i);
        R separator = separatorCallback(i);
        result.add(item);
        result.add(separator);
      }
    }
    if (separatorCallback != null) result.removeLast();
    return result;
  }
}

// extension DateFormatter on DateTime? {
//   String format([String pattern = 'dd-MM-yyyy']) {
//     if (this == null) return 'null-date';
//     return DateFormat(pattern).format(this!);
//   }
// }

extension CustomDateFormatter on DateTime {
  String get formatDuration {
    final now = DateTime.now();
    final difference = this.difference(now);

    final days = difference.inDays;
    final hours = difference.inHours.remainder(24);
    final minutes = difference.inMinutes.remainder(60);
    final seconds = difference.inSeconds.remainder(60);

    final formattedDuration = '${days}D : ${hours}H : ${minutes}Min : ${seconds}S';

    return formattedDuration;
  }
}
