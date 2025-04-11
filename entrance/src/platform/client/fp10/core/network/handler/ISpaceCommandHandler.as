package platform.client.fp10.core.network.handler {
  import platform.client.fp10.core.network.ICommandHandler;
  import platform.client.fp10.core.type.impl.Space;

  public interface ISpaceCommandHandler extends ICommandHandler {
    function setSpace(param1:Space) : void;
  }
}
