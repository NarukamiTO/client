package platform.client.fp10.core.network.handler {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.osgi.service.dump.IDumpService;
  import alternativa.osgi.service.dump.IDumper;
  import alternativa.osgi.service.launcherparams.ILauncherParams;
  import alternativa.osgi.service.logging.LogService;
  import alternativa.osgi.service.logging.Logger;
  import alternativa.protocol.IProtocol;
  import flash.utils.Dictionary;
  import platform.client.fp10.core.network.ControlChannelContext;
  import platform.client.fp10.core.network.ICommandHandler;
  import platform.client.fp10.core.network.ICommandSender;
  import platform.client.fp10.core.network.command.IServerControlCommand;
  import platform.client.fp10.core.network.command.control.client.HashRequestCommand;
  import platform.client.fp10.core.network.connection.ConnectionCloseStatus;
  import platform.client.fp10.core.registry.SpaceRegistry;
  import platform.client.fp10.core.service.address.AddressService;
  import platform.client.fp10.core.service.clientparam.ClientParamUtil;
  import platform.client.fp10.core.service.errormessage.IErrorMessageService;
  import platform.client.fp10.core.service.errormessage.errors.ConnectionClosedError;
  import platform.client.fp10.core.type.ISpace;

  public class ControlCommandHandler implements ICommandHandler {
    [Inject]
    public static var logService:LogService;

    private static var logger:Logger;

    [Inject]
    public static var messageBoxService:IErrorMessageService;

    [Inject]
    public static var spaceRegistry:SpaceRegistry;

    [Inject]
    public static var display:IDisplay;

    [Inject]
    public static var launcherParams:ILauncherParams;

    [Inject]
    public static var addressService:AddressService;

    private var channelContext:ControlChannelContext = new ControlChannelContext();
    private var commandSender:ICommandSender;

    public function ControlCommandHandler() {
      super();
      var local1:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));
      this.channelContext.spaceProtocol = local1;
    }

    private static function getLogger() : Logger {
      return logger || (logger = logService.getLogger("control"));
    }

    public function getCommandSender() : ICommandSender {
      return this.commandSender;
    }

    public function getChannelContext() : ControlChannelContext {
      return this.channelContext;
    }

    public function onConnectionOpen(param1:ICommandSender) : void {
      this.commandSender = param1;
      this.sendConnectionResponse();
    }

    public function onConnectionClose(param1:ConnectionCloseStatus, param2:String = null) : void {
      var local3:Object = null;
      var local4:ISpace = null;
      while(spaceRegistry.spaces.length > 0) {
        local4 = spaceRegistry.spaces[0];
        local4.close();
      }
      for each(local3 in OSGi.getInstance().serviceList) {
        if(local3 is OnConnectionClosedServiceListener) {
          OnConnectionClosedServiceListener(local3).onConnectionClosed(param1);
        }
      }
      if(param1 != ConnectionCloseStatus.CLOSED_BY_CLIENT) {
        messageBoxService.showMessage(new ConnectionClosedError(param1));
      }
      this.commandSender = null;
      this.logDumpers();
    }

    public function executeCommand(param1:Object) : void {
      IServerControlCommand(param1).execute(this.channelContext);
    }

    private function sendConnectionResponse() : void {
      var local3:String = null;
      var local4:Dictionary = null;
      var local5:String = null;
      var local1:Array = [];
      var local2:Array = [];
      for each(local3 in launcherParams.parameterNames) {
        local1.push(local3);
        local2.push(launcherParams.getParameter(local3));
      }
      local1.push("clientHashURL");
      local2.push(this.getClientHashURL());
      local4 = ClientParamUtil.collectClientParams();
      for(local5 in local4) {
        local1.push(local5);
        local2.push(local4[local5]);
      }
      this.commandSender.sendCommand(new HashRequestCommand(local1,local2));
    }

    private function logDumpers() : void {
      var local2:IDumper = null;
      var local1:IDumpService = IDumpService(OSGi.getInstance().getService(IDumpService));
      for each(local2 in local1.dumpersList) {
        logService.getLogger("dumper_" + local2.dumperName).info(local2.dump([]));
      }
    }

    private function getClientHashURL() : String {
      return addressService.getBaseURL() + "#" + addressService.getValue();
    }
  }
}
