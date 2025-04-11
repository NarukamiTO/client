package alternativa.tanks.models.effects.description {
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.EffectActivatedEvent;
  import alternativa.tanks.battle.events.EffectStoppedEvent;
  import alternativa.tanks.models.battle.gui.inventory.InventorySoundService;
  import alternativa.tanks.models.effects.activeafetrdeath.IActiveAfterDeath;
  import alternativa.tanks.models.effects.durationTime.IDuration;
  import alternativa.tanks.models.effects.effectlevel.IEffectLevel;
  import alternativa.tanks.models.inventory.InventoryItemType;
  import alternativa.tanks.models.tank.ITankModel;
  import alternativa.tanks.models.tank.ultimate.IUltimateModel;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.battlefield.models.effects.description.EffectCategory;
  import projects.tanks.client.battlefield.models.effects.description.EffectDescriptionCC;
  import projects.tanks.client.battlefield.models.effects.description.EffectDescriptionModelBase;
  import projects.tanks.client.battlefield.models.effects.description.IEffectDescriptionModelBase;

  [ModelInfo]
  public class EffectDescriptionModel extends EffectDescriptionModelBase implements IEffectDescriptionModelBase, ObjectUnloadListener {
    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    [Inject]
    public static var inventorySoundService:InventorySoundService;

    public function EffectDescriptionModel() {
      super();
    }

    [Obfuscation(rename="false")]
    public function objectUnloaded() : void {
      this.deactivated();
    }

    public function merged(param1:int) : void {
      if(getInitParam().category == EffectCategory.OVERDRIVE) {
        this.ultimateEffectMerged(param1);
      } else {
        this.deactivateIcon();
        this.activateIcon(param1);
      }
    }

    public function activated(param1:int) : void {
      inventorySoundService.playActivationSound(getInitParam().tank,getInitParam().index);
      if(getInitParam().category == EffectCategory.OVERDRIVE) {
        this.ultimateEffectActivated(param1);
      } else {
        this.activateIcon(param1);
      }
    }

    public function deactivated() : void {
      var local1:ITankModel = ITankModel(getInitParam().tank.adapt(ITankModel));
      if(local1.isLocal()) {
        inventorySoundService.playDeactivationSound(getInitParam().index);
      }
      if(getInitParam().category == EffectCategory.OVERDRIVE) {
        this.ultimateEffectDeactivated();
      } else {
        this.deactivateIcon();
      }
    }

    private function activateIcon(param1:int) : void {
      var local2:Boolean = getInitParam().category == EffectCategory.INVENTORY;
      var local3:EffectDescriptionCC = getInitParam();
      var local4:Boolean = this.getActiveAfterDeath();
      var local5:int = !!object.hasModel(IEffectLevel) ? int(IEffectLevel(object.adapt(IEffectLevel)).getEffectLevel()) : 0;
      var local6:Boolean = !!object.hasModel(IDuration) ? Boolean(IDuration(object.adapt(IDuration)).isInfinite()) : false;
      battleEventDispatcher.dispatchEvent(new EffectActivatedEvent(local3.tank.id,local3.index,param1,local2,local4,local5,local6));
    }

    private function deactivateIcon() : void {
      var local1:EffectDescriptionCC = getInitParam();
      var local2:Boolean = this.getActiveAfterDeath();
      if(local1.index != InventoryItemType.ULTIMATE) {
        battleEventDispatcher.dispatchEvent(new EffectStoppedEvent(local1.tank.id,local1.index,local2));
      }
    }

    private function ultimateEffectActivated(param1:int) : void {
      var local3:IUltimateModel = null;
      var local2:ITankModel = ITankModel(getInitParam().tank.adapt(ITankModel));
      if(local2.isLocal()) {
        local3 = IUltimateModel(getInitParam().tank.adapt(IUltimateModel));
        local3.effectActivatedOrMerged(param1);
      }
    }

    private function ultimateEffectMerged(param1:int) : void {
      var local3:IUltimateModel = null;
      var local2:ITankModel = ITankModel(getInitParam().tank.adapt(ITankModel));
      if(local2.isLocal()) {
        local3 = IUltimateModel(getInitParam().tank.adapt(IUltimateModel));
        local3.effectActivatedOrMerged(param1);
      }
    }

    private function ultimateEffectDeactivated() : void {
      var local2:IUltimateModel = null;
      var local1:ITankModel = ITankModel(getInitParam().tank.adapt(ITankModel));
      if(local1.isLocal()) {
        local2 = IUltimateModel(getInitParam().tank.adapt(IUltimateModel));
        local2.effectDeactivated();
      }
    }

    private function getActiveAfterDeath() : Boolean {
      return Boolean(object.hasModel(IActiveAfterDeath)) && Boolean(IActiveAfterDeath(object.adapt(IActiveAfterDeath)).isEnabled());
    }
  }
}
