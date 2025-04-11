package platform.client.fp10.core.network {
  import alternativa.protocol.IProtocol;
  import flash.utils.ByteArray;

  public class ControlChannelContext {
    public var hash:ByteArray;
    public var channelProtectionEnabled:Boolean;
    public var spaceProtocol:IProtocol;

    public function ControlChannelContext() {
      super();
    }
  }
}
