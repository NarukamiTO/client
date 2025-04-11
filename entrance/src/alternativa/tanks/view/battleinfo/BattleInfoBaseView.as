package alternativa.tanks.view.battleinfo {
  import assets.icons.BattleInfoIcons;
  import assets.icons.InputCheckIcon;
  import controls.TankWindowInner;
  import controls.base.LabelBase;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.MovieClip;
  import flash.display.Sprite;
  import flash.filters.GlowFilter;
  import flash.geom.Rectangle;
  import flash.text.TextFieldAutoSize;
  import forms.ranks.SmallRankIcon;
  import forms.registration.CallsignIconStates;

  public class BattleInfoBaseView extends Sprite {
    private static const MAX_HEIGHT:int = 500;
    private static const ICON_VERTICAL_MARGIN:int = 6;
    private static const RANG_ICON_HEIGHT:int = 16;
    private static const RANG_ICON_WIDTH:int = 15;
    private static const filter:Array = [new GlowFilter(0,1,6,6)];
    private static const waitIcon:InputCheckIcon = new InputCheckIcon();

    protected var iconBar:Sprite = new Sprite();

    private var proOptionsBar:Sprite = new Sprite();
    private var scoreLimitIcon:BattleInfoIcons = new BattleInfoIcons();
    private var timeLimitIcon:BattleInfoIcons = new BattleInfoIcons();
    private var suppliesIcon:BattleInfoIcons = new BattleInfoIcons();
    private var bonusesIcon:BattleInfoIcons = new BattleInfoIcons();
    private var upgradesIcon:BattleInfoIcons = new BattleInfoIcons();
    private var reArmorIcon:BattleInfoIcons = new BattleInfoIcons();
    private var dependentCooldown:BattleInfoIcons = new BattleInfoIcons();
    private var scoreLimitLabel:LabelBase = new LabelBase();
    private var timeLimitLabel:LabelBase = new LabelBase();
    private var rangBar:Sprite = new Sprite();
    private var bg:TankWindowInner = new TankWindowInner(100,100,TankWindowInner.TRANSPARENT);
    private var nameLabel:LabelBase = new LabelBase();
    private var preview:Sprite = new Sprite();
    private var rect:Rectangle = new Rectangle(0,0,400,300);
    private var _width:int;
    private var _height:int;

    public function BattleInfoBaseView() {
      super();
      addChild(this.preview);
      addChild(this.bg);
      addChild(this.nameLabel);
      addChild(this.rangBar);
      addChild(this.iconBar);
      addChild(this.proOptionsBar);
      this.scoreLimitIcon.type = BattleInfoIcons.KILL_LIMIT;
      this.timeLimitIcon.type = BattleInfoIcons.TIME_LIMIT;
      this.suppliesIcon.type = BattleInfoIcons.PAYD;
      this.bonusesIcon.type = BattleInfoIcons.INVENTORY_BONUS;
      this.dependentCooldown.type = BattleInfoIcons.DEPENDENT_COOLDOWN;
      this.upgradesIcon.type = BattleInfoIcons.UPGRADES;
      this.reArmorIcon.type = BattleInfoIcons.REARMOR;
      this.nameLabel.size = 18;
      this.nameLabel.height = 25;
      this.nameLabel.thickness = 0;
      this.nameLabel.autoSize = TextFieldAutoSize.NONE;
      this.nameLabel.filters = filter;
      this.iconBar.filters = filter;
      this.proOptionsBar.filters = filter;
      this.preview.scrollRect = this.rect;
    }

    public function setPreview(param1:BitmapData) : void {
      if(this.preview.numChildren > 0) {
        this.preview.removeChildAt(0);
      }
      if(param1 == null) {
        this.preview.addChild(waitIcon);
        waitIcon.gotoAndStop(CallsignIconStates.CALLSIGN_ICON_STATE_PROGRESS);
        waitIcon.x = int(375 - waitIcon.width / 2);
        waitIcon.y = int(250 - waitIcon.height / 2);
        this.preview.scrollRect = this.rect;
      } else {
        this.preview.addChild(new Bitmap(param1));
        this.preview.scrollRect = this.rect;
      }
      this.width = this._width;
      this.height = this._height;
    }

    public function setCommonParams(param1:String, param2:int, param3:int, param4:int, param5:int) : void {
      this.fillRangBar(param2,param3);
      this.nameLabel.text = param1;
      this.clearIconBar();
      if(param5 > 0) {
        this.fillLimeLimit(param5);
      }
      if(param4 > 0) {
        this.fillScoreLimit(param4);
      }
    }

    public function setProBattleParams(param1:Boolean, param2:Boolean, param3:Boolean, param4:Boolean, param5:Boolean) : void {
      this.clearOptionsBar();
      this.addIcon(this.bonusesIcon,param3);
      this.addIcon(this.reArmorIcon,param5);
      this.addIcon(this.upgradesIcon,param4);
      this.addIcon(this.suppliesIcon,param1);
      if(param1) {
        this.addIcon(this.dependentCooldown,param2);
      }
    }

    private function addIcon(param1:MovieClip, param2:Boolean) : void {
      if(this.proOptionsBar.numChildren > 0) {
        param1.x = this.proOptionsBar.width + ICON_VERTICAL_MARGIN;
      } else {
        param1.x = 0;
      }
      param1.alpha = param2 ? 1 : 0.5;
      this.proOptionsBar.addChild(param1);
    }

    private function clearOptionsBar() : void {
      while(this.proOptionsBar.numChildren > 0) {
        this.proOptionsBar.removeChildAt(0);
      }
    }

    private function fillScoreLimit(param1:int) : void {
      this.scoreLimitLabel.size = 14;
      this.scoreLimitLabel.text = String(param1);
      this.scoreLimitLabel.x = this.iconBar.numChildren > 0 ? this.iconBar.width + ICON_VERTICAL_MARGIN : 0;
      this.iconBar.addChild(this.scoreLimitLabel);
      this.scoreLimitIcon.x = this.iconBar.width + ICON_VERTICAL_MARGIN;
      this.scoreLimitIcon.type = BattleInfoIcons.KILL_LIMIT;
      this.iconBar.addChild(this.scoreLimitIcon);
    }

    private function fillLimeLimit(param1:int) : void {
      this.timeLimitLabel.text = param1.toString();
      this.timeLimitLabel.size = 14;
      this.iconBar.addChild(this.timeLimitLabel);
      this.timeLimitIcon.x = this.iconBar.width + ICON_VERTICAL_MARGIN;
      this.iconBar.addChild(this.timeLimitIcon);
    }

    private function fillRangBar(param1:int, param2:int) : void {
      var local6:SmallRankIcon = null;
      while(this.rangBar.numChildren > 0) {
        this.rangBar.removeChildAt(0);
      }
      if(param1 == 0 || param2 == 0) {
        return;
      }
      var local3:int = 0;
      var local4:int = 0;
      var local5:int = param2;
      while(local5 >= param1) {
        local6 = new SmallRankIcon(local5);
        local6.x = local3 * RANG_ICON_WIDTH;
        local6.y = local4 * RANG_ICON_HEIGHT;
        this.rangBar.addChild(local6);
        local3--;
        if(local3 < -15) {
          local4--;
          local3 = 0;
        }
        local5--;
      }
    }

    private function clearIconBar() : void {
      while(this.iconBar.numChildren > 0) {
        this.iconBar.removeChildAt(0);
      }
    }

    override public function set width(param1:Number) : void {
      this._width = int(param1);
      this.bg.width = this._width;
      this.preview.x = 1;
      this.rect.x = int(375 - this._width / 2);
      this.rect.width = this._width - 2;
      this.preview.scrollRect = this.rect;
      this.rangBar.x = this._width - 23;
      this.nameLabel.x = 10;
      this.nameLabel.width = this._width - 20;
      this.iconBar.x = 12;
      this.proOptionsBar.x = 12;
    }

    override public function set height(param1:Number) : void {
      this._height = Math.min(param1,MAX_HEIGHT);
      this.bg.height = this._height;
      this.preview.y = 1;
      this.rect.y = int(250 - this._height / 2);
      this.rect.height = this.bg.height - 2;
      this.preview.scrollRect = this.rect;
      this.rangBar.y = this.bg.height - 23;
      this.nameLabel.y = 10;
      this.iconBar.y = 40;
      this.proOptionsBar.y = 70;
    }

    override public function get width() : Number {
      return this._width;
    }

    override public function get height() : Number {
      return this._height;
    }
  }
}
