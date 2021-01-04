
enum SmallLength { TWO, FOUR }
class ByteUtils{

  static final String HEX = "0123456789ABCDEF";

  //十六进制字符串转换为int数组
  static List<int> hexString2List(String str) {
    final intArray = <int>[];
    final temp = List<int>(2);

    for (int i = 0; i < str.length; i += 2) {
      String even = str.substring(i, i + 2); //把String字符串划分成一个一个的字节，两个字符代表一个字节
      for (int j = 0; j < 2; j++) {
        final unitNum = even.codeUnitAt(j);
        if (unitNum >= 48 && unitNum <= 57) {
          //说明这个字符就是数字---0-9
          temp[j] = unitNum - 48;
        } else if (unitNum >= 65 && unitNum <= 70) {
          //A-F
          temp[j] = unitNum - 65 + 10;
        } else if (unitNum >= 97 && unitNum <= 102) {
          //a-f
          temp[j] = unitNum - 97 + 10;
        } else {
          throw Exception(["您传入的字符串有十六进制以外的字符"]);
        }
      }
      temp[0] = (temp[0] & 0xFF) << 4;
      temp[1] = (temp[1] & 0xFF);

      intArray.add((temp[0] | temp[1]));
    }
    return intArray;
  }

  //int数组转换为十六进制字符串
  static String intListToHexString(List<int> data){
    if (data == null)
      return "";
    StringBuffer result = StringBuffer();
    for(final num in data){
      _appendHex(result, num);
    }
    return result.toString();
  }


  static String intListToHexStringWithoutSpace(List<int> data){
    if (data == null)
      return "";
    StringBuffer sb = StringBuffer();
    for(final b in data){
      sb.write(HEX[(b >> 4) & 0x0f]);
      sb.write(HEX[b & 0x0f]);
    }
    return sb.toString();
  }


// 转换需要用的常量
  static void _appendHex(StringBuffer sb, int b) {
    sb.write(HEX[(b >> 4) & 0x0f]);
    sb.write(HEX[b & 0x0f]);
    sb.write(" ");
  }

  //合并两个数组
  static  List<int> byteMerger(List<int> list1,List<int> list2){
    if(list2!=null){
      List<int>list3=new List();
      list3.addAll(list1);
      list3.addAll(list2);
      return list3;
    }
    return list1;
  }


  static int hexStringToInt(String hex) {
    int val = 0;
    int len = hex.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = hex.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        // A..F
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        // a..f
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        throw new FormatException("Invalid hexadecimal value");
      }
    }
    return val;
  }


 static List<int> toSmallEnd(int content, SmallLength modelLength) {
    List<int> contents = [
      content >> 24 & 0xff,
      content >> 16 & 0xff,
      content >> 8 & 0xff,
      content & 0xff
    ];
    if (modelLength == SmallLength.FOUR) {
      return contents.reversed.toList();
    } else if (modelLength == SmallLength.TWO) {
      List<int> filters = [];
      filters.add(contents[3]);
      filters.add(contents[2]);
      return filters;
    }
    return null;
  }

  }
