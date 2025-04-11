package alternativa.tanks.models.battle.battlefield {
  import alternativa.tanks.utils.EncryptedInt;
  import alternativa.tanks.utils.EncryptedIntImpl;
  import flash.media.Sound;

  public class BattleData {
    public var respawnDurationMs:int;
    public var battleFinishSound:Sound;
    public var ambientSound:Sound;
    public var tankExplosionSound:Sound;

    private var idleKickPeriod:EncryptedInt = new EncryptedIntImpl();

    public function BattleData() {
      super();
    }

    public function setIdleKickPeriod(param1:int) : void {
      this.idleKickPeriod.setInt(param1);
    }

    public function getIdleKickPeriod() : int {
      return this.idleKickPeriod.getInt();
    }
  }
}
