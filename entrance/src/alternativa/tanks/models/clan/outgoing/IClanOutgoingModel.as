package alternativa.tanks.models.clan.outgoing {
  import alternativa.tanks.gui.clanmanagement.ClanOutgoingRequestsDialog;
  import alternativa.types.Long;

  [ModelInterface]
  public interface IClanOutgoingModel {
    function setClanOutgoingWindow(param1:ClanOutgoingRequestsDialog) : void;
    function getUsers() : Vector.<Long>;
  }
}
