package alternativa.tanks.models.battle.battlefield.keyboard {
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.BattleEventListener;
  import alternativa.tanks.battle.events.TankLoadedEvent;
  import alternativa.tanks.display.usertitle.UserTitle;
  import alternativa.tanks.model.garage.resistance.ResistancesIcons;
  import alternativa.tanks.models.tank.LocalTankInfoService;
  import alternativa.tanks.models.tank.device.TankDevice;
  import alternativa.tanks.models.tank.resistance.TankResistances;
  import alternativa.tanks.service.settings.keybinding.GameActionEnum;
  import alternativa.tanks.services.battlegui.BattleGUIService;
  import alternativa.tanks.services.battlegui.BattleGUIServiceEvent;
  import alternativa.tanks.services.battleinput.BattleInputService;
  import alternativa.tanks.services.battleinput.GameActionListener;
  import alternativa.utils.removeDisplayObject;
  import base.DiscreteSprite;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.events.Event;
  import platform.client.fp10.core.type.AutoClosable;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.user.resistance.TankResistance;

  public class AdditionUserTitleSwitcher implements BattleEventListener, GameActionListener, AutoClosable {
    [Inject]
    public static var battleInputService:BattleInputService;

    [Inject]
    public static var display:IDisplay;

    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    [Inject]
    public static var battleGuiService:BattleGUIService;

    [Inject]
    public static var localTankService:LocalTankInfoService;

    private static const RESISTANCE_ICON_SIZE:int = 34;

    private var ownResistances:Bitmap;
    private var ownDevice:Bitmap;

    public function AdditionUserTitleSwitcher() {
      super();
      battleEventDispatcher.addBattleEventListener(TankLoadedEvent,this);
      battleInputService.addGameActionListener(this);
    }

    public function onGameAction(param1:GameActionEnum, param2:Boolean) : void {
      if(param1 == GameActionEnum.SHOW_TANK_PARAMETERS) {
        UserTitle.showAddition = param2;
        if(this.ownResistances != null) {
          this.ownResistances.visible = param2;
        }
        if(this.ownDevice != null) {
          this.ownDevice.visible = param2;
        }
      }
    }

    private function onResize(param1:Event = null) : void {
      if(this.ownResistances != null) {
        this.ownResistances.x = display.stage.stageWidth - this.ownResistances.width >> 1;
        this.ownResistances.y = display.stage.stageHeight - 103;
      }
      if(this.ownDevice != null) {
        this.ownDevice.x = display.stage.stageWidth - this.ownDevice.width >> 1;
        this.ownDevice.y = display.stage.stageHeight - (this.ownResistances == null ? 123 : 163);
      }
    }

    public function handleBattleEvent(param1:Object) : void {
      var local2:TankLoadedEvent = TankLoadedEvent(param1);
      if(local2.isLocal) {
        this.clearOwnResistances();
        this.clearOwnDevice();
        display.stage.addEventListener(Event.RESIZE,this.onResize,false,-1);
        battleGuiService.addEventListener(BattleGUIServiceEvent.ON_CHANGE_POSITION_DEFAULT_LAYOUT,this.onResize);
        this.createOwnResistances();
        this.createOwnDevice();
      }
    }

    private function createOwnResistances() : void {
      var local1:DiscreteSprite = null;
      var local6:TankResistance = null;
      var local7:Bitmap = null;
      var local8:Bitmap = null;
      var local9:BitmapData = null;
      local1 = new DiscreteSprite();
      local1.visible = false;
      battleGuiService.getGuiContainer().addChild(local1);
      var local2:IGameObject = localTankService.getLocalTankObject();
      var local3:TankResistances = TankResistances(local2.adapt(TankResistances));
      var local4:Vector.<TankResistance> = local3.getResistances();
      var local5:int = 0;
      while(local5 < local4.length) {
        local6 = local4[local5];
        local7 = new ResistancesIcons.resistanceIconClass();
        local7.x = RESISTANCE_ICON_SIZE * local5;
        local1.addChild(local7);
        local8 = new Bitmap(ResistancesIcons.getBitmapDataByName(local6.resistanceProperty.name));
        local8.x = (local7.width - local8.width >> 1) + local7.x;
        local8.y = (local7.height - local8.height >> 1) + local7.y;
        local1.addChild(local8);
        local5++;
      }
      if(local1.width != 0) {
        local9 = new BitmapData(local4.length * RESISTANCE_ICON_SIZE,RESISTANCE_ICON_SIZE,true,0);
        local9.draw(local1);
        this.ownResistances = new Bitmap(local9);
        battleGuiService.getGuiContainer().addChild(this.ownResistances);
        this.ownResistances.visible = UserTitle.showAddition;
        this.onResize();
      }
    }

    private function createOwnDevice() : void {
      var local1:IGameObject = localTankService.getLocalTankObject();
      var local2:TankDevice = TankDevice(local1.adapt(TankDevice));
      var local3:BitmapData = DeviceIcons.getByDeviceId(local2.getDevice());
      if(local3 == null) {
        return;
      }
      var local4:DiscreteSprite = new DiscreteSprite();
      local4.visible = false;
      battleGuiService.getGuiContainer().addChild(local4);
      var local5:Bitmap = new Bitmap(DeviceIcons.backgroundIcon);
      var local6:Bitmap = new Bitmap(local3);
      local6.x = (local5.width - local6.width >> 1) + local5.x;
      local6.y = (local5.height - local6.height >> 1) + local5.y;
      local4.addChild(local5);
      local4.addChild(local6);
      var local7:BitmapData = new BitmapData(local4.width,local4.height,true,0);
      local7.draw(local4);
      this.ownDevice = new Bitmap(local7);
      battleGuiService.getGuiContainer().addChild(this.ownDevice);
      this.ownDevice.visible = UserTitle.showAddition;
      this.onResize();
    }

    [Obfuscation(rename="false")]
    public function close() : void {
      battleEventDispatcher.removeBattleEventListener(TankLoadedEvent,this);
      battleInputService.removeGameActionListener(this);
      this.clearOwnResistances();
      this.clearOwnDevice();
    }

    private function clearOwnResistances() : void {
      if(this.ownResistances != null) {
        display.stage.removeEventListener(Event.RESIZE,this.onResize);
        battleGuiService.removeEventListener(BattleGUIServiceEvent.ON_CHANGE_POSITION_DEFAULT_LAYOUT,this.onResize);
        removeDisplayObject(this.ownResistances);
        this.ownResistances.bitmapData.dispose();
        this.ownResistances = null;
      }
    }

    private function clearOwnDevice() : void {
      if(this.ownDevice != null) {
        display.stage.removeEventListener(Event.RESIZE,this.onResize);
        battleGuiService.removeEventListener(BattleGUIServiceEvent.ON_CHANGE_POSITION_DEFAULT_LAYOUT,this.onResize);
        removeDisplayObject(this.ownDevice);
        this.ownDevice.bitmapData.dispose();
        this.ownDevice = null;
      }
    }
  }
}
