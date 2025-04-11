package platform.client.fp10.core.network.command {
  public class ServerMessageType {
    public static const INFO:int = 0;
    public static const WARNING:int = 1;
    public static const ERROR:int = 2;
    public static const CRITICAL:int = 3;

    public function ServerMessageType() {
      super();
    }
  }
}
