package projects.tanks.client.panel.model.kitoffer.log {
  public class KitOfferAction {
    public static const BUY_BUTTON_CLICK:KitOfferAction = new KitOfferAction(0,"BUY_BUTTON_CLICK");
    public static const PICTURE_CLICK:KitOfferAction = new KitOfferAction(1,"PICTURE_CLICK");
    public static const EXIT_BUTTON_CLICK:KitOfferAction = new KitOfferAction(2,"EXIT_BUTTON_CLICK");

    private var _value:int;
    private var _name:String;

    public function KitOfferAction(param1:int, param2:String) {
      super();
      this._value = param1;
      this._name = param2;
    }

    public static function get values() : Vector.<KitOfferAction> {
      var local1:Vector.<KitOfferAction> = new Vector.<KitOfferAction>();
      local1.push(BUY_BUTTON_CLICK);
      local1.push(PICTURE_CLICK);
      local1.push(EXIT_BUTTON_CLICK);
      return local1;
    }

    public function toString() : String {
      return "KitOfferAction [" + this._name + "]";
    }

    public function get value() : int {
      return this._value;
    }

    public function get name() : String {
      return this._name;
    }
  }
}
