package platform.client.fp10.core.network.command {
  import alternativa.types.Long;
  import flash.utils.ByteArray;

  public class SpaceOpenedCommand implements IConnectionInitCommand {
    public var spaceId:Long;
    public var hash:ByteArray;

    public function SpaceOpenedCommand(param1:Long, param2:ByteArray) {
      super();
      this.hash = param2;
      this.spaceId = param1;
    }
  }
}
