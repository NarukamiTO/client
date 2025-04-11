package platform.client.fp10.core {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.command.CommandService;
  import alternativa.osgi.service.command.FormattedOutput;
  import alternativa.types.Long;
  import flash.system.System;
  import flash.utils.getQualifiedClassName;
  import platform.client.fp10.core.registry.GameTypeRegistry;
  import platform.client.fp10.core.registry.ModelRegistry;
  import platform.client.fp10.core.registry.ResourceRegistry;
  import platform.client.fp10.core.registry.SpaceRegistry;
  import platform.client.fp10.core.resource.Resource;
  import platform.client.fp10.core.service.transport.ITransportService;
  import platform.client.fp10.core.type.IGameClass;
  import platform.client.fp10.core.type.IGameObject;
  import platform.client.fp10.core.type.ISpace;

  public class CoreCommands {
    [Inject]
    public static var gameTypeRegistry:GameTypeRegistry;

    [Inject]
    public static var modelRegister:ModelRegistry;

    [Inject]
    public static var spaceRegistry:SpaceRegistry;

    [Inject]
    public static var resourceRegistry:ResourceRegistry;

    [Inject]
    public static var commandService:CommandService;

    [Inject]
    public static var transportService:ITransportService;

    private var osgi:OSGi;

    public function CoreCommands() {
      super();
      this.osgi = OSGi.getInstance();
      commandService.registerCommand("core","objects","Список загруженных объектов",[],this.cmdObjectsList);
      commandService.registerCommand("core","resource","Список ресурсов",[],this.cmdResourcesList);
      commandService.registerCommand("core","spaces","Список спейсов",[],this.cmdSpacesList);
      commandService.registerCommand("system","gc","Вызвать сборщик мусора (debug only)",[],this.cmdSystemGc);
    }

    private function cmdSystemGc(param1:FormattedOutput) : void {
      System.gc();
    }

    private function cmdSpacesList(param1:FormattedOutput) : void {
      var local3:ISpace = null;
      var local2:Vector.<ISpace> = SpaceRegistry(this.osgi.getService(SpaceRegistry)).spaces;
      for each(local3 in local2) {
        param1.addText("space id: " + (local3.id == null ? "null" : local3.id.toString()));
      }
    }

    private function cmdResourcesList(param1:FormattedOutput) : void {
      var local4:Resource = null;
      var local2:Vector.<Resource> = resourceRegistry.resources;
      var local3:int = 0;
      while(local3 < local2.length) {
        local4 = local2[local3];
        param1.addText(local4.toString());
        local3++;
      }
    }

    private function cmdObjectsList(param1:FormattedOutput) : void {
      var local4:ISpace = null;
      var local5:Vector.<IGameObject> = null;
      var local6:IGameObject = null;
      var local7:IGameClass = null;
      var local8:Vector.<Long> = null;
      var local9:int = 0;
      var local2:Vector.<ISpace> = spaceRegistry.spaces;
      var local3:int = 0;
      while(local3 < local2.length) {
        local4 = local2[local3];
        param1.addText("space id: " + local4.id);
        local5 = local4.objects;
        for each(local6 in local5) {
          param1.addText("  object id: " + local6.id);
          local7 = local6.gameClass;
          if(local7 != null) {
            param1.addText("    class id: " + local7.id);
            local8 = local6.gameClass.models;
            if(local8.length > 0) {
              param1.addText("    models:");
              local9 = 0;
              while(local9 < local8.length) {
                param1.addText("      " + this.getClassName(modelRegister.getModel(local8[local9])) + " [" + local8[local9] + "]");
                local9++;
              }
            }
          } else {
            param1.addText("    class id: null");
          }
        }
        local3++;
      }
    }

    private function getClassName(param1:Object) : String {
      var local2:String = getQualifiedClassName(param1);
      var local3:int = int(local2.indexOf("::"));
      if(local3 > -1) {
        return local2.substr(local3 + 2);
      }
      return local2;
    }
  }
}
