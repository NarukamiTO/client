package projects.tanks.client.garage.models.item.container {
  import platform.client.fp10.core.resource.types.ImageResource;

  public class ContainerGivenItem {
    private var _category:ContainerItemCategory;
    private var _count:int;
    private var _image:ImageResource;
    private var _name:String;

    public function ContainerGivenItem(param1:ContainerItemCategory = null, param2:int = 0, param3:ImageResource = null, param4:String = null) {
      super();
      this._category = param1;
      this._count = param2;
      this._image = param3;
      this._name = param4;
    }

    public function get category() : ContainerItemCategory {
      return this._category;
    }

    public function set category(param1:ContainerItemCategory) : void {
      this._category = param1;
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
      var local1:String = "ContainerGivenItem [";
      local1 += "category = " + this.category + " ";
      local1 += "count = " + this.count + " ";
      local1 += "image = " + this.image + " ";
      local1 += "name = " + this.name + " ";
      return local1 + "]";
    }
  }
}
