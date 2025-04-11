package alternativa.tanks.display.resistance {
  import alternativa.tanks.models.battle.gui.statistics.ShortUserInfo;
  import alternativa.tanks.models.statistics.IClientUserInfo;
  import flash.display.Bitmap;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;

  public class ResistanceShieldIcon {
    private static var blueShield:Class = ResistanceShieldIcon_blueShield;
    private static var greenShield:Class = ResistanceShieldIcon_greenShield;
    private static var redShield:Class = ResistanceShieldIcon_redShield;

    public function ResistanceShieldIcon() {
      super();
    }

    public static function getBitmap(param1:BattleTeam) : Bitmap {
      switch(param1) {
        case BattleTeam.BLUE:
          return new blueShield();
        case BattleTeam.RED:
          return new redShield();
        default:
          return new greenShield();
      }
    }

    public static function getBitmapFor(param1:IGameObject) : Bitmap {
      var local2:IGameObject = param1.space.rootObject;
      var local3:IClientUserInfo = IClientUserInfo(local2.adapt(IClientUserInfo));
      var local4:ShortUserInfo = local3.getShortUserInfo(param1.id);
      return getBitmap(local4.teamType);
    }
  }
}
