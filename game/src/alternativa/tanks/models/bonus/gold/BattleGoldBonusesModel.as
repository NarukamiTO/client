package alternativa.tanks.models.bonus.gold {
  import alternativa.engine3d.core.MipMapping;
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.math.Vector3;
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.models.battle.battlefield.BattleUserInfoService;
  import alternativa.tanks.models.battle.ctf.MessageColor;
  import alternativa.tanks.models.battle.gui.BattlefieldGUI;
  import alternativa.tanks.models.battle.gui.gui.statistics.messages.UserAction;
  import alternativa.tanks.sfx.BonusCrystalsEffectUtils;
  import alternativa.tanks.sfx.Sound3D;
  import alternativa.tanks.sfx.Sound3DEffect;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.type.IGameObject;
  import platform.client.fp10.core.type.ISpace;
  import projects.tanks.client.battlefield.models.bonus.bonus.battlebonuses.crystal.BattleGoldBonusesModelBase;
  import projects.tanks.client.battlefield.models.bonus.bonus.battlebonuses.crystal.IBattleGoldBonusesModelBase;
  import projects.tanks.client.battlefield.types.Vector3d;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;

  [ModelInfo]
  public class BattleGoldBonusesModel extends BattleGoldBonusesModelBase implements IBattleGoldBonusesModelBase, ObjectLoadListener {
    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var userInfoService:BattleUserInfoService;

    [Inject]
    public static var userPropertiesService:IUserPropertiesService;

    public static const DELAY:int = 800;

    public function BattleGoldBonusesModel() {
      super();
    }

    [Obfuscation(rename="false")]
    public function goldTaken(param1:IGameObject) : void {
      if(param1 != null) {
        this.showBonusPickupNotification(param1,TanksLocale.TEXT_BATTLE_GOLD_TAKEN);
      }
    }

    private function showBonusPickupNotification(param1:IGameObject, param2:String) : void {
      var local8:ISpace = null;
      var local9:IGameObject = null;
      var local10:BattlefieldGUI = null;
      var local3:Vector3d = BonusCrystalsEffectUtils.getTargetPosition(param1);
      var local4:TextureMaterial = TextureMaterial(getData(TextureMaterial));
      BonusCrystalsEffectUtils.drawEffectForCatcherPosition(local3,DELAY,local4);
      var local5:Sound3D = Sound3D.create(getInitParam().sound.sound,0.5);
      var local6:Vector3 = new Vector3(local3.x,local3.y,local3.z + 300);
      battleService.addSound3DEffect(Sound3DEffect.create(local6,local5,DELAY));
      var local7:String = userInfoService.getUserName(param1.id);
      if(local7 != null) {
        local8 = object.space;
        local9 = local8.rootObject;
        local10 = BattlefieldGUI(local9.adapt(BattlefieldGUI));
        local10.showBattleMessage(MessageColor.ORANGE,local7 + localeService.getText(param2));
        local10.showUserBattleLogMessage(param1.id,UserAction.PLAYER_GOLD_BOX);
      }
    }

    [Obfuscation(rename="false")]
    public function objectLoaded() : void {
      var local1:TextureMaterial = new TextureMaterial(getInitParam().sprite.data,false,true,MipMapping.PER_PIXEL,1);
      putData(TextureMaterial,local1);
    }
  }
}
