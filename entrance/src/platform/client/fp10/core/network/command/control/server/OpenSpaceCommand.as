package platform.client.fp10.core.network.command.control.server {
  import alternativa.osgi.service.network.INetworkService;
  import alternativa.types.Long;
  import platform.client.fp10.core.network.ControlChannelContext;
  import platform.client.fp10.core.network.command.ControlCommand;
  import platform.client.fp10.core.network.command.IServerControlCommand;
  import platform.client.fp10.core.network.handler.SpaceCommandHandler;
  import platform.client.fp10.core.registry.SpaceRegistry;
  import platform.client.fp10.core.type.impl.Space;

  public class OpenSpaceCommand extends ControlCommand implements IServerControlCommand {
    [Inject]
    public static var spaceRegistry:SpaceRegistry;

    [Inject]
    public static var networkService:INetworkService;

    private var spaceId:Long;

    public function OpenSpaceCommand(param1:Long) {
      super(ControlCommand.SV_OPEN_SPACE,"Open space");
      this.spaceId = param1;
    }

    public function execute(param1:ControlChannelContext) : void {
      var local2:SpaceCommandHandler = new SpaceCommandHandler(param1.hash);
      var local3:Space = new Space(this.spaceId,local2,param1.spaceProtocol,param1.channelProtectionEnabled);
      spaceRegistry.addSpace(local3);
      local3.connect(networkService.controlServerAddress,networkService.controlServerPorts);
    }
  }
}
