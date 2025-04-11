package platform.client.fp10.core.network.command.control.server {
  import flash.utils.ByteArray;
  import platform.client.fp10.core.network.ControlChannelContext;
  import platform.client.fp10.core.network.command.ControlCommand;
  import platform.client.fp10.core.network.command.IServerControlCommand;

  public class HashResponseCommand extends ControlCommand implements IServerControlCommand {
    public var hash:ByteArray;
    public var channelProtectionEnabled:Boolean;

    public function HashResponseCommand(param1:ByteArray, param2:Boolean) {
      super(ControlCommand.SV_HASH_RESPONSE,"Hash response");
      this.hash = param1;
      this.channelProtectionEnabled = param2;
    }

    public function execute(param1:ControlChannelContext) : void {
      param1.hash = this.hash;
      param1.channelProtectionEnabled = this.channelProtectionEnabled;
    }
  }
}
