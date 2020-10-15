import 'package:hex/hex.dart';
import 'package:web3dart/web3dart.dart';

import 'contract/abi.dart';
import 'contract/contract_utils.dart';
import 'contract_event_tracker.dart';
import 'wallet.dart';

/// 钱包操作
/// 1. 获取余额
/// 2. 获取 ERC20 币信息 & 余额
class WalletOperation {
  final EthDartWallet wallet;
  Web3Client client;
  ContractEventTracker contractEventTracker;

  WalletOperation(this.wallet, this.client) {
    contractEventTracker = ContractEventTracker(this.client);
  }

  /// 获取 ETH 余额
  Future<BigInt> getBalance() async {
    final add = await wallet.credentials.extractAddress();
    final amount = await client.getBalance(add);
    return amount.getInWei;
  }

  /// 获取 ERC20 余额
  Future<BigInt> getERC20Balance(String tokenAddress, {String address}) async {
    final currentAddress = await wallet.address;
    if (address == null || address.isEmpty) {
      return await ContractUtils.getTokenBalance(
          client, tokenAddress, currentAddress);
    } else {
      return await ContractUtils.getTokenBalance(client, tokenAddress, address);
    }
  }

  /// 获取 ERC20 Detail
  Future<dynamic> getTokenDetails(String tokenAddress) {
    return ContractUtils.getTokenDetails(client, tokenAddress);
  }

  /// 转账 ERC20
  Future<String> tokenTransfer(
      String tokenAddress, String receiverAddress, num tokensAmount) async {
    Transaction tx = await ContractUtils.tokenTransfer(
        client, tokenAddress, receiverAddress, tokensAmount);
    return _sendTransactionAndWaitForReceipt(tx);
  }

  /// 创建合约
  Future createContract(contractCompiledRet, {String contractName}) async {
    print(contractCompiledRet);
    final contract = contractCompiledRet['contracts'][':$contractName'];
    // final bytecode = '0x'+contract['bytecode'];
    final Transaction transaction = Transaction(
        to: null,
        from: await wallet.credentials.extractAddress(),
        data: HEX.decode(contract['bytecode']),
        maxGas: 2000000); // TODO: maxGas
    return _sendTransactionAndWaitForReceipt(transaction);
  }

  /// 发送交易&返回等待结果
  /// return txHash
  Future<String> _sendTransactionAndWaitForReceipt(
      Transaction transaction) async {
    print('sendTransactionAndWaitForReceipt');

    final networkId = await client.getNetworkId(); //TOOD：opt缓存 chainId
    String txHash = await client
        .sendTransaction(wallet.credentials, transaction, chainId: networkId);

    print('tx: $txHash');
    //TODO: save txHash to local

    // 通过 ContractEvent 获取交易结果 listener start
    final deployedContract = DeployedContract(
        ContractAbi.fromJson(ABI.get('BasicToken'), 'name'),
        EthereumAddress.fromHex('0xf69a677e61e34e811eddbf68e2ce71c6a007078e'));
    final transferEvent = deployedContract.event('Transfer');
    contractEventTracker.listenEvent(deployedContract, transferEvent);
    // listener end

    TransactionReceipt receipt;
    try {
      receipt = await client.getTransactionReceipt(txHash);
    } catch (err) {
      print('could not get $txHash receipt, try again');
    }
    int delay = 1;
    int retries = 10;
    while (receipt == null) {
      print('waiting for receipt');
      await Future.delayed(new Duration(seconds: delay));
      delay *= 2;
      retries--;
      if (retries == 0) {
        throw 'transaction $txHash not mined yet...';
      }
      try {
        receipt = await client.getTransactionReceipt(txHash);
        print('success: $receipt');
      } catch (err) {
        print('could not get $txHash receipt, try again');
      }
    }
    return txHash;
  }
}
