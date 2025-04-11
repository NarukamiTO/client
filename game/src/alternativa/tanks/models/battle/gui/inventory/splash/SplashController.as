package alternativa.tanks.models.battle.gui.inventory.splash {
  import flash.display.DisplayObject;
  import flash.geom.ColorTransform;
  import flash.utils.getTimer;

  public class SplashController implements ISplashController {
    public static const SPLASH_SHOW_DURATION:uint = 100;
    public static const SPLASH_FADE_DURATION:uint = 250;

    private var _splashState:int;
    private var _colorTransform:ColorTransform;
    private var _splashStartTime:int;
    private var _splashObject:DisplayObject;
    private var _finishShowStateCallback:Function;
    private var _splashColor:uint;

    public function SplashController(param1:DisplayObject) {
      super();
      this._splashObject = param1;
      this.init();
    }

    private function init() : void {
      this._splashState = SplashState.DONE;
      this._colorTransform = new ColorTransform();
    }

    public function startFlash(param1:uint, param2:Function = null) : void {
      this.stopFlash();
      this._finishShowStateCallback = param2;
      this._splashColor = param1;
      this._splashStartTime = getTimer();
      this._splashState = SplashState.SHOW;
    }

    public function stopFlash() : void {
      if(this._splashState != SplashState.DONE) {
        this._splashState = SplashState.DONE;
        this.interpolate(this._splashColor,0);
      }
    }

    public function update(param1:int) : void {
      if(this._splashState == SplashState.DONE) {
        return;
      }
      switch(this._splashState) {
        case SplashState.SHOW:
          if(param1 < this._splashStartTime + SPLASH_SHOW_DURATION) {
            this.interpolate(this._splashColor,(param1 - this._splashStartTime) / SPLASH_SHOW_DURATION);
          } else {
            this.interpolate(this._splashColor,1);
            this._splashStartTime += SPLASH_SHOW_DURATION + SPLASH_FADE_DURATION;
            this._splashState = SplashState.FADE;
            if(this._finishShowStateCallback != null) {
              this._finishShowStateCallback.apply();
              this._finishShowStateCallback = null;
            }
          }
          break;
        case SplashState.FADE:
          if(param1 < this._splashStartTime) {
            this.interpolate(this._splashColor,(this._splashStartTime - param1) / SPLASH_FADE_DURATION);
          } else {
            this.stopFlash();
          }
      }
    }

    private function interpolate(param1:uint, param2:Number) : void {
      this._colorTransform.redMultiplier = 1 - param2;
      this._colorTransform.greenMultiplier = 1 - param2;
      this._colorTransform.blueMultiplier = 1 - param2;
      this._colorTransform.alphaMultiplier = 1 - param2;
      this._colorTransform.redOffset = (param1 >> 24 & 0xFF) * param2;
      this._colorTransform.greenOffset = (param1 >> 16 & 0xFF) * param2;
      this._colorTransform.blueOffset = (param1 >> 8 & 0xFF) * param2;
      this._colorTransform.alphaOffset = (param1 & 0xFF) * param2;
      this._splashObject.transform.colorTransform = this._colorTransform;
    }
  }
}
