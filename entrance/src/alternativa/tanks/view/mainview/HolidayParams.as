package alternativa.tanks.view.mainview {
  import platform.client.fp10.core.resource.types.ImageResource;
  import projects.tanks.client.battleselect.model.matchmaking.view.MatchmakingLayoutCC;

  public class HolidayParams {
    private var _holidayTitle:String;
    private var _holidayDescription:String;
    private var _holidayIcon:ImageResource;

    public function HolidayParams(param1:MatchmakingLayoutCC) {
      super();
      this._holidayTitle = param1.holidayTitle;
      this._holidayDescription = param1.holidayDescription;
      this._holidayIcon = param1.holidayIcon;
    }

    public function get holidayTitle() : String {
      return this._holidayTitle;
    }

    public function get holidayDescription() : String {
      return this._holidayDescription;
    }

    public function get holidayIcon() : ImageResource {
      return this._holidayIcon;
    }
  }
}
