package alternativa.tanks.models.battle.gui.markers {
  import alternativa.engine3d.core.Object3D;
  import alternativa.math.Vector3;
  import flash.display.Bitmap;
  import flash.display.Sprite;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;

  public class PointHudIndicator extends Sprite {
    public static const STATE_DEFAULT:int = 0;
    public static const STATE_DROPPED:int = 1;
    public static const STATE_CARRIED:int = 2;
    public static const STATE_OUT:int = 3;

    private var indicatorStateProvider:PointIndicatorStateProvider;
    private var vec:Vector3 = new Vector3();
    private var defaultIndicatorBitmap:Bitmap = null;
    private var droppedIndicatorBitmap:Bitmap = null;
    private var carriedIndicatorBitmap:Bitmap = null;
    private var outIndicatorBitmap:Bitmap = null;
    private var state:int;
    private var _zindex:Number;
    private var _visibleToBlue:Boolean;
    private var _visibleToRed:Boolean;

    public function PointHudIndicator(param1:Bitmap, param2:PointIndicatorStateProvider, param3:Bitmap = null, param4:Bitmap = null, param5:Bitmap = null) {
      super();
      this.indicatorStateProvider = param2;
      this.defaultIndicatorBitmap = param1;
      this.droppedIndicatorBitmap = param3;
      this.carriedIndicatorBitmap = param4;
      this.outIndicatorBitmap = param5;
      this._visibleToBlue = true;
      this._visibleToRed = true;
      this.checkAndAddChild(this.defaultIndicatorBitmap);
      this.checkAndAddChild(this.droppedIndicatorBitmap);
      this.checkAndAddChild(this.carriedIndicatorBitmap);
      this.checkAndAddChild(this.outIndicatorBitmap);
      this.setStateImpl(STATE_DEFAULT);
    }

    private function checkAndAddChild(param1:Bitmap) : void {
      if(param1 != null) {
        addChild(param1);
      }
    }

    public function readPosition3D(param1:Vector3) : void {
      param1.copy(this.indicatorStateProvider.getIndicatorPosition());
      param1.z += this.indicatorStateProvider.zOffset();
    }

    public function isActive(param1:Object3D) : Boolean {
      this.vec.reset(param1.x,param1.y,param1.z);
      return this.indicatorStateProvider.isIndicatorActive(this.vec);
    }

    public function setState(param1:int) : void {
      if(param1 == STATE_DROPPED && this.droppedIndicatorBitmap == null || param1 == STATE_CARRIED && this.carriedIndicatorBitmap == null || param1 == STATE_OUT && this.outIndicatorBitmap == null) {
        this.setStateImpl(STATE_DEFAULT);
      } else {
        this.setStateImpl(param1);
      }
    }

    public function getState() : int {
      return this.state;
    }

    private function setStateImpl(param1:int) : void {
      this.state = param1;
      switch(param1) {
        case STATE_DROPPED:
          this.setVisibility(false,true,false,false);
          break;
        case STATE_CARRIED:
          this.setVisibility(false,false,true,false);
          break;
        case STATE_OUT:
          this.setVisibility(false,false,false,true);
          break;
        case STATE_DEFAULT:
        default:
          this.setVisibility(true,false,false,false);
      }
    }

    private function setVisibility(param1:Boolean, param2:Boolean, param3:Boolean, param4:Boolean) : void {
      if(Boolean(this.defaultIndicatorBitmap)) {
        this.defaultIndicatorBitmap.visible = param1;
      }
      if(Boolean(this.droppedIndicatorBitmap)) {
        this.droppedIndicatorBitmap.visible = param2;
      }
      if(Boolean(this.carriedIndicatorBitmap)) {
        this.carriedIndicatorBitmap.visible = param3;
      }
      if(Boolean(this.outIndicatorBitmap)) {
        this.outIndicatorBitmap.visible = param4;
      }
    }

    public function get zindex() : Number {
      return this._zindex;
    }

    public function set zindex(param1:Number) : void {
      this._zindex = param1;
    }

    public function get visibleToBlue() : Boolean {
      return this._visibleToBlue;
    }

    public function get visibleToRed() : Boolean {
      return this._visibleToRed;
    }

    public function set visibleToBlue(param1:Boolean) : void {
      this._visibleToBlue = param1;
    }

    public function set visibleToRed(param1:Boolean) : void {
      this._visibleToRed = param1;
    }

    public function visibleFor(param1:BattleTeam) : Boolean {
      if(param1 == BattleTeam.RED) {
        return this._visibleToRed;
      }
      if(param1 == BattleTeam.BLUE) {
        return this._visibleToBlue;
      }
      if(param1 == BattleTeam.NONE) {
        return true;
      }
      return false;
    }
  }
}
