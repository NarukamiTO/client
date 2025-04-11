package controls.rangicons {
  import flash.display.DisplayObject;
  import flash.display.MovieClip;

  [Embed(source="/_assets/assets.swf", symbol="symbol359")]
  public class RangIconNormal extends RangIcon {
    public var g:MovieClip;

    private var gl:DisplayObject;

    public function RangIconNormal(param1:int = 1) {
      addFrameScript(0,this.frame1);
      super(param1);
      this.gl = getChildByName("g");
      this.gl.visible = false;
    }

    public function set glow(param1:Boolean) : void {
      this.gl.visible = param1;
    }

    internal function frame1() : * {
      stop();
    }
  }
}
