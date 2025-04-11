package fl.data {
  public dynamic class TileListCollectionItem {
    [Inspectable]
    public var source:String;

    [Inspectable]
    public var label:String;

    public function TileListCollectionItem() {
      super();
    }

    public function toString() : String {
      return "[TileListCollectionItem: " + label + "," + source + "]";
    }
  }
}
