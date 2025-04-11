package projects.tanks.clients.flash.commons.models.coloring {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.resource.types.MultiframeTextureResource;
  import platform.client.fp10.core.resource.types.TextureResource;
  import platform.client.fp10.core.type.IGameObject;

  public class IColoringEvents implements IColoring {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IColoringEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getColoring() : TextureResource {
      var result:TextureResource = null;
      var i:int = 0;
      var m:IColoring = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IColoring(this.impl[i]);
          result = m.getColoring();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getAnimatedColoring() : MultiframeTextureResource {
      var result:MultiframeTextureResource = null;
      var i:int = 0;
      var m:IColoring = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IColoring(this.impl[i]);
          result = m.getAnimatedColoring();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function isAnimated() : Boolean {
      var result:Boolean = false;
      var i:int = 0;
      var m:IColoring = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IColoring(this.impl[i]);
          result = Boolean(m.isAnimated());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
