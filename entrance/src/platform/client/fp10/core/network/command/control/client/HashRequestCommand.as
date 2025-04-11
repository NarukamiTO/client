package platform.client.fp10.core.network.command.control.client {
  import platform.client.fp10.core.network.command.ControlCommand;
  import platform.client.fp10.core.network.command.IConnectionInitCommand;

  public class HashRequestCommand extends ControlCommand implements IConnectionInitCommand {
    public var parameterNames:Array;
    public var parameterValues:Array;

    public function HashRequestCommand(param1:Array, param2:Array) {
      super(ControlCommand.CL_HASH_REQUEST,"Hash request");
      if(param1 == null) {
        throw new ArgumentError("Parameter parameterNames is null");
      }
      if(param2 == null) {
        throw new ArgumentError("Parameter parameterValues is null");
      }
      this.parameterNames = param1;
      this.parameterValues = param2;
    }
  }
}
