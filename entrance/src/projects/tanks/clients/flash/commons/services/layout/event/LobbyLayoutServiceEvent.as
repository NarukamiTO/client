package projects.tanks.clients.flash.commons.services.layout.event {
  import flash.events.Event;
  import projects.tanks.client.commons.models.layout.LayoutState;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.LobbyLayoutServiceEvents;

  public class LobbyLayoutServiceEvent extends Event {
    public static const BEGIN_LAYOUT_SWITCH:String = LobbyLayoutServiceEvents.BEGIN_LAYOUT_SWITCH;
    public static const END_LAYOUT_SWITCH:String = LobbyLayoutServiceEvents.END_LAYOUT_SWITCH;

    public var state:LayoutState;

    public function LobbyLayoutServiceEvent(param1:String, param2:LayoutState) {
      super(param1);
      this.state = param2;
    }
  }
}
