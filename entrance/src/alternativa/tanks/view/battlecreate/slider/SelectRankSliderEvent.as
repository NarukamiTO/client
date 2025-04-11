package alternativa.tanks.view.battlecreate.slider {
  import flash.events.Event;

  public class SelectRankSliderEvent extends Event {
    public static const RANK_LIMIT_CHANGED:String = "SelectRankSliderEvent_LimitChanged";

    public function SelectRankSliderEvent() {
      super(RANK_LIMIT_CHANGED);
    }
  }
}
