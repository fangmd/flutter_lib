import 'dart:math';

import 'package:decimal/decimal.dart';
import 'package:web3dart/web3dart.dart';

import 'abi.dart';

/// 合约 & 交易 操作工具类
class ContractUtils {
  static Future<dynamic> getTokenBalance(
      Web3Client client, String tokenAddress, String address) async {
    List<dynamic> params = [EthereumAddress.fromHex(address)];
    return (await _readFromContract(
            client, 'BasicToken', tokenAddress, 'balanceOf', params))
        .first;
  }

  static Future<dynamic> getTokenDetails(
      Web3Client client, String tokenAddress) async {
    return {
      "name": (await _readFromContract(
              client, 'BasicToken', tokenAddress, 'name', []))
          .first,
      "symbol": (await _readFromContract(
              client, 'BasicToken', tokenAddress, 'symbol', []))
          .first,
      "decimals": (await _readFromContract(
              client, 'BasicToken', tokenAddress, 'decimals', []))
          .first
    };
  }

  static Future<Transaction> tokenTransfer(Web3Client client, String tokenAddress,
      String receiverAddress, num tokensAmount) async {
    EthereumAddress receiver = EthereumAddress.fromHex(receiverAddress);
    dynamic tokenDetails = await getTokenDetails(client, tokenAddress);
    int tokenDecimals = int.parse(tokenDetails["decimals"].toString());
    Decimal tokensAmountDecimal = Decimal.parse(tokensAmount.toString());
    Decimal decimals = Decimal.parse(pow(10, tokenDecimals).toString());
    BigInt amount = BigInt.parse((tokensAmountDecimal * decimals).toString());
    return await _callContract(
        'BasicToken', tokenAddress, 'transfer', [receiver, amount]);
  }

  static Future<Transaction> _callContract(String contractName, String contractAddress,
      String functionName, List<dynamic> params) async {
    // 校验 钱包状态的
    // bool isApproved = await _approveCb;
    // if (!isApproved) {
    //   throw 'transaction not approved';
    // }
    DeployedContract contract = await _contract(contractName, contractAddress);
    Transaction tx = Transaction.callContract(
        contract: contract,
        function: contract.function(functionName),
        parameters: params);
    return tx;
    // return await _sendTransactionAndWaitForReceipt(tx);
  }

  static Future<List<dynamic>> _readFromContract(
      Web3Client client,
      String contractName,
      String contractAddress,
      String functionName,
      List<dynamic> params) async {
    DeployedContract contract = await _contract(contractName, contractAddress);
    return await client.call(
        contract: contract,
        function: contract.function(functionName),
        params: params);
  }

  static Future<DeployedContract> _contract(
      String contractName, String contractAddress) async {
    String abi = ABI.get(contractName);
    DeployedContract contract = DeployedContract(
        ContractAbi.fromJson(abi, contractName),
        EthereumAddress.fromHex(contractAddress));
    return contract;
  }
}
