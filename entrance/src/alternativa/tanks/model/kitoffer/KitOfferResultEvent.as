package alternativa.tanks.model.kitoffer {
  import flash.events.Event;
  import projects.tanks.client.panel.model.kitoffer.log.KitOfferAction;

  public class KitOfferResultEvent extends Event {
    public static const CLOSE:String = "KIT_OFFER_RESULT_CLOSE_EVENT";

    private var _action:KitOfferAction;

    public function KitOfferResultEvent(param1:KitOfferAction) {
      super(CLOSE);
      this._action = param1;
    }

    public function get action() : KitOfferAction {
      return this._action;
    }
  }
}
