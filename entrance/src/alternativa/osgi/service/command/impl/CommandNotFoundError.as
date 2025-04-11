package alternativa.osgi.service.command.impl {
  public class CommandNotFoundError extends Error {
    public function CommandNotFoundError(param1:String, param2:String) {
      super(this.createMessage(param1,param2));
    }

    private function createMessage(param1:String, param2:String) : String {
      var local3:String = "Command not found: " + param1;
      if(param2 != null) {
        local3 += "\n" + param2;
      }
      return local3;
    }
  }
}
