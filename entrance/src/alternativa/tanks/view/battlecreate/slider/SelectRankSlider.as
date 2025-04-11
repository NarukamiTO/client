package alternativa.tanks.view.battlecreate.slider {
  import controls.Slider;
  import controls.slider.SliderTrack;
  import flash.events.Event;
  import flash.events.MouseEvent;

  public class SelectRankSlider extends Slider {
    private var _minRang:int = 1;
    private var _maxRang:int = 1;
    private var _prevMinRang:int = 0;
    private var _prevMaxRang:int = 0;
    private var _currentRang:int = 1;
    private var _maxRangRange:int = 2;
    private var sthumb:SelectRankThumbSlider = new SelectRankThumbSlider();

    protected var _thumbTick:Number;

    public function SelectRankSlider() {
      super();
      removeChild(track);
      track = new SliderTrack(false);
      addChild(track);
      removeChild(thumb);
      addChild(this.sthumb);
      _thumb_width = 36;
    }

    override protected function UnConfigUI(param1:Event) : void {
      stage.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
      stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.dragThumb);
    }

    override protected function ConfigUI(param1:Event) : void {
      this.sthumb.leftDrag.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
      this.sthumb.rightDrag.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
      this.sthumb.centerDrag.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
    }

    override protected function onMouseDown(param1:MouseEvent) : void {
      super.onMouseDown(param1);
      stage.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
      this._prevMinRang = this._minRang;
      this._prevMaxRang = this._maxRang;
    }

    public function get minRang() : int {
      return this._minRang;
    }

    public function set minRang(param1:int) : void {
      this._minRang = param1;
      this.checkMinRang();
      this.drawThumb();
    }

    public function get maxRang() : int {
      return this._maxRang;
    }

    public function set maxRang(param1:int) : void {
      this._maxRang = param1;
      this.checkMaxRang();
      this.drawThumb();
    }

    public function get currentRang() : int {
      return this._currentRang;
    }

    public function set currentRang(param1:int) : void {
      this._currentRang = param1;
      value = this._minRang = this._maxRang = this._currentRang;
      this.drawThumb();
    }

    protected function checkMinRang() : void {
      if(this._minRang < _minValue) {
        this._minRang = _minValue;
      } else if(this._minRang < this._currentRang - this._maxRangRange) {
        this._minRang = this._currentRang - this._maxRangRange;
        this._maxRang = this._currentRang;
      } else if(this._minRang < this._maxRang - this._maxRangRange) {
        this._maxRang = this._minRang + this._maxRangRange;
      } else if(this._minRang > this._currentRang) {
        this._minRang = this._currentRang;
      }
    }

    protected function checkMaxRang() : void {
      if(this._maxRang > _maxValue) {
        this._maxRang = _maxValue;
      } else if(this._maxRang > this._currentRang + this._maxRangRange) {
        this._maxRang = this._currentRang + this._maxRangRange;
        this._minRang = this._currentRang;
      } else if(this._maxRang > this._minRang + this._maxRangRange) {
        this._minRang = this._maxRang - this._maxRangRange;
      } else if(this._maxRang < this._currentRang) {
        this._maxRang = this._currentRang;
      }
    }

    override public function set width(param1:Number) : void {
      super.width = param1;
      var local2:int = _maxValue - _minValue;
      this._thumbTick = (_width + 2 - _thumb_width) / local2;
      this.drawThumb();
    }

    override protected function onMouseUp(param1:MouseEvent) : void {
      if(param1 != null) {
        stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.dragThumb);
        stage.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
        if(this._prevMaxRang != this._minRang || this._prevMaxRang != this._maxRang) {
          dispatchEvent(new SelectRankSliderEvent());
        }
      }
    }

    override protected function dragThumb(param1:MouseEvent) : void {
      var local2:Boolean = trgt.mouseX < curThumbX;
      var local3:Boolean = trgt.mouseX > curThumbX;
      var local4:Boolean = this._minRang < this._currentRang;
      var local5:Boolean = this._maxRang > this._currentRang;
      var local6:int = 0;
      if(trgt == this.sthumb.leftDrag && (local2 || local4)) {
        this._minRang += int((this.sthumb.leftDrag.mouseX - curThumbX) / this._thumbTick);
        this.checkMinRang();
        this.checkMaxRang();
      } else if(trgt == this.sthumb.rightDrag && (local3 || local5)) {
        this._maxRang += int((this.sthumb.rightDrag.mouseX - curThumbX) / this._thumbTick);
        this.checkMinRang();
        this.checkMaxRang();
      } else if(trgt == this.sthumb.centerDrag && ((local2 || local4) && (local3 || local5))) {
        this._minRang += int((this.sthumb.centerDrag.mouseX - curThumbX) / this._thumbTick);
        this._maxRang += int((this.sthumb.centerDrag.mouseX - curThumbX) / this._thumbTick);
        if(this._minRang < _minValue) {
          local6 = this._maxRang - this._minRang;
          this._minRang = _minValue;
          this._maxRang = _minValue + local6;
        }
        if(this._maxRang > _maxValue) {
          local6 = this._maxRang - this._minRang;
          this._maxRang = _maxValue;
          this._minRang = this._maxRang - local6;
        }
        local6 = this._maxRang - this._minRang;
        if(this._minRang > this._currentRang) {
          this._minRang = this._currentRang;
          this._maxRang = this._minRang + local6;
        }
        if(this._maxRang < this._currentRang) {
          this._maxRang = this._currentRang;
          this._minRang = this._maxRang - local6;
        }
      }
      this.drawThumb();
    }

    private function drawThumb() : void {
      var local1:int = this._maxRang - this._minRang;
      this.sthumb.minRang = this._minRang;
      this.sthumb.maxRang = this._maxRang;
      this.sthumb.width = _thumb_width + this._thumbTick * local1;
      this.sthumb.x = int(this._thumbTick * (this._minRang - _minValue));
    }

    public function get maxRangRange() : int {
      return this._maxRangRange;
    }

    public function set maxRangRange(param1:int) : void {
      this._maxRangRange = param1;
    }
  }
}
