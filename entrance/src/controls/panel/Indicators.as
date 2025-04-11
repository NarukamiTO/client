package controls.panel {
  import controls.Label;
  import flash.display.DisplayObject;
  import flash.display.Graphics;
  import flash.display.MovieClip;
  import flash.display.Sprite;
  import flash.events.TimerEvent;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFormatAlign;
  import flash.utils.Timer;

  [Embed(source="/_assets/assets.swf", symbol="symbol663")]
  public class Indicators extends MovieClip {
    public var CR:MovieClip;
    public var C1:MovieClip;
    public var C2:MovieClip;
    public var kdicon:MovieClip;
    public var L:MovieClip;
    public var N:MovieClip;
    public var R:MovieClip;
    public var playerInfo:Label = new Label();
    public var scoreLabel:Label = new Label();
    public var kdRatio:Label = new Label();
    public var crystalInfo:Label = new Label();
    public var kd_icon:MovieClip;

    private var _width:int;
    private var progressBar:Sprite = new Sprite();
    private var b_left:MovieClip;
    private var b_name:MovieClip;
    private var b_conn1:MovieClip;
    private var b_ind:MovieClip;
    private var b_conn2:MovieClip;
    private var b_money:MovieClip;
    private var b_conn3:MovieClip;
    private var b_crystal:MovieClip;
    private var b_right:MovieClip;
    private var _buyXPButton:DisplayObject;
    private var timer:Timer = new Timer(50);
    private var redZone:Sprite = null;
    private var _progress:int;
    private var _nprogress:int;
    private var _oprogress:int;

    public function Indicators() {
      super();
      this.b_left = getChildByName("L") as MovieClip;
      this.b_name = getChildByName("N") as MovieClip;
      this.b_conn1 = getChildByName("C1") as MovieClip;
      this.b_conn2 = getChildByName("C2") as MovieClip;
      this.b_crystal = getChildByName("CR") as MovieClip;
      this.b_right = getChildByName("R") as MovieClip;
      this.kd_icon = getChildByName("kdicon") as MovieClip;
      addChild(this.progressBar);
      addChild(this.playerInfo);
      addChild(this.scoreLabel);
      addChild(this.kdRatio);
      addChild(this.crystalInfo);
      this.progressBar.x = 5;
      this.progressBar.y = 5;
      this.playerInfo.x = 6;
      this.playerInfo.autoSize = TextFieldAutoSize.NONE;
      this.scoreLabel.autoSize = TextFieldAutoSize.NONE;
      this.scoreLabel.align = TextFormatAlign.RIGHT;
      this.scoreLabel.width = 200;
      this.scoreLabel.size = this.kdRatio.size = this.playerInfo.size = this.crystalInfo.size = 12;
      this.scoreLabel.color = this.kdRatio.color = this.playerInfo.color = this.crystalInfo.color = 1244928;
      this.scoreLabel.y = this.kdRatio.y = this.playerInfo.y = this.crystalInfo.y = 4;
      this.scoreLabel.height = this.crystalInfo.height = this.playerInfo.height = 18;
      this.crystalInfo.align = TextFormatAlign.RIGHT;
      this.crystalInfo.autoSize = TextFieldAutoSize.NONE;
      this.crystalInfo.width = 59;
      this.redZone = new Sprite();
      this.timer = new Timer(50);
      this.timer.addEventListener(TimerEvent.TIMER,this.hideRedZone);
      this.progressBar.addChild(this.redZone);
      this.redZone.alpha = 0;
    }

    public function get progress() : int {
      return this._progress;
    }

    public function set progress(param1:int) : void {
      var local2:Graphics = this.progressBar.graphics;
      var local3:int = this.b_name.width + 4;
      this._progress = param1;
      local2.clear();
      local2.beginFill(1244928,0.2);
      local2.drawRect(0,0,local3 / 10000 * this._progress,16);
      local2.endFill();
    }

    public function set newprogress(param1:int) : void {
      this._nprogress = param1;
      this._oprogress = this._progress;
      var local2:Graphics = this.redZone.graphics;
      var local3:int = this.b_name.width + 4;
      this.redZone.alpha = 1;
      local2.clear();
      if(this._nprogress >= this._oprogress) {
        local2.beginFill(16763904,1);
        local2.drawRect(local3 / 10000 * this._oprogress,0,local3 / 10000 * (param1 - this._oprogress),16);
        local2.endFill();
      } else {
        local2.beginFill(16763904,1);
        local2.drawRect(0,0,local3,16);
        local2.endFill();
      }
      this.timer.stop();
      this.timer.start();
    }

    private function hideRedZone(param1:TimerEvent) : void {
      var local2:DisplayObject = this.redZone;
      local2.alpha -= 0.03;
      if(local2.alpha <= 0) {
        this.timer.stop();
      }
    }

    override public function set width(param1:Number) : void {
      var local2:int = 0;
      this._width = param1;
      if(Boolean(this._buyXPButton) && this._buyXPButton.visible) {
        local2 = int(this._width - 184 - this._buyXPButton.width);
      } else {
        local2 = int(this._width - 180);
      }
      this.b_name.width = local2;
      this.b_conn1.x = this.b_name.width + this.b_left.width;
      if(Boolean(this._buyXPButton) && this._buyXPButton.visible) {
        this._buyXPButton.x = this.b_conn1.x + this.b_conn1.width + 1;
        this.b_conn2.x = this._buyXPButton.x + this._buyXPButton.width + 11;
      } else {
        this.b_conn2.x = this.b_conn1.x + this.b_conn1.width + 11;
      }
      this.b_crystal.width = 67;
      this.b_crystal.x = this.b_conn2.x + this.b_conn2.width;
      this.b_right.x = this.b_crystal.x + this.b_crystal.width;
      this.crystalInfo.x = this.b_crystal.x - 2;
      this.kdRatio.x = int(this.b_conn1.x - this.kdRatio.textWidth - 3);
      this.kd_icon.x = int(this.b_conn1.x - this.kdRatio.textWidth - 10);
      this.scoreLabel.x = this.kd_icon.x - 205;
      this.playerInfo.width = this.b_name.width - this.kdRatio.width - this.kd_icon.width - 5;
      this.progress = this._progress;
    }

    public function get buyXPButton() : DisplayObject {
      return this._buyXPButton;
    }

    public function set buyXPButton(param1:DisplayObject) : void {
      this._buyXPButton = param1;
      addChild(this._buyXPButton);
      this.width = this._width;
    }
  }
}
