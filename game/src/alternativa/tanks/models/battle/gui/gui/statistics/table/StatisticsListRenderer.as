package alternativa.tanks.models.battle.gui.gui.statistics.table {
  import alternativa.tanks.models.battle.gui.userlabel.StatisticsListUserLabel;
  import controls.Label;
  import controls.Money;
  import controls.resultassets.ResultWindowBlueNormal;
  import controls.resultassets.ResultWindowBlueSelected;
  import controls.resultassets.ResultWindowGreenNormal;
  import controls.resultassets.ResultWindowGreenSelected;
  import controls.resultassets.ResultWindowRedNormal;
  import controls.resultassets.ResultWindowRedSelected;
  import fl.controls.listClasses.CellRenderer;
  import fl.controls.listClasses.ListData;
  import flash.display.DisplayObject;
  import flash.display.DisplayObjectContainer;
  import flash.display.Sprite;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFormatAlign;
  import forms.ColorConstants;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;

  public class StatisticsListRenderer extends CellRenderer {
    [Inject]
    public static var battleInfoService:IBattleInfoService;
    public static var showBonus:Boolean;

    private static const COLOR_NORMAL:uint = 16777215;
    private static const COLOR_NOT_LOADED:uint = 11184810;
    private static const COLOR_GOLD:uint = 15976448;
    private static const COLOR_GREY:uint = 10921638;
    private static const DASH_TEXT:String = "—";

    private var nicon:DisplayObject;

    public function StatisticsListRenderer() {
      super();
      this.mouseChildren = true;
      this.buttonMode = this.useHandCursor = false;
    }

    private static function createCell(param1:DisplayObjectContainer, param2:String, param3:uint, param4:String, param5:int, param6:int) : Label {
      var local7:Label = null;
      local7 = new Label();
      local7.mouseEnabled = false;
      local7.autoSize = TextFieldAutoSize.NONE;
      local7.text = param2;
      local7.color = param3;
      local7.align = param4;
      local7.x = param6;
      local7.width = param5;
      local7.height = TableConst.ROW_HEIGHT;
      param1.addChild(local7);
      return local7;
    }

    private static function createStarsRewardCell(param1:DisplayObjectContainer, param2:int, param3:uint, param4:int) : void {
      var local5:String = Money.numToString(param4,false);
      createCell(param1,local5,param3,TextFormatAlign.RIGHT,TableConst.BONUS_REWARD_WIDTH,param2);
    }

    [Obfuscation(rename="false")]
    override public function set data(param1:Object) : void {
      _data = param1;
      this.nicon = this.myIcon(_data);
    }

    [Obfuscation(rename="false")]
    override public function set listData(param1:ListData) : void {
      _listData = param1;
      label = _listData.label;
      if(this.nicon != null) {
        setStyle("icon",this.nicon);
      }
    }

    [Obfuscation(rename="false")]
    override protected function drawBackground() : void {
    }

    [Obfuscation(rename="false")]
    override protected function drawLayout() : void {
    }

    [Obfuscation(rename="false")]
    override protected function drawIcon() : void {
      var local1:DisplayObject = icon;
      var local2:Object = getStyleValue("icon");
      if(local2 != null) {
        icon = getDisplayObjectInstance(local2);
      }
      if(icon != null) {
        addChildAt(icon,1);
      }
      if(local1 != null && local1 != icon && local1.parent == this) {
        removeChild(local1);
      }
    }

    private function myIcon(param1:Object) : Sprite {
      var local3:DisplayObject = null;
      var local5:uint = 0;
      var local6:StatisticsListUserLabel = null;
      var local8:Label = null;
      var local2:StatisticsData = StatisticsData(param1);
      switch(local2.type) {
        case ViewStatistics.BLUE:
          local3 = local2.self ? new ResultWindowBlueSelected() : new ResultWindowBlueNormal();
          break;
        case ViewStatistics.GREEN:
          local3 = local2.self ? new ResultWindowGreenSelected() : new ResultWindowGreenNormal();
          break;
        case ViewStatistics.RED:
          local3 = local2.self ? new ResultWindowRedSelected() : new ResultWindowRedNormal();
      }
      var local4:Sprite = new Sprite();
      local4.addChild(local3);
      if(!param1.loaded) {
        local5 = COLOR_NOT_LOADED;
      } else {
        local5 = Boolean(param1.suspicious) ? uint(ColorConstants.SUSPICIOUS) : COLOR_NORMAL;
      }
      local6 = new StatisticsListUserLabel(local2);
      if(!param1.loaded) {
        local6.setUidColor(COLOR_NOT_LOADED,true);
      } else if(Boolean(param1.suspicious)) {
        local6.setUidColor(ColorConstants.SUSPICIOUS,true);
      } else {
        local6.setUidColor(COLOR_NORMAL,battleInfoService.isSpectatorMode());
      }
      var local7:int = TableConst.LABELS_OFFSET;
      local6.x = local7 - 14;
      local4.addChild(local6);
      local7 += TableConst.CALLSIGN_WIDTH;
      if(local2.type != ViewStatistics.GREEN) {
        local8 = createCell(local4,local2.score.toString(),local5,TextFormatAlign.RIGHT,TableConst.SCORE_WIDTH,local7);
        local7 += local8.width;
      }
      local8 = createCell(local4,local2.kills.toString(),local5,TextFormatAlign.RIGHT,TableConst.KILLS_WIDTH,local7);
      local7 += local8.width;
      local8 = createCell(local4,local2.deaths.toString(),local5,TextFormatAlign.RIGHT,TableConst.DEATHS_WIDTH,local7);
      local7 += local8.width;
      var local9:Number = local2.kills / local2.deaths;
      var local10:String = local2.deaths == 0 || local2.kills == 0 ? DASH_TEXT : local9.toFixed(2);
      local8 = createCell(local4,local10,local5,TextFormatAlign.RIGHT,TableConst.RATIO_WIDTH,local7);
      local7 += local8.width;
      if(local2.reward > -1) {
        local8 = createCell(local4,Money.numToString(local2.reward,false),local5,TextFormatAlign.RIGHT,TableConst.REWARD_WIDTH,local7);
        local7 += local8.width;
        if(showBonus) {
          createStarsRewardCell(local4,local7,COLOR_GOLD,local2.stars);
        }
      }
      local3.width = width;
      local3.height = TableConst.ROW_HEIGHT - 2;
      return local4;
    }
  }
}
