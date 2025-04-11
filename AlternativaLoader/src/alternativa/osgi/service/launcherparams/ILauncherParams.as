package alternativa.osgi.service.launcherparams {
  public interface ILauncherParams {
    function getParameter(param1:String, param2:String = null) : String;
    function setParameter(param1:String, param2:String) : void;
    function removeParameter(param1:String) : void;
    function get parameterNames() : Vector.<String>;
    function get isDebug() : Boolean;
    function get urlLoader() : String;
    function isStrictUseHttp() : Boolean;
    function isDisableValidationResource() : Boolean;
  }
}
