package platform.client.fp10.core.network.command.control.server {
  import platform.client.fp10.core.network.ControlChannelContext;
  import platform.client.fp10.core.network.command.ControlCommand;
  import platform.client.fp10.core.network.command.IServerControlCommand;

  public class MessageCommand extends ControlCommand implements IServerControlCommand {
    private var message:String;

    public function MessageCommand(param1:String) {
      super(ControlCommand.SV_MESSAGE,"Message command");
      this.message = param1;
    }

    public function execute(param1:ControlChannelContext) : void {
    }
  }
}
