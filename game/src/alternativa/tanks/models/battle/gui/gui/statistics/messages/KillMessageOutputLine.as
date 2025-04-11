package alternativa.tanks.models.battle.gui.gui.statistics.messages {
  import alternativa.tanks.models.battle.battlefield.common.MessageLine;
  import alternativa.tanks.models.battle.ctf.MessageColor;
  import alternativa.tanks.models.battle.gui.statistics.ShortUserInfo;
  import alternativa.tanks.models.battle.gui.userlabel.BattleActionUserLabel;
  import alternativa.tanks.models.battle.gui.userlabel.BattleChatUserLabel;
  import flash.display.Bitmap;
  import flash.utils.Dictionary;
  import projects.tanks.client.battlefield.types.DamageType;

  public class KillMessageOutputLine extends MessageLine {
    private static var firebirdIconClass:Class = KillMessageOutputLine_firebirdIconClass;
    private static var freezeIconClass:Class = KillMessageOutputLine_freezeIconClass;
    private static var isisIconClass:Class = KillMessageOutputLine_isisIconClass;
    private static var machinegunIconClass:Class = KillMessageOutputLine_machinegunIconClass;
    private static var railgunIconClass:Class = KillMessageOutputLine_railgunIconClass;
    private static var ricochetIconClass:Class = KillMessageOutputLine_ricochetIconClass;
    private static var shaftIconClass:Class = KillMessageOutputLine_shaftIconClass;
    private static var shotgunIconClass:Class = KillMessageOutputLine_shotgunIconClass;
    private static var smokyIconClass:Class = KillMessageOutputLine_smokyIconClass;
    private static var thunderIconClass:Class = KillMessageOutputLine_thunderIconClass;
    private static var twinsIconClass:Class = KillMessageOutputLine_twinsIconClass;
    private static var mineIconClass:Class = KillMessageOutputLine_mineIconClass;
    private static var rocketIconClass:Class = KillMessageOutputLine_rocketIconClass;
    private static var artilleryIconClass:Class = KillMessageOutputLine_artilleryIconClass;
    private static var devastationIconClass:Class = KillMessageOutputLine_devastationIconClass;
    private static var atFieldIconClass:Class = KillMessageOutputLine_atFieldIconClass;
    private static var nuclearIconClass:Class = KillMessageOutputLine_nuclearIconClass;
    private static var gaussIconClass:Class = KillMessageOutputLine_gaussIconClass;
    private static var damage2icon:Dictionary = new Dictionary();

    damage2icon[DamageType.FIREBIRD] = new firebirdIconClass().bitmapData;
    damage2icon[DamageType.FIREBIRD_OVERHEAT] = damage2icon[DamageType.FIREBIRD];
    damage2icon[DamageType.FREEZE] = new freezeIconClass().bitmapData;
    damage2icon[DamageType.ISIS] = new isisIconClass().bitmapData;
    damage2icon[DamageType.MACHINE_GUN] = new machinegunIconClass().bitmapData;
    damage2icon[DamageType.MINE] = new mineIconClass().bitmapData;
    damage2icon[DamageType.TWINS] = new twinsIconClass().bitmapData;
    damage2icon[DamageType.RAILGUN] = new railgunIconClass().bitmapData;
    damage2icon[DamageType.RICOCHET] = new ricochetIconClass().bitmapData;
    damage2icon[DamageType.SHAFT] = new shaftIconClass().bitmapData;
    damage2icon[DamageType.SHOTGUN] = new shotgunIconClass().bitmapData;
    damage2icon[DamageType.SMOKY] = new smokyIconClass().bitmapData;
    damage2icon[DamageType.SMOKY_CRITICAL] = damage2icon[DamageType.SMOKY];
    damage2icon[DamageType.THUNDER] = new thunderIconClass().bitmapData;
    damage2icon[DamageType.ROCKET] = new rocketIconClass().bitmapData;
    damage2icon[DamageType.ARTILLERY] = new artilleryIconClass().bitmapData;
    damage2icon[DamageType.TERMINATOR] = new devastationIconClass().bitmapData;
    damage2icon[DamageType.AT_FIELD] = new atFieldIconClass().bitmapData;
    damage2icon[DamageType.NUCLEAR] = new nuclearIconClass().bitmapData;
    damage2icon[DamageType.GAUSS] = new gaussIconClass().bitmapData;

    public function KillMessageOutputLine(param1:ShortUserInfo, param2:ShortUserInfo, param3:DamageType) {
      super();
      this.createUserLabel(param1,0);
      this.createDamageIcon(param3,6);
      this.createUserLabel(param2,6);
    }

    private function createUserLabel(param1:ShortUserInfo, param2:int) : void {
      var local3:BattleChatUserLabel = new BattleActionUserLabel(param1.userId);
      local3.setUidColor(MessageColor.getUserNameColor(param1.teamType,false),true);
      local3.x = width + param2;
      addChild(local3);
    }

    private function createDamageIcon(param1:DamageType, param2:int) : void {
      var local3:Bitmap = new Bitmap(damage2icon[param1]);
      local3.x = width + param2;
      shadowContainer.addChild(local3);
    }
  }
}
