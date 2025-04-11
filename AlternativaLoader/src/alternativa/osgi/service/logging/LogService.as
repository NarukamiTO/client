package alternativa.osgi.service.logging {
  public interface LogService {
    function getLogger(param1:Object) : Logger;
    function addLogTarget(param1:LogTarget) : void;
    function removeLogTarget(param1:LogTarget) : void;
  }
}
