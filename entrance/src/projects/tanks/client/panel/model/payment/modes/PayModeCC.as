package projects.tanks.client.panel.model.payment.modes {
  import platform.client.fp10.core.resource.types.ImageResource;

  public class PayModeCC {
    private var _customManualDescription:String;
    private var _description:String;
    private var _image:ImageResource;
    private var _name:String;
    private var _order:int;

    public function PayModeCC(param1:String = null, param2:String = null, param3:ImageResource = null, param4:String = null, param5:int = 0) {
      super();
      this._customManualDescription = param1;
      this._description = param2;
      this._image = param3;
      this._name = param4;
      this._order = param5;
    }

    public function get customManualDescription() : String {
      return this._customManualDescription;
    }

    public function set customManualDescription(param1:String) : void {
      this._customManualDescription = param1;
    }

    public function get description() : String {
      return this._description;
    }

    public function set description(param1:String) : void {
      this._description = param1;
    }

    public function get image() : ImageResource {
      return this._image;
    }

    public function set image(param1:ImageResource) : void {
      this._image = param1;
    }

    public function get name() : String {
      return this._name;
    }

    public function set name(param1:String) : void {
      this._name = param1;
    }

    public function get order() : int {
      return this._order;
    }

    public function set order(param1:int) : void {
      this._order = param1;
    }

    public function toString() : String {
      var local1:String = "PayModeCC [";
      local1 += "customManualDescription = " + this.customManualDescription + " ";
      local1 += "description = " + this.description + " ";
      local1 += "image = " + this.image + " ";
      local1 += "name = " + this.name + " ";
      local1 += "order = " + this.order + " ";
      return local1 + "]";
    }
  }
}
