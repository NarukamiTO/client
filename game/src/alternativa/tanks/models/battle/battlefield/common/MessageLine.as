package alternativa.tanks.models.battle.battlefield.common {
  import alternativa.tanks.models.battle.battlefield.event.ChatOutputLineEvent;
  import filters.Filters;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.TimerEvent;
  import flash.utils.Timer;
  import flash.utils.setTimeout;

  public class MessageLine extends Sprite {
    private static const LIFE_TIME:int = 30000;

    protected var _alive:Boolean = true;

    private var killTimer:Timer;
    private var stop:Boolean = false;
    private var runOut:Boolean = false;

    protected var shadowContainer:Sprite = new Sprite();

    public function MessageLine() {
      super();
      this.shadowContainer.filters = Filters.SHADOW_FILTERS;
      addChild(this.shadowContainer);
      addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
    }

    public function killStop() : void {
      alpha = 1;
      removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      this.stop = true;
    }

    public function killStart() : void {
      this.stop = false;
      if(this.runOut) {
        this.killSelf();
      }
    }

    public function get alive() : Boolean {
      return this._alive;
    }

    private function onAddedToStage(param1:Event) : void {
      setTimeout(this.timeRunOut,LIFE_TIME);
    }

    private function timeRunOut() : void {
      this.runOut = true;
      if(!this.stop) {
        this.killSelf();
      }
    }

    private function killSelf() : void {
      this.killTimer = new Timer(50,20);
      this.killTimer.addEventListener(TimerEvent.TIMER,this.onKillTimer);
      this.killTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onKillComplete);
      this.killTimer.start();
    }

    private function onKillTimer(param1:TimerEvent) : void {
      if(!this.stop) {
        alpha -= 0.05;
      } else {
        this.killTimer.stop();
        alpha = 1;
      }
    }

    private function onKillComplete(param1:TimerEvent) : void {
      this._alive = false;
      dispatchEvent(new ChatOutputLineEvent(ChatOutputLineEvent.KILL_ME,this));
      removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
    }
  }
}
