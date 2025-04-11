package alternativa.tanks.display.usertitle {
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import forms.ColorConstants;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;

  public class ProgressBarSkin {
    private static var hpLeftDmCls:Class = ProgressBarSkin_hpLeftDmCls;
    private static var hpLeftDm:BitmapData = Bitmap(new hpLeftDmCls()).bitmapData;
    private static var hpRightDmCls:Class = ProgressBarSkin_hpRightDmCls;
    private static var hpRightDm:BitmapData = Bitmap(new hpRightDmCls()).bitmapData;
    private static var hpLeftBgDmCls:Class = ProgressBarSkin_hpLeftBgDmCls;
    private static var hpLeftBgDm:BitmapData = Bitmap(new hpLeftBgDmCls()).bitmapData;
    private static var hpRightBgDmCls:Class = ProgressBarSkin_hpRightBgDmCls;
    private static var hpRightBgDm:BitmapData = Bitmap(new hpRightBgDmCls()).bitmapData;
    private static var hpLeftBlueCls:Class = ProgressBarSkin_hpLeftBlueCls;
    private static var hpLeftBlue:BitmapData = Bitmap(new hpLeftBlueCls()).bitmapData;
    private static var hpRightBlueCls:Class = ProgressBarSkin_hpRightBlueCls;
    private static var hpRightBlue:BitmapData = Bitmap(new hpRightBlueCls()).bitmapData;
    private static var hpLeftBgBlueCls:Class = ProgressBarSkin_hpLeftBgBlueCls;
    private static var hpLeftBgBlue:BitmapData = Bitmap(new hpLeftBgBlueCls()).bitmapData;
    private static var hpRightBgBlueCls:Class = ProgressBarSkin_hpRightBgBlueCls;
    private static var hpRightBgBlue:BitmapData = Bitmap(new hpRightBgBlueCls()).bitmapData;
    private static var hpLeftRedCls:Class = ProgressBarSkin_hpLeftRedCls;
    private static var hpLeftRed:BitmapData = Bitmap(new hpLeftRedCls()).bitmapData;
    private static var hpRightRedCls:Class = ProgressBarSkin_hpRightRedCls;
    private static var hpRightRed:BitmapData = Bitmap(new hpRightRedCls()).bitmapData;
    private static var hpLeftBgRedCls:Class = ProgressBarSkin_hpLeftBgRedCls;
    private static var hpLeftBgRed:BitmapData = Bitmap(new hpLeftBgRedCls()).bitmapData;
    private static var hpRightBgRedCls:Class = ProgressBarSkin_hpRightBgRedCls;
    private static var hpRightBgRed:BitmapData = Bitmap(new hpRightBgRedCls()).bitmapData;
    private static var weaponLeftCls:Class = ProgressBarSkin_weaponLeftCls;
    private static var weaponLeft:BitmapData = Bitmap(new weaponLeftCls()).bitmapData;
    private static var weaponRightCls:Class = ProgressBarSkin_weaponRightCls;
    private static var weaponRight:BitmapData = Bitmap(new weaponRightCls()).bitmapData;
    private static var weaponLeftBgCls:Class = ProgressBarSkin_weaponLeftBgCls;
    private static var weaponLeftBg:BitmapData = Bitmap(new weaponLeftBgCls()).bitmapData;
    private static var weaponRightBgCls:Class = ProgressBarSkin_weaponRightBgCls;
    private static var weaponRightBg:BitmapData = Bitmap(new weaponRightBgCls()).bitmapData;
    private static var barShadowCls:Class = ProgressBarSkin_barShadowCls;
    private static var barShadow:BitmapData = Bitmap(new barShadowCls()).bitmapData;
    private static var barShadowLeftCls:Class = ProgressBarSkin_barShadowLeftCls;
    private static var barShadowLeft:BitmapData = Bitmap(new barShadowLeftCls()).bitmapData;
    private static var barShadowRightCls:Class = ProgressBarSkin_barShadowRightCls;
    private static var barShadowRight:BitmapData = Bitmap(new barShadowRightCls()).bitmapData;

    private static const COLOR_DM:uint = 4964125;
    private static const COLOR_DM_BG:uint = 2448911;
    private static const COLOR_TEAM_BLUE:uint = ColorConstants.USER_TITLE_BLUE;
    private static const COLOR_TEAM_BLUE_BG:uint = 2181375;
    private static const COLOR_TEAM_RED:uint = ColorConstants.USER_TITLE_RED;
    private static const COLOR_TEAM_RED_BG:uint = 10556937;
    private static const COLOR_WEAPON_BAR:uint = ColorConstants.USER_TITLE_YELLOW;
    private static const COLOR_WEAPON_BAR_BG:uint = 7758340;

    public static const HEALTHBAR_DM:ProgressBarSkin = new ProgressBarSkin(COLOR_DM,COLOR_DM_BG,hpLeftDm,hpLeftBgDm,hpRightDm,hpRightBgDm,barShadow,barShadowLeft,barShadowRight);
    public static const HEALTHBAR_BLUE:ProgressBarSkin = new ProgressBarSkin(COLOR_TEAM_BLUE,COLOR_TEAM_BLUE_BG,hpLeftBlue,hpLeftBgBlue,hpRightBlue,hpRightBgBlue,barShadow,barShadowLeft,barShadowRight);
    public static const HEALTHBAR_RED:ProgressBarSkin = new ProgressBarSkin(COLOR_TEAM_RED,COLOR_TEAM_RED_BG,hpLeftRed,hpLeftBgRed,hpRightRed,hpRightBgRed,barShadow,barShadowLeft,barShadowRight);
    public static const WEAPONBAR:ProgressBarSkin = new ProgressBarSkin(COLOR_WEAPON_BAR,COLOR_WEAPON_BAR_BG,weaponLeft,weaponLeftBg,weaponRight,weaponRightBg,barShadow,barShadowLeft,barShadowRight);

    public var color:uint;
    public var bgColor:uint;
    public var leftTipFg:BitmapData;
    public var leftTipBg:BitmapData;
    public var rightTipFg:BitmapData;
    public var rightTipBg:BitmapData;
    public var shadowLeftTip:BitmapData;
    public var shadowRightTip:BitmapData;
    public var shadow:BitmapData;

    public function ProgressBarSkin(param1:uint, param2:uint, param3:BitmapData, param4:BitmapData, param5:BitmapData, param6:BitmapData, param7:BitmapData, param8:BitmapData, param9:BitmapData) {
      super();
      this.color = param1;
      this.bgColor = param2;
      this.leftTipFg = param3;
      this.leftTipBg = param4;
      this.rightTipFg = param5;
      this.rightTipBg = param6;
      this.shadow = param7;
      this.shadowLeftTip = param8;
      this.shadowRightTip = param9;
    }

    public static function getHealthBarSkin(param1:BattleTeam) : ProgressBarSkin {
      switch(param1) {
        case BattleTeam.BLUE:
          return HEALTHBAR_BLUE;
        case BattleTeam.RED:
          return HEALTHBAR_RED;
        default:
          return HEALTHBAR_DM;
      }
    }
  }
}
