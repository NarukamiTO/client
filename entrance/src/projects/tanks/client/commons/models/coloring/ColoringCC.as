package projects.tanks.client.commons.models.coloring {
  import platform.client.fp10.core.resource.types.MultiframeTextureResource;
  import platform.client.fp10.core.resource.types.TextureResource;

  public class ColoringCC {
    private var _animatedColoring:MultiframeTextureResource;
    private var _coloring:TextureResource;

    public function ColoringCC(param1:MultiframeTextureResource = null, param2:TextureResource = null) {
      super();
      this._animatedColoring = param1;
      this._coloring = param2;
    }

    public function get animatedColoring() : MultiframeTextureResource {
      return this._animatedColoring;
    }

    public function set animatedColoring(param1:MultiframeTextureResource) : void {
      this._animatedColoring = param1;
    }

    public function get coloring() : TextureResource {
      return this._coloring;
    }

    public function set coloring(param1:TextureResource) : void {
      this._coloring = param1;
    }

    public function toString() : String {
      var local1:String = "ColoringCC [";
      local1 += "animatedColoring = " + this.animatedColoring + " ";
      local1 += "coloring = " + this.coloring + " ";
      return local1 + "]";
    }
  }
}
