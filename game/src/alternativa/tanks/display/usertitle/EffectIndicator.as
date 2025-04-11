package alternativa.tanks.display.usertitle {
  import alternativa.tanks.display.EffectBlinkerUtil;
  import alternativa.tanks.models.inventory.InventoryItemType;
  import alternativa.tanks.sfx.Blinker;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.geom.ColorTransform;
  import flash.geom.Matrix;
  import flash.geom.Rectangle;
  import flash.utils.Dictionary;
  import flash.utils.getTimer;

  public class EffectIndicator {
    private static var icons:Dictionary;
    private static var iconRect:Rectangle;

    private static const STATE_HIDDEN:int = 1;
    private static const STATE_PREPARED:int = 2;
    private static const STATE_VISIBLE:int = 4;
    private static const STATE_HIDING:int = 8;
    private static const UNKILLABLE_EFFECT_LEVEL:int = 2;
    private static const iconHealthCls:Class = EffectIndicator_iconHealthCls;
    private static const iconArmorCls:Class = EffectIndicator_iconArmorCls;
    private static const iconPowerCls:Class = EffectIndicator_iconPowerCls;
    private static const iconNitroCls:Class = EffectIndicator_iconNitroCls;
    private static const iconUnkillableCls:Class = EffectIndicator_iconUnkillableCls;
    private static const iconUnkillableBitmapData:BitmapData = Bitmap(new iconUnkillableCls()).bitmapData;
    private static const ultimateCls:Class = EffectIndicator_ultimateCls;

    private static var matrix:Matrix = new Matrix();

    private var _effectId:int;
    private var icon:BitmapData;
    private var blinkingPeriod:int;
    private var colorTransform:ColorTransform = new ColorTransform();
    private var blinkingStartTime:int;
    private var finishTime:int;
    private var blinker:Blinker;
    private var alpha:Number = 1;
    private var needRedraw:Boolean;
    private var x:int;
    private var y:int;
    private var userTitle:UserTitle;
    private var state:int;
    private var blinking:Boolean;

    public var activeAfterDeath:Boolean;
    public var effectLevel:int;

    public function EffectIndicator(param1:int, param2:UserTitle) {
      super();
      if(icons == null) {
        initIcons();
      }
      this._effectId = param1;
      this.icon = icons[param1];
      this.userTitle = param2;
      this.blinkingPeriod = EffectBlinkerUtil.getBlinkingPeriod(param1);
      this.blinker = EffectBlinkerUtil.createBlinker(param1);
      this.state = STATE_HIDDEN;
    }

    private static function initIcons() : void {
      icons = new Dictionary();
      icons[InventoryItemType.FIRST_AID] = Bitmap(new iconHealthCls()).bitmapData;
      icons[InventoryItemType.ARMOR] = Bitmap(new iconArmorCls()).bitmapData;
      icons[InventoryItemType.DAMAGE] = Bitmap(new iconPowerCls()).bitmapData;
      icons[InventoryItemType.NITRO] = Bitmap(new iconNitroCls()).bitmapData;
      icons[InventoryItemType.ULTIMATE] = Bitmap(new ultimateCls()).bitmapData;
      iconRect = BitmapData(icons[InventoryItemType.FIRST_AID]).rect;
    }

    public function get effectId() : int {
      return this._effectId;
    }

    public function isVisible() : Boolean {
      return (this.state & STATE_VISIBLE) != 0;
    }

    public function isHidden() : Boolean {
      return this.state == STATE_HIDDEN;
    }

    public function showInfinite() : void {
      this.show(-1,false,0);
    }

    public function show(param1:int, param2:Boolean, param3:int) : void {
      this.activeAfterDeath = param2;
      this.state &= ~STATE_HIDING;
      if(this.state != STATE_VISIBLE || this.alpha != 1 || this.effectLevel != param3) {
        this.needRedraw = true;
      }
      this.effectLevel = param3;
      if(param1 > -1) {
        this.finishTime = getTimer() + param1;
        this.blinkingStartTime = this.finishTime - this.blinkingPeriod;
      } else {
        this.finishTime = int.MAX_VALUE;
        this.blinkingStartTime = int.MAX_VALUE;
      }
      this.blinking = false;
      this.alpha = 1;
      if(this.state == STATE_HIDDEN) {
        this.state = STATE_PREPARED;
      }
    }

    public function hide() : void {
      if(this.activeAfterDeath) {
        return;
      }
      if(this.state == STATE_PREPARED || this._effectId == InventoryItemType.ULTIMATE && this.state != STATE_HIDDEN) {
        this.userTitle.doHideIndicator(this);
        this.state = STATE_HIDDEN;
        return;
      }
      if((this.state & (STATE_HIDDEN | STATE_HIDING)) != 0) {
        return;
      }
      this.state |= STATE_HIDING;
      this.blinker.setMinValue(0);
      if(!this.blinking) {
        this.blinkingStartTime = 0;
        this.blinker.init(getTimer());
        this.blinking = true;
      }
    }

    public function clear(param1:BitmapData) : void {
      if(this.state == STATE_HIDDEN || this.state == STATE_PREPARED) {
        return;
      }
      iconRect.x = this.x;
      iconRect.y = this.y;
      param1.fillRect(iconRect,0);
    }

    public function setPosition(param1:int, param2:int) : void {
      this.x = param1;
      this.y = param2;
      this.needRedraw = true;
    }

    public function forceRedraw() : void {
      this.needRedraw = true;
    }

    public function update(param1:int, param2:int, param3:BitmapData) : void {
      if(this.state == STATE_HIDDEN) {
        return;
      }
      if(this.needRedraw) {
        this.draw(param3);
        this.needRedraw = false;
      }
      if(this._effectId != InventoryItemType.ULTIMATE && param1 > this.blinkingStartTime) {
        this.updateBlinking(param1,param2,param3);
      }
      if(this.effectId == InventoryItemType.FIRST_AID && param1 > this.finishTime) {
        this.hide();
      }
      if(this.state == STATE_PREPARED) {
        this.state = STATE_VISIBLE;
      }
    }

    private function updateBlinking(param1:int, param2:int, param3:BitmapData) : void {
      var local4:Number = NaN;
      if(this.blinking) {
        local4 = this.blinker.updateValue(param1,param2);
        if(local4 != this.alpha) {
          this.alpha = local4;
          this.draw(param3);
        }
        if((this.state & STATE_HIDING) != 0 && this.alpha == 0) {
          this.userTitle.doHideIndicator(this);
          this.state = STATE_HIDDEN;
        }
      } else {
        this.blinker.setMinValue(EffectBlinkerUtil.MIN_VALUE);
        this.blinker.init(param1);
        this.blinking = true;
      }
    }

    private function draw(param1:BitmapData) : void {
      this.clear(param1);
      matrix.tx = this.x;
      matrix.ty = this.y;
      this.colorTransform.alphaMultiplier = this.alpha;
      param1.draw(this.getIndicatorIcon(),matrix,this.colorTransform,null,null,true);
    }

    private function getIndicatorIcon() : BitmapData {
      return this._effectId == InventoryItemType.ARMOR && this.effectLevel == UNKILLABLE_EFFECT_LEVEL ? iconUnkillableBitmapData : this.icon;
    }
  }
}
