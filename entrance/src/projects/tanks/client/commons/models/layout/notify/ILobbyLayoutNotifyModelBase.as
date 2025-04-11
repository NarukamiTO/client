package projects.tanks.client.commons.models.layout.notify {
  import projects.tanks.client.commons.models.layout.LayoutState;

  public interface ILobbyLayoutNotifyModelBase {
    function beginLayoutSwitch(param1:LayoutState) : void;
    function cancelPredictedLayoutSwitch() : void;
    function endLayoutSwitch(param1:LayoutState, param2:LayoutState) : void;
  }
}
