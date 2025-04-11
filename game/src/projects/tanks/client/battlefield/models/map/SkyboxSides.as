package projects.tanks.client.battlefield.models.map {
  import platform.client.fp10.core.resource.types.TextureResource;

  public class SkyboxSides {
    private var _back:TextureResource;
    private var _bottom:TextureResource;
    private var _front:TextureResource;
    private var _left:TextureResource;
    private var _right:TextureResource;
    private var _top:TextureResource;

    public function SkyboxSides(param1:TextureResource = null, param2:TextureResource = null, param3:TextureResource = null, param4:TextureResource = null, param5:TextureResource = null, param6:TextureResource = null) {
      super();
      this._back = param1;
      this._bottom = param2;
      this._front = param3;
      this._left = param4;
      this._right = param5;
      this._top = param6;
    }

    public function get back() : TextureResource {
      return this._back;
    }

    public function set back(param1:TextureResource) : void {
      this._back = param1;
    }

    public function get bottom() : TextureResource {
      return this._bottom;
    }

    public function set bottom(param1:TextureResource) : void {
      this._bottom = param1;
    }

    public function get front() : TextureResource {
      return this._front;
    }

    public function set front(param1:TextureResource) : void {
      this._front = param1;
    }

    public function get left() : TextureResource {
      return this._left;
    }

    public function set left(param1:TextureResource) : void {
      this._left = param1;
    }

    public function get right() : TextureResource {
      return this._right;
    }

    public function set right(param1:TextureResource) : void {
      this._right = param1;
    }

    public function get top() : TextureResource {
      return this._top;
    }

    public function set top(param1:TextureResource) : void {
      this._top = param1;
    }

    public function toString() : String {
      var local1:String = "SkyboxSides [";
      local1 += "back = " + this.back + " ";
      local1 += "bottom = " + this.bottom + " ";
      local1 += "front = " + this.front + " ";
      local1 += "left = " + this.left + " ";
      local1 += "right = " + this.right + " ";
      local1 += "top = " + this.top + " ";
      return local1 + "]";
    }
  }
}
