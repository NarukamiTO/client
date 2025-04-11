package alternativa.tanks.models.statistics {
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.BattleEventListener;
  import alternativa.tanks.battle.events.ControlMiniHelpCloseEvent;
  import alternativa.tanks.models.battle.gui.gui.help.ControlsMiniHelp;
  import alternativa.tanks.services.battlegui.BattleGUIService;
  import flash.events.Event;
  import flash.net.SharedObject;
  import platform.client.fp10.core.type.AutoClosable;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.storage.IStorageService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;

  public class ControlsMiniHelpSupport implements AutoClosable, BattleEventListener {
    [Inject]
    public static var storageService:IStorageService;

    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    [Inject]
    public static var userPropertiesService:IUserPropertiesService;

    [Inject]
    public static var display:IDisplay;

    [Inject]
    public static var battleGuiService:BattleGUIService;

    private static const SHARED_OBJECT_KEY:String = "disableControlsMiniHelp";

    private var controlsMiniHelp:ControlsMiniHelp;

    public function ControlsMiniHelpSupport() {
      super();
      var local1:SharedObject = storageService.getStorage();
      if(!local1.data[SHARED_OBJECT_KEY]) {
        if(userPropertiesService.rank == 1) {
          local1.data[SHARED_OBJECT_KEY] = 1;
          this.setupMiniHelp();
        }
      }
    }

    private function setupMiniHelp() : void {
      this.controlsMiniHelp = new ControlsMiniHelp();
      battleGuiService.getGuiContainer().addChild(this.controlsMiniHelp);
      this.setPosition();
      battleEventDispatcher.addBattleEventListener(ControlMiniHelpCloseEvent,this);
      display.stage.addEventListener(Event.RESIZE,this.onResize);
    }

    private function onResize(param1:Event) : void {
      this.setPosition();
    }

    private function setPosition() : void {
      this.controlsMiniHelp.x = display.stage.stageWidth - this.controlsMiniHelp.width >> 1;
      this.controlsMiniHelp.y = display.stage.stageHeight - this.controlsMiniHelp.height * 2;
    }

    public function handleBattleEvent(param1:Object) : void {
      if(param1 is ControlMiniHelpCloseEvent) {
        this.close();
      }
    }

    [Obfuscation(rename="false")]
    public function close() : void {
      if(this.controlsMiniHelp != null) {
        display.stage.removeEventListener(Event.RESIZE,this.onResize);
        battleEventDispatcher.removeBattleEventListener(ControlMiniHelpCloseEvent,this);
        this.controlsMiniHelp.parent.removeChild(this.controlsMiniHelp);
        this.controlsMiniHelp = null;
      }
    }
  }
}
