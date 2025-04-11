package alternativa.osgi.service.console {
  public class ConsoleVarChangeError extends Error {
    public function ConsoleVarChangeError(param1:String, param2:String, param3:String) {
      super("Can not change variable " + param1 + ", value=" + param2 + ", message=" + param3);
    }
  }
}
