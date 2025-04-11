package projects.tanks.clients.flash.resources.resource.loaders {
  public class TextureInfo {
    public var diffuseMapFileName:String;
    public var opacityMapFileName:String;

    public function TextureInfo(param1:String = null, param2:String = null) {
      super();
      this.diffuseMapFileName = param1;
      this.opacityMapFileName = param2;
    }

    public function toString() : String {
      return "[TextureInfo diffuseMapFileName=" + this.diffuseMapFileName + ", opacityMapFileName=" + this.opacityMapFileName + "]";
    }
  }
}
