import 'package:web3dart/web3dart.dart';

/// 合约 Event 监听
class ContractEventTracker {
  Web3Client client;

  ContractEventTracker(this.client);

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
