package alternativa.osgi.catalogs {
  import alternativa.osgi.service.IServiceRegisterListener;
  import flash.utils.Dictionary;

  public class ServiceListenersCatalog {
    private var dictionary:Dictionary = new Dictionary();
    private var listeners:Vector.<IServiceRegisterListener> = new Vector.<IServiceRegisterListener>();

    public function ServiceListenersCatalog() {
      super();
    }

    public function addListener(param1:IServiceRegisterListener, param2:String) : void {
      var local3:Vector.<String> = this.dictionary[param1];
      if(local3 == null) {
        local3 = new Vector.<String>();
        this.dictionary[param1] = local3;
      }
      if(local3.indexOf(param2) == -1) {
        local3.push(param2);
      }
      if(this.listeners.indexOf(param1) == -1) {
        this.listeners.push(param1);
      }
    }

    public function removeListener(param1:IServiceRegisterListener, param2:String) : void {
      var local3:Vector.<String> = this.dictionary[param1];
      var local4:Number = Number(local3.indexOf(param2));
      if(local4 >= 0) {
        local3.splice(local4,1);
      }
      if(local3.length == 0) {
        delete this.dictionary[param1];
        local4 = Number(this.listeners.indexOf(param1));
        this.listeners.splice(local4,1);
      }
    }

    public function getListeners() : Vector.<IServiceRegisterListener> {
      return this.listeners.concat();
    }

    public function getFilters(param1:IServiceRegisterListener) : Vector.<String> {
      return this.dictionary[param1];
    }
  }
}
