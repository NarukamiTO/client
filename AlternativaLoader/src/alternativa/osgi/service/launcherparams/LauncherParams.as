package alternativa.osgi.service.launcherparams {
  import alternativa.utils.Properties;
  import flash.display.LoaderInfo;

  public class LauncherParams implements ILauncherParams {
    private var strictUseHttp:Boolean;
    private var _urlLoader:String;
    private var urlParams:Properties;

    public function LauncherParams(param1:LoaderInfo = null, param2:Boolean = false) {
      super();
      if(param1) {
        this._urlLoader = param1.loaderURL;
        this.urlParams = new Properties(param1.parameters);
      } else {
        this.urlParams = new Properties();
      }
      this.strictUseHttp = param2;
    }

    public function getParameter(param1:String, param2:String = null) : String {
      return this.urlParams.getProperty(param1) || param2;
    }

    public function setParameter(param1:String, param2:String) : void {
      this.urlParams.setProperty(param1,param2);
    }

    public function removeParameter(param1:String) : void {
      this.urlParams.removeProperty(param1);
    }

    public function get parameterNames() : Vector.<String> {
      return this.urlParams.propertyNames;
    }

    public function get isDebug() : Boolean {
      return "true" == this.urlParams.getProperty("debug");
    }

    public function isDisableValidationResource() : Boolean {
      return "false" == this.urlParams.getProperty("validationResource");
    }

    public function get urlLoader() : String {
      return this._urlLoader;
    }

    public function isStrictUseHttp() : Boolean {
      return this.strictUseHttp;
    }
  }
}
