package platform.loading.errors {
  import alternativa.types.Long;

  public class ObjectLoadListenerError extends Error {
    public function ObjectLoadListenerError(param1:Long, param2:Long, param3:Error) {
      super();
      message = "Object loading event processing error. Space id: " + param1 + ".Object id: " + param2 + ". Error: " + param3.getStackTrace();
    }
  }
}
