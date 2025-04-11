package platform.loading.errors {
  import alternativa.types.Long;

  public class ObjectClassNotFoundError extends Error {
    public function ObjectClassNotFoundError(param1:Long, param2:Long) {
      super();
      message = "Object class not found. Class id: " + param1 + ". Object id: " + param2;
    }
  }
}
