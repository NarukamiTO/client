package platform.loading.errors {
  import alternativa.types.Long;

  public class ModelNotFoundError extends Error {
    public function ModelNotFoundError(param1:Long, param2:Long, param3:Long) {
      super();
      message = "Model not found. Space id: " + param1 + ". Object id: " + param2 + ". Model id: " + param3;
    }
  }
}
