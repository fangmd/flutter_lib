/// 手机号正则验证
/// 支持 越南/中国
bool verifyPhone(String areaCode, String phone) {
  if (phone.isEmpty) {
    return false;
  }
  if (areaCode == null || areaCode.isEmpty) {
    return false;
  }
  if (areaCode.startsWith('+')) {
    areaCode = areaCode.replaceAll('+', '');
  }
  switch (areaCode) {
    case '86':
      RegExp mobile = new RegExp(r"^1[0-9]\d{9}$");
      return mobile.hasMatch(phone);
      break;
    case '84':
      RegExp mobile = new RegExp(r"^0[1-9]\d{8}$");
      return mobile.hasMatch(phone);
      break;
  }
  //TODO: 手机号正则验证，其他地区
  return true;
}
