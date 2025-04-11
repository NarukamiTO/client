package alternativa.tanks.models.battlemessages {
  import controls.Label;

  internal class Message {
    private static const FLASH_TIME:int = 500;
    private static const FADE_TIME:int = 700;
    private static const LIFE_TIME1:int = 2000;
    private static const LIFE_TIME2:int = 10000;
    private static const ALPHA:Number = 0.6;

    private const FONT_SIZE:int = 18;

    private var STATES:Vector.<MessageState>;
    private var DURATION_STATES:Vector.<MessageState>;

    public var isDead:Boolean;

    private var label:Label = new Label();
    private var states:Vector.<MessageState>;
    private var currentStateIndex:int;

    public function Message() {
      super();
      this.STATES = Vector.<MessageState>([new StateAlpha(this,FLASH_TIME,0,1),new StateNormal(LIFE_TIME1),new StateAlpha(this,FADE_TIME,1,ALPHA),new StateNormal(LIFE_TIME2),new StateAlpha(this,FADE_TIME,ALPHA,0)]);
      this.DURATION_STATES = Vector.<MessageState>([new StateAlpha(this,FADE_TIME,1,ALPHA),new StateNormal(LIFE_TIME2),new StateAlpha(this,FADE_TIME,ALPHA,0)]);
      this.label.size = this.FONT_SIZE;
      this.label.bold = true;
    }

    public function init() : void {
      this.isDead = false;
      this.currentStateIndex = 0;
      this.states = this.STATES;
      var local1:MessageState = this.states[0];
      local1.init();
    }

    public function initWithDuration(param1:int) : void {
      this.isDead = false;
      this.currentStateIndex = 0;
      this.states = this.DURATION_STATES;
      var local2:MessageState = this.states[1];
      local2.setDurationInMs(param1);
      var local3:MessageState = this.states[0];
      local3.init();
    }

    public function update(param1:int) : void {
      var local2:MessageState = null;
      var local3:MessageState = null;
      if(!this.isDead) {
        local2 = this.states[this.currentStateIndex];
        if(!local2.update(param1)) {
          if(++this.currentStateIndex == this.states.length) {
            this.isDead = true;
          } else {
            local3 = this.states[this.currentStateIndex];
            local3.init();
          }
        }
      }
    }

    public function setAlpha(param1:Number) : void {
      this.label.alpha = param1;
    }

    public function getLabel() : Label {
      return this.label;
    }
  }
}
