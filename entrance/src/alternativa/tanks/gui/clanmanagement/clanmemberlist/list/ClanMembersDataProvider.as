package alternativa.tanks.gui.clanmanagement.clanmemberlist.list {
  import alternativa.types.Long;
  import fl.data.DataProvider;

  public class ClanMembersDataProvider extends DataProvider {
    private var _getItemAtHandler:Function;

    public function ClanMembersDataProvider() {
      super();
    }

    public function getItemIndexById(param1:Long) : int {
      var local2:Object = null;
      var local3:int = int(length);
      var local4:int = 0;
      while(local4 < local3) {
        local2 = this.getItemAt(local4);
        if(local2 && local2.hasOwnProperty("id") && local2["id"] == param1) {
          return local4;
        }
        local4++;
      }
      return -1;
    }

    public function get getItemAtHandler() : Function {
      return this._getItemAtHandler;
    }

    public function set getItemAtHandler(param1:Function) : void {
      this._getItemAtHandler = param1;
    }

    override public function getItemAt(param1:uint) : Object {
      var local2:Object = super.getItemAt(param1);
      if(this.getItemAtHandler != null) {
        this.getItemAtHandler(local2);
      }
      return local2;
    }
  }
}
