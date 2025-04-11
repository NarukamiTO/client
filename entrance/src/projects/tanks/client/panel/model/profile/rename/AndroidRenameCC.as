package projects.tanks.client.panel.model.profile.rename {
  public class AndroidRenameCC {
    private var _renameEnabled:Boolean;

    public function AndroidRenameCC(param1:Boolean = false) {
      super();
      this._renameEnabled = param1;
    }

    public function get renameEnabled() : Boolean {
      return this._renameEnabled;
    }

    public function set renameEnabled(param1:Boolean) : void {
      this._renameEnabled = param1;
    }

    public function toString() : String {
      var local1:String = "AndroidRenameCC [";
      local1 += "renameEnabled = " + this.renameEnabled + " ";
      return local1 + "]";
    }
  }
}
