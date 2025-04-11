package platform.client.fp10.core.service.errormessage.errors {
  import alternativa.types.Long;

  public class SpaceDestroyObjectError implements ErrorType {
    private var id:Long;
    private var objectId:Long;

    public function SpaceDestroyObjectError(param1:Long, param2:Long) {
      super();
      this.id = param1;
      this.objectId = param2;
    }

    public function getMessage() : String {
      return "Space " + this.id + " : Cannot destroy missing object. Object id: " + this.objectId;
    }
  }
}
