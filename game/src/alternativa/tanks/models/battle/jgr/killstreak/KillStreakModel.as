package alternativa.tanks.models.battle.jgr.killstreak {
  import alternativa.tanks.models.battle.ctf.MessageColor;
  import alternativa.tanks.models.battle.gui.BattlefieldGUI;
  import alternativa.tanks.models.battle.gui.statistics.ShortUserInfo;
  import alternativa.tanks.models.battle.jgr.Juggernaut;
  import alternativa.tanks.models.statistics.IClientUserInfo;
  import alternativa.tanks.models.tank.bosstate.IBossState;
  import alternativa.tanks.services.tankregistry.TankUsersRegistry;
  import alternativa.tanks.sfx.Sound3D;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import projects.tanks.client.battlefield.models.battle.jgr.killstreak.IKillStreakModelBase;
  import projects.tanks.client.battlefield.models.battle.jgr.killstreak.KillStreakItem;
  import projects.tanks.client.battlefield.models.battle.jgr.killstreak.KillStreakModelBase;
  import projects.tanks.client.battlefield.models.user.bossstate.BossRelationRole;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;

  [ModelInfo]
  public class KillStreakModel extends KillStreakModelBase implements IKillStreakModelBase, ObjectLoadListener {
    [Inject]
    public static var usersRegistry:TankUsersRegistry;

    [Inject]
    public static var battleInfoService:IBattleInfoService;

    private static const KILLSTREAK_VOLUME:Number = 0.9;

    private var killStreaks:Vector.<KillStreakClientItem> = new Vector.<KillStreakClientItem>();

    public function KillStreakModel() {
      super();
    }

    private static function getUserUid(param1:Long) : String {
      var local2:ShortUserInfo = null;
      if(param1 != null) {
        local2 = IClientUserInfo(object.adapt(IClientUserInfo)).getShortUserInfo(param1);
        if(local2 != null) {
          return local2.uid;
        }
      }
      return null;
    }

    public function objectLoaded() : void {
      var local2:KillStreakItem = null;
      var local3:Sound3D = null;
      this.killStreaks.length = getInitParam().items.length;
      var local1:int = 0;
      while(local1 < getInitParam().items.length) {
        local2 = getInitParam().items[local1];
        local3 = Sound3D.create(local2.sound.sound);
        local3.volume = KILLSTREAK_VOLUME;
        this.killStreaks[local1] = new KillStreakClientItem(local2.messageToBoss,local2.messageToVictims,local3);
        local1++;
      }
    }

    public function killStreakAchived(param1:int) : void {
      var local4:String = null;
      var local6:Sound3D = null;
      var local2:KillStreakClientItem = this.killStreaks[param1];
      var local3:BossRelationRole = !battleInfoService.isSpectatorMode() ? IBossState(usersRegistry.getLocalUser().adapt(IBossState)).role() : null;
      if(local3 == BossRelationRole.BOSS) {
        local4 = local2.messageToBoss != null ? local2.messageToBoss : local2.messageToVictims;
      } else {
        local4 = local2.messageToVictims;
      }
      var local5:String = getUserUid(object.adapt(Juggernaut).bossId());
      if(local5 != null) {
        local4 = local4.replace("%1",local5);
      }
      this.getGuiModel().showBattleMessage(MessageColor.ORANGE,local4);
      if(local2.sound != null) {
        local6 = null;
        if(local6 != null) {
          local6.stop();
        }
        local2.sound.play(0,0);
      }
    }

    private function getGuiModel() : BattlefieldGUI {
      return BattlefieldGUI(object.adapt(BattlefieldGUI));
    }
  }
}
