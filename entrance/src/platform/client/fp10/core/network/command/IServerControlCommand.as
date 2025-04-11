package platform.client.fp10.core.network.command {
  import platform.client.fp10.core.network.ControlChannelContext;

  public interface IServerControlCommand {
    function execute(param1:ControlChannelContext) : void;
  }
}
