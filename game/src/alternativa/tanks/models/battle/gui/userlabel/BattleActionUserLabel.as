package alternativa.tanks.models.battle.gui.userlabel {
  import alternativa.types.Long;

  public class BattleActionUserLabel extends BattleChatUserLabel {
    public function BattleActionUserLabel(param1:Long) {
      super(param1,false);
    }

    [Obfuscation(rename="false")]
    override protected function createAdditionalIcons() : void {
    }

    [Obfuscation(rename="false")]
    override protected function getAdditionalIconsWidth() : Number {
      return 0;
    }
  }
}
