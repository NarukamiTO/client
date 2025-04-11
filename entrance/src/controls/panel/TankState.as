package controls.panel {
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.Graphics;
  import flash.display.MovieClip;
  import flash.display.Shape;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.filters.GlowFilter;

  [Embed(source="/_assets/assets.swf", symbol="symbol255")]
  public class TankState extends Sprite {
    public static const ARMOR:int = 3;
    public static const ENGINE:int = 1;
    public static const WEAPON:int = 2;

    public static var _engineWarning:int = 10;
    public static var _shieldWarning:int = 30;
    public static var _weaponWarning:int = 30;

    private static const ENGINE_COLOR:uint = 8092539;
    private static const SHIELD_COLOR:uint = 15129098;
    private static const WEAPON_COLOR:uint = 2477349;

    public var SR:MovieClip;
    public var SMI:MovieClip;
    public var GR:MovieClip;
    public var YL:MovieClip;
    public var YM:MovieClip;
    public var YMI:MovieClip;
    public var SL:MovieClip;
    public var SM:MovieClip;
    public var YR:MovieClip;
    public var GL:MovieClip;
    public var GM:MovieClip;
    public var GMI:MovieClip;

    private var _GL:MovieClip;
    private var _GM:MovieClip;
    private var _GMI:MovieClip;
    private var _GR:MovieClip;
    private var _SL:MovieClip;
    private var _SM:MovieClip;
    private var _SMI:MovieClip;
    private var _SR:MovieClip;
    private var _YL:MovieClip;
    private var _YM:MovieClip;
    private var _YMI:MovieClip;
    private var _YR:MovieClip;
    private var _engine:int = 100;
    private var _shield:int = 100;
    private var _weapon:int = 100;
    private var _width:int;
    private var glowAlpha:Number = 0;
    private var glowDelta:* = 0.2;
    private var glowTargets:Array = [null,null,null,null,null,null];

    public function TankState() {
      super();
      y = 6;
      this._YL = getChildByName("YL") as MovieClip;
      this._YM = getChildByName("YM") as MovieClip;
      this._YMI = getChildByName("YMI") as MovieClip;
      this._YR = getChildByName("YR") as MovieClip;
      this._GL = getChildByName("GL") as MovieClip;
      this._GM = getChildByName("GM") as MovieClip;
      this._GMI = getChildByName("GMI") as MovieClip;
      this._GR = getChildByName("GR") as MovieClip;
      this._SL = getChildByName("SL") as MovieClip;
      this._SM = getChildByName("SM") as MovieClip;
      this._SMI = getChildByName("SMI") as MovieClip;
      this._SR = getChildByName("SR") as MovieClip;
    }

    public function set engine(param1:int) : void {
      this._engine = int(param1 / 100);
      this._engine = this._engine < 1 ? 1 : this._engine;
      if(this._engine < _engineWarning) {
        this.startGlow(TankState.ENGINE);
      } else {
        this.stopGlow(TankState.ENGINE);
      }
      this.draw();
    }

    public function set shield(param1:int) : void {
      this._shield = int(param1 / 100);
      this._shield = this._shield < 1 ? 1 : this._shield;
      if(this._shield < _shieldWarning) {
        this.startGlow(TankState.ARMOR);
      } else {
        this.stopGlow(TankState.ARMOR);
      }
      this.draw();
    }

    public function startGlow(param1:int) : void {
      switch(param1) {
        case ENGINE:
          this.glowTargets[0] = this._YM;
          this.glowTargets[1] = this._YL;
          break;
        case WEAPON:
          this.glowTargets[2] = this._GM;
          this.glowTargets[3] = this._GL;
          break;
        case ARMOR:
          this.glowTargets[4] = this._SM;
          this.glowTargets[5] = this._SL;
      }
      var local2:int = 0;
      while(local2 < 6) {
        if(this.glowTargets[local2] != null) {
          addEventListener(Event.ENTER_FRAME,this.glowFrame);
          break;
        }
        local2++;
      }
    }

    public function stopGlow(param1:int) : void {
      var local2:Boolean = true;
      switch(param1) {
        case ENGINE:
          this.glowTargets[0] = null;
          this.glowTargets[1] = null;
          this._YM.filters = this._YL.filters = new Array();
          break;
        case WEAPON:
          this.glowTargets[2] = null;
          this.glowTargets[3] = null;
          this._GM.filters = this._GL.filters = new Array();
          break;
        case ARMOR:
          this.glowTargets[4] = null;
          this.glowTargets[5] = null;
          this._SM.filters = this._SL.filters = new Array();
      }
      var local3:int = 0;
      while(local3 < 6) {
        if(this.glowTargets[local3] != null) {
          local2 = false;
          break;
        }
        local3++;
      }
      if(local2) {
        removeEventListener(Event.ENTER_FRAME,this.glowFrame);
        this._YM.filters = this._YL.filters = this._GM.filters = this._GL.filters = this._SM.filters = this._SL.filters = new Array();
        this.glowAlpha = 0;
      }
    }

    public function set type(param1:int) : void {
      switch(param1) {
        case ENGINE:
          this._YL.y = this._YM.y = this._YMI.y = this._YR.y = 0;
          this._GL.visible = this._GM.visible = this._GMI.visible = this._GR.visible = false;
          this._SL.visible = this._SM.visible = this._SMI.visible = this._SR.visible = false;
          break;
        case WEAPON:
          this._GL.y = this._GM.y = this._GMI.y = this._GR.y = 0;
          this._SL.visible = this._SM.visible = this._SMI.visible = this._SR.visible = false;
          this._YL.visible = this._YM.visible = this._YMI.visible = this._YR.visible = false;
          break;
        case ARMOR:
          this._SL.y = this._SM.y = this._SMI.y = this._SR.y = 0;
          this._GL.visible = this._GM.visible = this._GMI.visible = this._GR.visible = false;
          this._YL.visible = this._YM.visible = this._YMI.visible = this._YR.visible = false;
      }
      this.draw();
    }

    public function set weapon(param1:int) : void {
      this._weapon = int(param1 / 100);
      this._weapon = this._weapon < 1 ? 1 : this._weapon;
      if(this._weapon < _weaponWarning) {
        this.startGlow(TankState.WEAPON);
      } else {
        this.stopGlow(TankState.WEAPON);
      }
      this.draw();
    }

    override public function set width(param1:Number) : void {
      this._width = int(param1);
      this.draw();
    }

    private function draw() : void {
      var local4:BitmapData = null;
      var local5:Bitmap = null;
      var local1:Shape = new Shape();
      var local2:Graphics = local1.graphics;
      var local3:Number = this._width / 100;
      this._YMI.width = this._width - 2;
      this._GMI.width = this._width - 2;
      this._SMI.width = this._width - 2;
      this._YM.width = int(this._engine * local3 + 0.5) - 1;
      this._GM.width = int(this._weapon * local3 + 0.5) - 1;
      this._SM.width = int(this._shield * local3 + 0.5) - 1;
      this._YR.x = this._width;
      this._GR.x = this._width;
      this._SR.x = this._width;
      this._YR.gotoAndStop(this._engine > 99 ? 2 : 1);
      this._GR.gotoAndStop(this._weapon > 99 ? 2 : 1);
      this._SR.gotoAndStop(this._shield > 99 ? 2 : 1);
    }

    private function glowFrame(param1:Event) : * {
      var local2:MovieClip = null;
      var local3:GlowFilter = new GlowFilter(16711680,this.glowAlpha,8,8,2,1,true);
      var local4:int = 0;
      while(local4 < 6) {
        if(this.glowTargets[local4] != null) {
          local2 = this.glowTargets[local4];
          local2.filters = [local3];
        }
        local4++;
      }
      this.glowDelta *= this.glowAlpha > 1 || this.glowAlpha < 0 ? -1 : 1;
      this.glowAlpha += this.glowDelta;
    }
  }
}
