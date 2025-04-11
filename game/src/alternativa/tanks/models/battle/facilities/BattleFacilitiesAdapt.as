package alternativa.tanks.models.battle.facilities {
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.objects.tank.Tank;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class BattleFacilitiesAdapt implements BattleFacilities {
    private var object:IGameObject;
    private var impl:BattleFacilities;

    public function BattleFacilitiesAdapt(param1:IGameObject, param2:BattleFacilities) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function register(param1:IGameObject) : void {
      var facilityObject:IGameObject = param1;
      try {
        Model.object = this.object;
        this.impl.register(facilityObject);
      }
      finally {
        Model.popObject();
      }
    }

    public function unregister(param1:IGameObject) : void {
      var facilityObject:IGameObject = param1;
      try {
        Model.object = this.object;
        this.impl.unregister(facilityObject);
      }
      finally {
        Model.popObject();
      }
    }

    public function addCheckZone(param1:IGameObject, param2:Vector3, param3:Number, param4:Boolean) : void {
      var facilityObject:IGameObject = param1;
      var position:Vector3 = param2;
      var checkRadius:Number = param3;
      var checkRaycast:Boolean = param4;
      try {
        Model.object = this.object;
        this.impl.addCheckZone(facilityObject,position,checkRadius,checkRaycast);
      }
      finally {
        Model.popObject();
      }
    }

    public function addDynamicCheckZone(param1:IGameObject, param2:Tank, param3:Number, param4:Boolean) : void {
      var facilityObject:IGameObject = param1;
      var tank:Tank = param2;
      var checkRadius:Number = param3;
      var checkRaycast:Boolean = param4;
      try {
        Model.object = this.object;
        this.impl.addDynamicCheckZone(facilityObject,tank,checkRadius,checkRaycast);
      }
      finally {
        Model.popObject();
      }
    }

    public function removeCheckZone(param1:IGameObject) : void {
      var facilityObject:IGameObject = param1;
      try {
        Model.object = this.object;
        this.impl.removeCheckZone(facilityObject);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
