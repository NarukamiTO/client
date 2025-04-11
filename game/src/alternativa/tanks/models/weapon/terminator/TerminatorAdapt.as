package alternativa.tanks.models.weapon.terminator {
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class TerminatorAdapt implements Terminator {
    private var object:IGameObject;
    private var impl:Terminator;

    public function TerminatorAdapt(param1:IGameObject, param2:Terminator) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function primaryCharge(param1:int, param2:int) : void {
      var time:int = param1;
      var barrelIndex:int = param2;
      try {
        Model.object = this.object;
        this.impl.primaryCharge(time,barrelIndex);
      }
      finally {
        Model.popObject();
      }
    }

    public function primaryShot(param1:int, param2:Vector3, param3:Vector.<Body>, param4:Vector.<Vector3>, param5:int) : void {
      var time:int = param1;
      var staticHitPoint:Vector3 = param2;
      var targets:Vector.<Body> = param3;
      var targetHitPoints:Vector.<Vector3> = param4;
      var barrelIndex:int = param5;
      try {
        Model.object = this.object;
        this.impl.primaryShot(time,staticHitPoint,targets,targetHitPoints,barrelIndex);
      }
      finally {
        Model.popObject();
      }
    }

    public function primaryDummyShot(param1:int, param2:int) : void {
      var time:int = param1;
      var barrelIndex:int = param2;
      try {
        Model.object = this.object;
        this.impl.primaryDummyShot(time,barrelIndex);
      }
      finally {
        Model.popObject();
      }
    }

    public function secondaryOpen(param1:int) : void {
      var time:int = param1;
      try {
        Model.object = this.object;
        this.impl.secondaryOpen(time);
      }
      finally {
        Model.popObject();
      }
    }

    public function secondaryHide(param1:int) : void {
      var time:int = param1;
      try {
        Model.object = this.object;
        this.impl.secondaryHide(time);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
