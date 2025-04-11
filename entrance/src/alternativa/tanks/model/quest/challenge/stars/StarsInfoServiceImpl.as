package alternativa.tanks.model.quest.challenge.stars {
  import flash.events.EventDispatcher;

  public class StarsInfoServiceImpl extends EventDispatcher implements StarsInfoService {
    private var stars:int;

    public function StarsInfoServiceImpl() {
      super();
    }

    public function getStars() : int {
      return this.stars;
    }

    public function setStars(param1:int) : void {
      this.stars = param1;
      dispatchEvent(new StarsChangedEvent());
    }
  }
}
