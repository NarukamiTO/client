package alternativa.tanks.battle.objects.tank.tankskin {
  import alternativa.engine3d.core.Sorting;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.types.Long;
  import flash.display.BitmapData;
  import flash.display.BlendMode;
  import flash.display.Shape;
  import platform.client.fp10.core.resource.types.StubBitmapData;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;

  public class TankSkinPartCacheItem {
    private static const DETAILS:String = "details.png";
    private static const LIGHTMAP:String = "lightmap.jpg";
    private static const stubBitmaps:Object = {};

    public var partId:Long;
    public var details:BitmapData;
    public var lightmap:BitmapData;

    public function TankSkinPartCacheItem(param1:Tanks3DSResource) {
      super();
      this.partId = param1.id;
      this.details = param1.textures[DETAILS] || this.getStubBitmapData(DETAILS,65280);
      this.lightmap = param1.textures[LIGHTMAP] || this.getStubBitmapData(LIGHTMAP,8355711);
    }

    private function getStubBitmapData(param1:String, param2:uint) : BitmapData {
      var local3:BitmapData = stubBitmaps[param1];
      if(local3 == null) {
        local3 = new StubBitmapData(param2);
        stubBitmaps[param1] = local3;
      }
      return local3;
    }

    public function createTexture(param1:BitmapData) : BitmapData {
      var local2:BitmapData = new BitmapData(this.lightmap.width,this.lightmap.height,false,0);
      var local3:Shape = new Shape();
      local3.graphics.beginBitmapFill(param1);
      local3.graphics.drawRect(0,0,this.lightmap.width,this.lightmap.height);
      local2.draw(local3);
      local2.draw(this.lightmap,null,null,BlendMode.HARDLIGHT);
      local2.draw(this.details);
      local3 = null;
      return local2;
    }

    protected function initMesh(param1:Mesh) : Mesh {
      if(param1.sorting != Sorting.DYNAMIC_BSP) {
        param1.sorting = Sorting.DYNAMIC_BSP;
        param1.calculateFacesNormals(true);
        param1.optimizeForDynamicBSP();
        param1.threshold = 0.01;
      }
      return param1;
    }
  }
}
