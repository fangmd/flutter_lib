import 'package:ed25519_hd_key/ed25519_hd_key.dart';
import 'package:hex/hex.dart';
import 'package:web3dart/credentials.dart';
import 'package:bip39/bip39.dart' as bip39;

/// eth wallet
/// 管理 私钥/地址/助记词
class EthDartWallet {
  String _privateKey;

  String _address;
  String _mnemonic;
  Credentials credentials;

  /// 导入私钥
  EthDartWallet.fromPrivateKey({String privateKey, String memo}) {
    if (privateKey != null) {
      _privateKey = privateKey;
    }

    if (memo != null) {
      _mnemonic = memo;
      String seed = bip39.mnemonicToSeedHex(memo);
      KeyData master = ED25519_HD_KEY.getMasterKeyFromSeed(seed);
      _privateKey = HEX.encode(master.key);
    }

    credentials = EthPrivateKey.fromHex(_privateKey);
  }

  /// 创建私钥
  EthDartWallet.create() {
    _mnemonic = _randomMnemonic(128);

    String seed = bip39.mnemonicToSeedHex(_mnemonic);
    KeyData master = ED25519_HD_KEY.getMasterKeyFromSeed(seed);
    _privateKey = HEX.encode(master.key);
    credentials = EthPrivateKey.fromHex(_privateKey);
  }

  String get privateKey => _privateKey;

  Future<String> get address async {
    if (_address != null) return _address;
    Credentials cre = EthPrivateKey.fromHex(_privateKey);
    final ethAdd = await cre.extractAddress();
    _address = ethAdd.hex;
    return _address;
  }

  String get mnemonic {
    return _mnemonic;
  }

  String _randomMnemonic(int size) {
    assert(size is int);
    return bip39.generateMnemonic(strength: size);
  }
}
