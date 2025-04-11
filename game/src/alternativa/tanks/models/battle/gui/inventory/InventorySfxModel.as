package alternativa.tanks.models.battle.gui.inventory {
  import alternativa.math.Vector3;
  import alternativa.osgi.OSGi;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.models.inventory.InventoryItemType;
  import alternativa.tanks.models.tank.ITankModel;
  import alternativa.tanks.sfx.Sound3D;
  import alternativa.tanks.sfx.Sound3DEffect;
  import flash.media.Sound;
  import flash.utils.Dictionary;
  import flash.utils.clearTimeout;
  import flash.utils.setTimeout;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.inventory.sfx.IInventorySfxModelBase;
  import projects.tanks.client.battlefield.models.inventory.sfx.InventorySfxCC;
  import projects.tanks.client.battlefield.models.inventory.sfx.InventorySfxModelBase;

  [ModelInfo]
  public class InventorySfxModel extends InventorySfxModelBase implements IInventorySfxModelBase, ObjectLoadListener, ObjectUnloadListener, InventorySoundService {
    [Inject]
    public static var battleService:BattleService;

    private var readySoundTimer:uint;
    private var deactivationTimers:Dictionary = new Dictionary();
    private var ultimates:Dictionary = new Dictionary();
    private var params:InventorySfxCC;

    public function InventorySfxModel() {
      super();
    }

    private static function play3dSound(param1:Sound, param2:Vector3) : void {
      var local3:Sound3D = null;
      if(param1 != null) {
        local3 = Sound3D.create(param1,1);
        battleService.addSound3DEffect(Sound3DEffect.create(param2,local3));
      }
    }

    private static function playSound(param1:Sound) : void {
      if(param1 != null) {
        battleService.soundManager.playSound(param1);
      }
    }

    public function objectLoaded() : void {
      this.params = getInitParam();
      OSGi.getInstance().registerService(InventorySoundService,this);
    }

    public function objectUnloaded() : void {
      OSGi.getInstance().unregisterService(InventorySoundService);
      this.params = null;
    }

    public function playActivationSound(param1:IGameObject, param2:int) : void {
      if(this.ultimates[param1] != null) {
        return;
      }
      if(param2 == InventoryItemType.ULTIMATE) {
        this.ultimates[param1] = setTimeout(this.clearUltimate,10,param1);
      }
      var local3:Sound = this.getActivationSound(param2);
      var local4:Vector3 = ITankModel(param1.adapt(ITankModel)).getTank().getBody().state.position;
      play3dSound(local3,local4);
    }

    public function playDeactivationSound(param1:int) : void {
      if(this.deactivationTimers[param1] == null) {
        setTimeout(this.doPlayDeactivationSound,5,param1);
      }
    }

    public function playReadySound(param1:int) : void {
      if(this.deactivationTimers[param1] != null) {
        clearTimeout(this.deactivationTimers[param1]);
        delete this.deactivationTimers[param1];
      }
      if(this.readySoundTimer == 0) {
        this.readySoundTimer = setTimeout(this.doPlayReadySound,10);
      }
    }

    public function playNotReadySound() : void {
      playSound(this.params.notReadySound.sound);
    }

    private function clearUltimate(param1:IGameObject) : void {
      clearTimeout(this.ultimates[param1]);
      delete this.ultimates[param1];
    }

    private function getActivationSound(param1:int) : Sound {
      switch(param1) {
        case InventoryItemType.FIRST_AID:
          return this.params.healingSound.sound;
        case InventoryItemType.ARMOR:
          return this.params.daOnSound.sound;
        case InventoryItemType.DAMAGE:
          return this.params.ddOnSound.sound;
        case InventoryItemType.NITRO:
          return this.params.nitroOnSound.sound;
        default:
          return null;
      }
    }

    private function doPlayDeactivationSound(param1:int) : void {
      clearTimeout(this.deactivationTimers[param1]);
      delete this.deactivationTimers[param1];
      if(this.isBattleActive()) {
        playSound(this.getDeactivationSound(param1));
      }
    }

    private function getDeactivationSound(param1:int) : Sound {
      switch(param1) {
        case InventoryItemType.ARMOR:
          return this.params.daOffSound.sound;
        case InventoryItemType.DAMAGE:
          return this.params.ddOffSound.sound;
        case InventoryItemType.NITRO:
          return this.params.nitroOffSound.sound;
        default:
          return null;
      }
    }

    private function doPlayReadySound() : void {
      clearTimeout(this.readySoundTimer);
      this.readySoundTimer = 0;
      if(this.isBattleActive()) {
        playSound(this.params.readySound.sound);
      }
    }

    private function isBattleActive() : Boolean {
      return Boolean(battleService) && Boolean(battleService.isBattleActive());
    }
  }
}
