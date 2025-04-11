package platform.client.fp10.core.service.errormessage.errors {
  import alternativa.types.Long;

  public class SpaceObjectDestructionError implements ErrorType {
    private var e:Error;
    private var objectId:Long;
    private var spaceId:Long;

    public function SpaceObjectDestructionError(param1:Long, param2:Long, param3:Error) {
      super();
      this.e = param3;
      this.objectId = param2;
      this.spaceId = param1;
    }

    public function getMessage() : String {
      return "Space [" + this.spaceId + "]: Object destruction error. Object id: " + this.objectId + ", error: " + this.e.getStackTrace();
    }
  }
}
