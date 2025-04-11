package alternativa.osgi.bundle {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.logging.LogService;
  import alternativa.utils.Properties;
  import flash.system.ApplicationDomain;

  public class BundleDescriptor implements IBundleDescriptor {
    private static var LOG_CHANNEL:String = "osgi";
    private static var logService:LogService = LogService(OSGi.getInstance().getService(LogService));

    private var _name:String;
    private var _activators:Vector.<IBundleActivator>;
    private var _properties:Properties;

    public function BundleDescriptor(param1:Properties) {
      var local3:String = null;
      var local4:Boolean = false;
      var local5:Class = null;
      super();
      this._properties = param1 || new Properties();
      this._name = param1.getProperty("Bundle-Name");
      logService.getLogger(LOG_CHANNEL).trace("BundleDescriptor: Bundle name: %1",[this._name]);
      var local2:Array = [param1.getProperty("Bundle-Activator")];
      if(Boolean(this._name)) {
        local2.push(this._name.toLowerCase() + ".Activator");
      }
      this._activators = new Vector.<IBundleActivator>();
      for each(local3 in local2) {
        local4 = ApplicationDomain.currentDomain.hasDefinition(local3);
        if(local4) {
          local5 = Class(ApplicationDomain.currentDomain.getDefinition(local3));
          this._activators.push(IBundleActivator(new local5()));
          logService.getLogger(LOG_CHANNEL).trace("BundleDescriptor: Activator has been created: %1",[local3]);
        } else {
          logService.getLogger(LOG_CHANNEL).trace("BundleDescriptor: Activator NOT FOUND: %1 ",[local3]);
        }
      }
    }

    public function get name() : String {
      return this._name;
    }

    public function get activators() : Vector.<IBundleActivator> {
      return this._activators;
    }

    public function get properties() : Properties {
      return this._properties;
    }
  }
}
