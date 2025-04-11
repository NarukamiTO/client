package alternativa.osgi.service {
  public interface IServiceRegisterListener {
    function serviceRegistered(param1:Class, param2:Object) : void;
    function serviceUnregistered(param1:Class, param2:Object) : void;
  }
}
