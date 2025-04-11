package projects.tanks.client.garage.models.item.mobilelootbox.lootbox {
  import platform.client.fp10.core.resource.types.ImageResource;

  public class MobileLoot {
    private var _count:int;
    private var _image:ImageResource;
    private var _name:String;

    public function MobileLoot(param1:int = 0, param2:ImageResource = null, param3:String = null) {
      super();
      this._count = param1;
      this._image = param2;
      this._name = param3;
    }

    public function get count() : int {
      return this._count;
    }

    public function set count(param1:int) : void {
      this._count = param1;
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

    public function toString() : String {
      var local1:String = "MobileLoot [";
      local1 += "count = " + this.count + " ";
      local1 += "image = " + this.image + " ";
      local1 += "name = " + this.name + " ";
      return local1 + "]";
    }
  }
}
