package alternativa.tanks.gui.clanmanagement.clanmemberlist {
  import alternativa.types.Long;
  import projects.tanks.client.clans.clan.clanmembersdata.UserData;

  public interface IClanPositionListener {
    function dataChanged(param1:UserData) : void;
    function get userId() : Long;
  }
}
