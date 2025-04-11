package projects.tanks.client.garage.models.item.droppablegold {
  public class DroppableGoldItemCC {
    private var _showDroppableGoldAuthor:Boolean;

    public function DroppableGoldItemCC(param1:Boolean = false) {
      super();
      this._showDroppableGoldAuthor = param1;
    }

    public function get showDroppableGoldAuthor() : Boolean {
      return this._showDroppableGoldAuthor;
    }

    public function set showDroppableGoldAuthor(param1:Boolean) : void {
      this._showDroppableGoldAuthor = param1;
    }

    public function toString() : String {
      var local1:String = "DroppableGoldItemCC [";
      local1 += "showDroppableGoldAuthor = " + this.showDroppableGoldAuthor + " ";
      return local1 + "]";
    }
  }
}
