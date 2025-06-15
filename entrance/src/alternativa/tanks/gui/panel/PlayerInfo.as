package alternativa.tanks.gui.panel {
  import alternativa.tanks.gui.panel.helpers.PlayerInfoHelper;
  import controls.Label;
  import controls.Money;
  import controls.panel.Indicators;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.filters.GlowFilter;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.rank.RankService;

  public class PlayerInfo extends Sprite {
    [Inject]
    public static var rankService:RankService;

    private const normalGlowColor:uint = 1244928;
    private const minusGlowColor:uint = 16728064;

    private var _playerName:String;
    private var _rank:int;
    private var _score:int = 0;
    private var _scoreRemain:int = 0;
    private var _progress:int = 0;
    private var _newProgress:int;
    private var _crystals:int = 0;

    public var indicators:Indicators = new Indicators();

    private var gearScoreInfo:GearScoreInfo = new GearScoreInfo();
    private var glowAlpha:Object = new Object();
    private var glowColor:Object = new Object();
    private var glowDelta:Number = 0.02;
    private var _width:int;

    public function PlayerInfo() {
      super();
      addChild(this.indicators);
      this.indicators.kd_icon.visible = this.indicators.kdRatio.visible = false;
      this.gearScoreInfo.y = this.indicators.y + 4;
      addChild(this.gearScoreInfo);
      addEventListener(Event.ADDED_TO_STAGE,this.configUI);
    }

    public function set playerName(param1:String) : void {
      this._playerName = param1;
      this.updateInfo();
    }

    public function get playerName() : String {
      return this._playerName;
    }

    public function get rank() : int {
      return this._rank;
    }

    public function set rank(param1:int) : void {
      this._rank = param1;
      this.updateInfo();
    }

    public function updateScore(param1:int, param2:int) : void {
      if(param1 != this._score && this._score != 0) {
        this.flashLabel(this.indicators.playerInfo,param1 > this._score ? this.normalGlowColor : this.minusGlowColor);
      }
      this._score = param1;
      this._scoreRemain = param2;
      this.updateInfo();
    }

    public function get progress() : int {
      return this._progress;
    }

    public function set progress(param1:int) : void {
      if(this._progress == 0) {
        this._progress = param1;
      } else {
        this._newProgress = param1;
        this._progress = param1;
        this.indicators.newprogress = param1;
      }
      this.updateInfo();
    }

    public function set crystals(param1:int) : void {
      if(param1 != this._crystals && this._crystals != 0) {
        this.flashLabel(this.indicators.crystalInfo,param1 > this._crystals ? this.normalGlowColor : this.minusGlowColor);
      }
      this._crystals = param1;
      this.updateInfo();
    }

    private function configUI(param1:Event) : void {
      removeEventListener(Event.ADDED_TO_STAGE,this.configUI);
      this.indicators.x = 59;
      PlayerInfoHelper.setDefaultSharpnessAndThickness(this.indicators.crystalInfo);
      PlayerInfoHelper.setDefaultSharpnessAndThickness(this.indicators.kdRatio);
      PlayerInfoHelper.setDefaultSharpnessAndThickness(this.indicators.playerInfo);
      PlayerInfoHelper.setDefaultSharpnessAndThickness(this.indicators.scoreLabel);
    }

    private function updateInfo() : void {
      // Narukami ext-color-names - use HTML text for label
      this.indicators.playerInfo.htmlText = String(this._score) + " / " + String(this._scoreRemain) + "   " + rankService.getRankName(this._rank) + " " + this._playerName;
      this.indicators.progress = this._progress;
      this.indicators.crystalInfo.text = Money.numToString(this._crystals,false);
      this.width = this._width;
    }

    private function flashLabel(param1:Label, param2:uint = 16711680) : void {
      this.glowAlpha[param1.name] = 1;
      this.glowColor[param1.name] = param2;
      param1.addEventListener(Event.ENTER_FRAME,this.glowFrame);
    }

    private function glowFrame(param1:Event) : void {
      var local2:Label = param1.target as Label;
      var local3:GlowFilter = new GlowFilter(this.glowColor[local2.name],this.glowAlpha[local2.name],4,4,3,1,false);
      local2.filters = [local3];
      this.glowAlpha[local2.name] -= this.glowDelta;
      if(this.glowAlpha[local2.name] < 0) {
        local2.filters = [];
        local2.removeEventListener(Event.ENTER_FRAME,this.glowFrame);
      }
    }

    override public function set width(param1:Number) : void {
      this._width = int(param1);
      this.indicators.width = param1;
      var local2:int = 3;
      this.indicators.C2.x -= local2;
      this.indicators.CR.x -= local2;
      this.indicators.R.x -= local2;
      this.indicators.crystalInfo.x -= local2;
      this.gearScoreInfo.x = this.indicators.x + this.indicators.C2.x - this.gearScoreInfo.width - 18;
      this.gearScoreInfo.visible = this.gearScoreInfo.x > this.indicators.x + this.indicators.playerInfo.textWidth + 10;
    }

    private function updateWidth() : void {
      this.width = this._width;
    }

    public function set gearScore(param1:int) : void {
      this.gearScoreInfo.updateScore(param1);
      this.updateWidth();
    }
  }
}
