package alternativa.tanks.models.tank.bosstate {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.models.battle.ctf.MessageColor;
  import alternativa.tanks.models.battle.gui.BattlefieldGUI;
  import alternativa.tanks.models.battle.gui.inventory.IInventoryPanel;
  import alternativa.tanks.models.inventory.IInventoryModel;
  import alternativa.tanks.models.inventory.InventoryItemType;
  import alternativa.tanks.models.inventory.InventoryLock;
  import alternativa.tanks.models.tank.ITankModel;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import projects.tanks.client.battlefield.models.user.bossstate.BossRelationRole;
  import projects.tanks.client.battlefield.models.user.bossstate.BossStateModelBase;
  import projects.tanks.client.battlefield.models.user.bossstate.IBossStateModelBase;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;

  [ModelInfo]
  public class BossStateModel extends BossStateModelBase implements IBossStateModelBase, IBossState, ObjectLoadListener {
    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var battleInfoService:IBattleInfoService;

    [Inject]
    public static var inventoryPanel:IInventoryPanel;

    private var inventoryLockMask:Vector.<int>;

    public function BossStateModel() {
      super();
      this.inventoryLockMask = new Vector.<int>();
      this.inventoryLockMask.push(InventoryItemType.FIRST_AID);
      this.inventoryLockMask.push(InventoryItemType.ARMOR);
      this.inventoryLockMask.push(InventoryItemType.DAMAGE);
      this.inventoryLockMask.push(InventoryItemType.NITRO);
      this.inventoryLockMask.push(InventoryItemType.MINE);
    }

    public function objectLoaded() : void {
      putData(BossRelationRole,getInitParam().role);
    }

    public function changeRole(param1:BossRelationRole) : void {
      var local3:IInventoryModel = null;
      var local4:String = null;
      putData(BossRelationRole,param1);
      var local2:ITankModel = ITankModel(object.adapt(ITankModel));
      if(local2.getUserInfo().isLocal) {
        this.setInfiniteEffect(param1);
        if(param1 == BossRelationRole.INCARNATION) {
          local4 = localeService.getText(TanksLocale.TEXT_JGR_YOU_ARE_THE_BOSS);
          this.getBattleGUI().showBattleMessage(MessageColor.POSITIVE,local4);
        }
        local3 = IInventoryModel(object.space.rootObject.adapt(IInventoryModel));
        if(param1 == BossRelationRole.BOSS || param1 == BossRelationRole.INCARNATION) {
          local3.lockItemsByMask(this.inventoryLockMask,InventoryLock.BOSS_STATE,true);
          battleInfoService.enterGarageCausesExitBattle = true;
        } else {
          local3.lockItemsByMask(this.inventoryLockMask,InventoryLock.BOSS_STATE,false);
          battleInfoService.enterGarageCausesExitBattle = false;
        }
      }
    }

    private function setInfiniteEffect(param1:BossRelationRole) : void {
      var local2:Boolean = param1 == BossRelationRole.BOSS;
      if(!local2) {
        return;
      }
      inventoryPanel.setEffectInfinite(InventoryItemType.ARMOR,true);
      inventoryPanel.setEffectInfinite(InventoryItemType.DAMAGE,true);
      inventoryPanel.setEffectInfinite(InventoryItemType.NITRO,true);
    }

    public function role() : BossRelationRole {
      var local1:BossRelationRole = BossRelationRole(getData(BossRelationRole));
      return local1 != null ? local1 : BossRelationRole.VICTIM;
    }

    private function getBattleGUI() : BattlefieldGUI {
      return BattlefieldGUI(object.space.rootObject.adapt(BattlefieldGUI));
    }
  }
}
