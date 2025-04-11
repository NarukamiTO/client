package alternativa.tanks.gui.clanmanagement.clanmemberlist {
  import alternativa.types.Long;

  [ModelInterface]
  public interface ISourceData {
    function addByUid(param1:String) : void;
    function checkUid(param1:String) : void;
    function setSearchInput(param1:ISearchInput) : void;
    function accept(param1:Long) : void;
  }
}
