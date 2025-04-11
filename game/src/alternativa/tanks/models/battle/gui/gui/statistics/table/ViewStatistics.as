package alternativa.tanks.models.battle.gui.gui.statistics.table {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.models.battle.gui.statistics.ClientUserStat;
  import alternativa.types.Long;
  import controls.Label;
  import controls.resultassets.ResultWindowBase;
  import controls.resultassets.ResultWindowBlue;
  import controls.resultassets.ResultWindowBlueHeader;
  import controls.resultassets.ResultWindowGreen;
  import controls.resultassets.ResultWindowGreenHeader;
  import controls.resultassets.ResultWindowRed;
  import controls.resultassets.ResultWindowRedHeader;
  import controls.scroller.blue.ScrollSkinBlue;
  import controls.scroller.blue.ScrollThumbSkinBlue;
  import controls.scroller.green.ScrollSkinGreen;
  import controls.scroller.green.ScrollThumbSkinGreen;
  import controls.scroller.red.ScrollSkinRed;
  import controls.scroller.red.ScrollThumbSkinRed;
  import fl.controls.List;
  import fl.data.DataProvider;
  import flash.display.DisplayObject;
  import flash.display.Sprite;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFormatAlign;
  import flash.utils.Dictionary;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class ViewStatistics extends Sprite {
    [Inject]
    public static var localeService:ILocaleService;

    private static var scrollBarStyles:Object;

    public static const BLUE:int = 0;
    public static const RED:int = 1;
    public static const GREEN:int = 2;

    private static const MIN_HEIGHT:int = 52;
    private static const TABLE_MARGIN:int = 7;
    private static const EXTRA_HEIGHT:int = 12;
    private static const EXTRA_WIDTH:int = 20;

    private var list:List;
    private var dp:DataProvider = new DataProvider();
    private var inner:ResultWindowBase;
    private var type:int;
    private var localUserId:Long;
    private var finish:Boolean;
    private var localUserTeam:BattleTeam;
    private var header:Sprite;
    private var captionCallsign:String;
    private var captionScore:String;
    private var captionKills:String;
    private var captionDeaths:String;
    private var captionKDRatio:String;
    private var captionReward:String;
    private var captionStarsReward:String;
    private var showStars:Boolean;

    public function ViewStatistics(param1:int, param2:Long, param3:Boolean, param4:BattleTeam, param5:Boolean) {
      super();
      if(scrollBarStyles == null) {
        initScrollBarStyles();
      }
      this.type = param1;
      this.localUserId = param2;
      this.finish = param3;
      this.localUserTeam = param4;
      this.tabEnabled = false;
      this.tabChildren = false;
      this.showStars = param5;
      this.captionCallsign = localeService.getText(TanksLocale.TEXT_BATTLE_STAT_CALLSIGN);
      this.captionScore = localeService.getText(TanksLocale.TEXT_BATTLE_STAT_SCORE);
      this.captionKills = localeService.getText(TanksLocale.TEXT_BATTLE_STAT_KILLS);
      this.captionDeaths = localeService.getText(TanksLocale.TEXT_BATTLE_STAT_DEATHS);
      this.captionKDRatio = localeService.getText(TanksLocale.TEXT_BATTLE_STAT_KDRATIO);
      this.captionReward = localeService.getText(TanksLocale.TEXT_BATTLE_STAT_REWARD);
      this.captionStarsReward = localeService.getText(TanksLocale.TEXT_BATTLE_STAT_STARS_REWARD);
      this.init();
    }

    private static function initScrollBarStyles() : void {
      scrollBarStyles = {};
      addScrollBarStyle("downArrowUpSkin",ScrollSkinGreen.trackBottom,ScrollSkinRed.trackBottom,ScrollSkinBlue.trackBottom);
      addScrollBarStyle("downArrowDownSkin",ScrollSkinGreen.trackBottom,ScrollSkinRed.trackBottom,ScrollSkinBlue.trackBottom);
      addScrollBarStyle("downArrowOverSkin",ScrollSkinGreen.trackBottom,ScrollSkinRed.trackBottom,ScrollSkinBlue.trackBottom);
      addScrollBarStyle("downArrowDisabledSkin",ScrollSkinGreen.trackBottom,ScrollSkinRed.trackBottom,ScrollSkinBlue.trackBottom);
      addScrollBarStyle("upArrowUpSkin",ScrollSkinGreen.trackTop,ScrollSkinRed.trackTop,ScrollSkinBlue.trackTop);
      addScrollBarStyle("upArrowDownSkin",ScrollSkinGreen.trackTop,ScrollSkinRed.trackTop,ScrollSkinBlue.trackTop);
      addScrollBarStyle("upArrowOverSkin",ScrollSkinGreen.trackTop,ScrollSkinRed.trackTop,ScrollSkinBlue.trackTop);
      addScrollBarStyle("upArrowDisabledSkin",ScrollSkinGreen.trackTop,ScrollSkinRed.trackTop,ScrollSkinBlue.trackTop);
      addScrollBarStyle("trackUpSkin",ScrollSkinGreen.track,ScrollSkinRed.track,ScrollSkinBlue.track);
      addScrollBarStyle("trackDownSkin",ScrollSkinGreen.track,ScrollSkinRed.track,ScrollSkinBlue.track);
      addScrollBarStyle("trackOverSkin",ScrollSkinGreen.track,ScrollSkinRed.track,ScrollSkinBlue.track);
      addScrollBarStyle("trackDisabledSkin",ScrollSkinGreen.track,ScrollSkinRed.track,ScrollSkinBlue.track);
      addScrollBarStyle("thumbUpSkin",ScrollThumbSkinGreen,ScrollThumbSkinRed,ScrollThumbSkinBlue);
      addScrollBarStyle("thumbDownSkin",ScrollThumbSkinGreen,ScrollThumbSkinRed,ScrollThumbSkinBlue);
      addScrollBarStyle("thumbOverSkin",ScrollThumbSkinGreen,ScrollThumbSkinRed,ScrollThumbSkinBlue);
      addScrollBarStyle("thumbDisabledSkin",ScrollThumbSkinGreen,ScrollThumbSkinRed,ScrollThumbSkinBlue);
    }

    private static function addScrollBarStyle(param1:String, param2:Class, param3:Class, param4:Class) : void {
      var local5:Dictionary = new Dictionary();
      local5[ViewStatistics.GREEN] = param2;
      local5[ViewStatistics.RED] = param3;
      local5[ViewStatistics.BLUE] = param4;
      scrollBarStyles[param1] = local5;
    }

    private static function createHeaderLabel(param1:Sprite, param2:String, param3:uint, param4:String, param5:int, param6:int) : Label {
      var local7:Label = new Label();
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

    public function updatePlayerInfo(param1:ClientUserStat) : void {
      var local2:int = param1.userId == null ? -1 : this.indexById(param1.userId);
      if(local2 != -1) {
        this.dp.replaceItemAt(this.createDataItem(param1),local2);
      }
    }

    public function updatePlayersInfo(param1:Vector.<ClientUserStat>) : void {
      this.dp.removeAll();
      var local2:int = int(param1.length);
      var local3:int = 0;
      while(local3 < local2) {
        this.dp.addItem(this.createDataItem(param1[local3]));
        local3++;
      }
    }

    private function createDataItem(param1:ClientUserStat) : Object {
      var local2:StatisticsData = new StatisticsData();
      local2.id = param1.userId;
      local2.rank = param1.rank;
      local2.uid = param1.uid;
      local2.kills = param1.kills;
      local2.deaths = param1.deaths;
      local2.score = param1.score;
      local2.reward = param1.reward;
      local2.type = this.type;
      local2.self = param1.userId == this.localUserId;
      local2.loaded = param1.loaded;
      local2.suspicious = param1.suspicious;
      local2.stars = param1.stars;
      return local2;
    }

    public function removePlayer(param1:Long) : void {
      var local2:int = this.indexById(param1);
      this.dp.removeItemAt(local2);
    }

    public function resize(param1:Number) : void {
      var local2:Number = (this.dp.length + 1) * TableConst.ROW_HEIGHT + EXTRA_HEIGHT;
      if(local2 > param1) {
        local2 = int(param1 / this.header.height) * this.header.height + EXTRA_HEIGHT;
      }
      this.inner.height = local2 < MIN_HEIGHT ? MIN_HEIGHT : local2;
      this.list.setSize(this.inner.width - 2 * TableConst.TABLE_MARGIN,this.inner.height - this.header.y - this.header.height - 5);
    }

    [Obfuscation(rename="false")]
    override public function get height() : Number {
      return this.inner.height;
    }

    private function indexById(param1:Long) : int {
      var local2:StatisticsData = null;
      var local3:int = int(this.dp.length);
      var local4:int = 0;
      while(local4 < local3) {
        local2 = this.dp.getItemAt(local4) as StatisticsData;
        if(local2 != null && local2.id == param1) {
          return local4;
        }
        local4++;
      }
      return -1;
    }

    private function setScrollbarStyle() : void {
      this.setListStyle("downArrowUpSkin");
      this.setListStyle("downArrowDownSkin");
      this.setListStyle("downArrowOverSkin");
      this.setListStyle("downArrowDisabledSkin");
      this.setListStyle("upArrowUpSkin");
      this.setListStyle("upArrowDownSkin");
      this.setListStyle("upArrowOverSkin");
      this.setListStyle("upArrowDisabledSkin");
      this.setListStyle("trackUpSkin");
      this.setListStyle("trackDownSkin");
      this.setListStyle("trackOverSkin");
      this.setListStyle("trackDisabledSkin");
      this.setListStyle("thumbUpSkin");
      this.setListStyle("thumbDownSkin");
      this.setListStyle("thumbOverSkin");
      this.setListStyle("thumbDisabledSkin");
    }

    private function setListStyle(param1:String) : void {
      this.list.setStyle(param1,scrollBarStyles[param1][this.type]);
    }

    private function init() : void {
      switch(this.type) {
        case RED:
          this.inner = new ResultWindowRed();
          break;
        case GREEN:
          this.inner = new ResultWindowGreen();
          break;
        case BLUE:
          this.inner = new ResultWindowBlue();
      }
      this.inner.width = TableConst.LAST_COLUMN_EXTRA_WIDTH + 2 * TableConst.TABLE_MARGIN + TableConst.LABELS_OFFSET + TableConst.CALLSIGN_WIDTH + TableConst.KILLS_WIDTH + TableConst.DEATHS_WIDTH + TableConst.RATIO_WIDTH + (this.type != GREEN ? TableConst.SCORE_WIDTH : 0) + (this.finish ? TableConst.REWARD_WIDTH : 0) + (this.showStars ? TableConst.BONUS_REWARD_WIDTH : 0) + EXTRA_WIDTH;
      this.inner.height = MIN_HEIGHT;
      addChild(this.inner);
      this.header = this.getHeader();
      this.inner.addChild(this.header);
      this.header.x = TABLE_MARGIN;
      this.header.y = TABLE_MARGIN;
      this.dp = new DataProvider();
      this.list = new List();
      this.setScrollbarStyle();
      this.inner.addChild(this.list);
      this.list.rowHeight = TableConst.ROW_HEIGHT;
      this.list.x = TABLE_MARGIN;
      StatisticsListRenderer.showBonus = this.showStars;
      this.list.setStyle("cellRenderer",StatisticsListRenderer);
      this.list.y = this.header.y + this.header.height;
      this.list.focusEnabled = false;
      this.list.dataProvider = this.dp;
    }

    private function getHeader() : Sprite {
      var local1:DisplayObject = null;
      var local2:uint = 0;
      var local5:Label = null;
      switch(this.type) {
        case BLUE:
          local1 = new ResultWindowBlueHeader();
          local2 = 11590;
          break;
        case GREEN:
          local1 = new ResultWindowGreenHeader();
          local2 = 83457;
          break;
        case RED:
          local1 = new ResultWindowRedHeader();
          local2 = 4655104;
      }
      var local3:Sprite = new Sprite();
      local3.addChild(local1);
      var local4:int = TableConst.LABELS_OFFSET;
      local5 = createHeaderLabel(local3,this.captionCallsign,local2,TextFormatAlign.LEFT,TableConst.CALLSIGN_WIDTH,local4);
      local4 += local5.width;
      if(this.type != GREEN) {
        local5 = createHeaderLabel(local3,this.captionScore,local2,TextFormatAlign.RIGHT,TableConst.SCORE_WIDTH,local4);
        local4 += local5.width;
      }
      local5 = createHeaderLabel(local3,this.captionKills,local2,TextFormatAlign.RIGHT,TableConst.KILLS_WIDTH,local4);
      local4 += local5.width;
      local5 = createHeaderLabel(local3,this.captionDeaths,local2,TextFormatAlign.RIGHT,TableConst.DEATHS_WIDTH,local4);
      local4 += local5.width;
      local5 = createHeaderLabel(local3,this.captionKDRatio,local2,TextFormatAlign.RIGHT,TableConst.RATIO_WIDTH,local4);
      local4 += local5.width;
      if(this.finish) {
        local5 = createHeaderLabel(local3,this.captionReward,local2,TextFormatAlign.RIGHT,TableConst.REWARD_WIDTH,local4);
        local4 += local5.width;
        if(this.showStars) {
          createHeaderLabel(local3,this.captionStarsReward,local2,TextFormatAlign.RIGHT,TableConst.BONUS_REWARD_WIDTH,local4);
        }
      }
      local1.width = width - 2 * TABLE_MARGIN;
      local1.height = TableConst.ROW_HEIGHT - 2;
      return local3;
    }
  }
}
