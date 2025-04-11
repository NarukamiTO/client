package alternativa.tanks.models.tank.support {
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.tanks.battle.objects.tank.TankControlLockBits;
  import alternativa.tanks.models.tank.ITankModel;
  import alternativa.tanks.models.tank.IWeaponController;
  import flash.events.Event;
  import platform.client.fp10.core.type.AutoClosable;
  import platform.client.fp10.core.type.IGameObject;

  public class ClientDeactivationSupport implements AutoClosable {
    [Inject]
    public static var display:IDisplay;

    private var localUserObject:IGameObject;

    public function ClientDeactivationSupport(param1:IGameObject) {
      super();
      this.localUserObject = param1;
      display.stage.addEventListener(Event.ACTIVATE,this.onClientWindowActivate);
      display.stage.addEventListener(Event.DEACTIVATE,this.onClientWindowDeactivate);
    }

    private function onClientWindowActivate(param1:Event) : void {
      var local2:IWeaponController = this.getWeaponController();
      local2.unlockWeapon(TankControlLockBits.CLIENT);
    }

    private function onClientWindowDeactivate(param1:Event) : void {
      var local2:IWeaponController = this.getWeaponController();
      local2.lockWeapon(TankControlLockBits.CLIENT,true);
    }

    private function getWeaponController() : IWeaponController {
      var local1:ITankModel = ITankModel(this.localUserObject.adapt(ITankModel));
      return local1.getWeaponController();
    }

    [Obfuscation(rename="false")]
    public function close() : void {
      this.localUserObject = null;
      display.stage.removeEventListener(Event.ACTIVATE,this.onClientWindowActivate);
      display.stage.removeEventListener(Event.DEACTIVATE,this.onClientWindowDeactivate);
    }
  }
}
