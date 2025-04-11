package alternativa.tanks.battle.scene3d.scene3dcontainer {
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.core.Object3DContainer;
  import flash.utils.Dictionary;

  public class Object3DContainerProxy implements Scene3DContainer {
    private var container:Object3DContainer = new Object3DContainer();

    private const objects:Dictionary = new Dictionary();

    public function Object3DContainerProxy(param1:Object3DContainer = null) {
      super();
      this.setContainer(param1);
    }

    public function addChild(param1:Object3D) : void {
      if(param1 == null) {
        throw new ArgumentError("Parameter is null");
      }
      if(!this.objects[param1]) {
        this.objects[param1] = true;
        this.container.addChild(param1);
      }
    }

    public function addChildAt(param1:Object3D, param2:int) : void {
      if(param1 == null) {
        throw new ArgumentError("Parameter is null");
      }
      if(!this.objects[param1]) {
        this.objects[param1] = true;
        this.container.addChildAt(param1,param2);
      }
    }

    public function addChildren(param1:Vector.<Object3D>) : void {
      var local2:Object3D = null;
      if(param1 == null) {
        throw new ArgumentError("Parameter is null");
      }
      for each(local2 in param1) {
        this.addChild(local2);
      }
    }

    public function removeChild(param1:Object3D) : void {
      if(param1 == null) {
        throw new ArgumentError("Parameter is null");
      }
      if(Boolean(this.objects[param1])) {
        delete this.objects[param1];
        this.container.removeChild(param1);
      }
    }

    public function setContainer(param1:Object3DContainer) : void {
      var local2:Vector.<Object3D> = this.removeAllChildren();
      this.container = param1 || new Object3DContainer();
      this.addChildren(local2);
    }

    private function removeAllChildren() : Vector.<Object3D> {
      var local2:* = undefined;
      var local1:Vector.<Object3D> = new Vector.<Object3D>();
      for(local2 in this.objects) {
        delete this.objects[local2];
        this.container.removeChild(local2);
        local1.push(local2);
      }
      return local1;
    }
  }
}
