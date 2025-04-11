package platform.loading.errors {
  import alternativa.types.Long;

  public class ObjectLoadingError extends Error {
    public function ObjectLoadingError(param1:Long, param2:Long, param3:Error) {
      super();
      message = "Object loading error. Space id: " + param1 + ". Object id: " + param2 + ". Target error: " + param3.getStackTrace();
    }
  }
}
