package projects.tanks.client.clans.panel.notification {
  public interface IClanPanelNotificationModelBase {
    function added() : void;
    function removed() : void;
    function updateRestrictionTimeJoinClan(param1:int) : void;
  }
}
