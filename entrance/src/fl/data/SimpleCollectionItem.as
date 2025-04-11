package fl.data {
  public dynamic class SimpleCollectionItem {
    [Inspectable]
    public var data:String;

    [Inspectable]
    public var label:String;

    public function SimpleCollectionItem() {
      super();
    }

    public function toString() : String {
      return "[SimpleCollectionItem: " + label + "," + data + "]";
    }
  }
}
