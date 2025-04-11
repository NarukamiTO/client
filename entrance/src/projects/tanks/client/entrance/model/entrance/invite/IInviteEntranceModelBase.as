package projects.tanks.client.entrance.model.entrance.invite {
  public interface IInviteEntranceModelBase {
    function inviteAlreadyActivated(param1:String) : void;
    function inviteFree() : void;
    function inviteNotFound() : void;
  }
}
