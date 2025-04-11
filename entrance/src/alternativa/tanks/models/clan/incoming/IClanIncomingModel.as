package alternativa.tanks.models.clan.incoming {
  import alternativa.tanks.gui.clanmanagement.ClanIncomingRequestsDialog;
  import alternativa.types.Long;

  [ModelInterface]
  public interface IClanIncomingModel {
    function getUsers() : Vector.<Long>;
    function setClanIncomingWindow(param1:ClanIncomingRequestsDialog) : void;
  }
}
