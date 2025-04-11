package projects.tanks.clients.flash.resources.tanks {
  import alternativa.engine3d.core.Object3DContainer;
  import flash.display.BitmapData;
  import flash.geom.Vector3D;

  public class Tank3DPart {
    public var view:Object3DContainer;
    public var lightmap:BitmapData;
    public var details:BitmapData;
    public var turretMountPoint:Vector3D;

    public function Tank3DPart() {
      super();
    }
  }
}
