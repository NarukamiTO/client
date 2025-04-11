package projects.tanks.client.panel.model.socialnetwork {
  public interface ISocialNetworkPanelModelBase {
    function linkAlreadyExists(param1:String) : void;
    function linkCreated(param1:String) : void;
    function unlinkSuccess(param1:String) : void;
    function validationFailed() : void;
  }
}
