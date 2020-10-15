import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import "package:web_socket_channel/io.dart";

/// eth 客户端
class EthClient {
  Web3Client client;

  EthClient(String nodeAddress, String nodeWss) {
    client = Web3Client(nodeAddress, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(nodeWss).cast<String>();
    });
  }
}
