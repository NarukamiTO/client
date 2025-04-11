package alternativa.osgi.service.command.impl {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.bundle.IBundleDescriptor;
  import alternativa.osgi.catalogs.ServiceInfo;
  import alternativa.osgi.catalogs.ServiceParam;
  import alternativa.osgi.service.command.CommandService;
  import alternativa.osgi.service.command.FormattedOutput;

  public class OSGiCommands {
    private var commandService:CommandService;
    private var osgi:OSGi;

    public function OSGiCommands(param1:OSGi, param2:CommandService) {
      super();
      this.osgi = param1;
      this.commandService = param2;
      param2.registerCommand("osgi","ss","Список плагинов",[],this.cmdBundlesList);
      param2.registerCommand("osgi","services","Список сервисов",[],this.cmdServicesList);
    }

    public function cmdBundlesList(param1:FormattedOutput) : void {
      var local2:Vector.<IBundleDescriptor> = this.osgi.bundleList;
      var local3:int = 0;
      while(local3 < local2.length) {
        param1.addText(int(local3 + 1).toString() + ". " + local2[local3].name);
        local3++;
      }
    }

    public function cmdServicesList(param1:FormattedOutput) : void {
      var local4:ServiceInfo = null;
      var local2:Vector.<ServiceInfo> = this.osgi.getServicesInfo();
      var local3:int = 0;
      while(local3 < local2.length) {
        local4 = local2[local3];
        param1.addText((local3 + 1).toString() + ": " + local4.service + this.getServicesParam(local4.params));
        local3++;
      }
    }

    private function getServicesParam(param1:Vector.<ServiceParam>) : String {
      var local3:int = 0;
      var local4:int = 0;
      var local5:ServiceParam = null;
      var local2:String = " ";
      if(param1 != null) {
        local3 = 0;
        local4 = int(param1.length);
        while(local3 < local4) {
          local5 = param1[local3];
          local2 += "(" + local5.name + " = " + local5.value + ")";
          local3++;
        }
      }
      return local2;
    }
  }
}
