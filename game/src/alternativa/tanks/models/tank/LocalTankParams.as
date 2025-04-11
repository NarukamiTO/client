package alternativa.tanks.models.tank {
  import alternativa.tanks.utils.EncryptedInt;
  import alternativa.tanks.utils.EncryptedIntImpl;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;

  public class LocalTankParams {
    public static var teamType:BattleTeam = BattleTeam.NONE;

    private static const specificationId:EncryptedInt = new EncryptedIntImpl();

    public function LocalTankParams() {
      super();
    }

    public static function setSpecificationId(param1:int) : void {
      specificationId.setInt(param1);
    }

    public static function getSpecificationId() : int {
      return specificationId.getInt();
    }
  }
}
