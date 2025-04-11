package alternativa.osgi.service.console {
  public class ConsoleVarNotFoundError extends Error {
    public function ConsoleVarNotFoundError(param1:String) {
      super("Console var not found: " + param1);
    }
  }
}
