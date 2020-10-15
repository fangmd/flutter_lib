import 'package:web3dart/web3dart.dart';

/// ERC20 合约 Event 监听
/// TODO
/// 1. 放在 isolate 中监听所有 token
class TokenContractEventTracker {
  Web3Client client;

  TokenContractEventTracker(this.client);

  void listenEvent(DeployedContract contract, ContractEvent contractEvent) {
    final subscription = client
        .events(FilterOptions.events(contract: contract, event: contractEvent))
        .take(1)
        .listen((event) {
      final decoded = contractEvent.decodeResults(event.topics, event.data);

      final from = decoded[0] as EthereumAddress;
      final to = decoded[1] as EthereumAddress;
      final value = decoded[2] as BigInt;

      print('$from sent $value MetaCoins to $to');
    });
  }
}
