package alternativa.tanks.models.battle.facilities {
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.objects.tank.Tank;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class BattleFacilitiesEvents implements BattleFacilities {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function BattleFacilitiesEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function register(param1:IGameObject) : void {
      var i:int = 0;
      var m:BattleFacilities = null;
      var facilityObject:IGameObject = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = BattleFacilities(this.impl[i]);
          m.register(facilityObject);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function unregister(param1:IGameObject) : void {
      var i:int = 0;
      var m:BattleFacilities = null;
      var facilityObject:IGameObject = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = BattleFacilities(this.impl[i]);
          m.unregister(facilityObject);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function addCheckZone(param1:IGameObject, param2:Vector3, param3:Number, param4:Boolean) : void {
      var i:int = 0;
      var m:BattleFacilities = null;
      var facilityObject:IGameObject = param1;
      var position:Vector3 = param2;
      var checkRadius:Number = param3;
      var checkRaycast:Boolean = param4;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = BattleFacilities(this.impl[i]);
          m.addCheckZone(facilityObject,position,checkRadius,checkRaycast);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function addDynamicCheckZone(param1:IGameObject, param2:Tank, param3:Number, param4:Boolean) : void {
      var i:int = 0;
      var m:BattleFacilities = null;
      var facilityObject:IGameObject = param1;
      var tank:Tank = param2;
      var checkRadius:Number = param3;
      var checkRaycast:Boolean = param4;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = BattleFacilities(this.impl[i]);
          m.addDynamicCheckZone(facilityObject,tank,checkRadius,checkRaycast);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function removeCheckZone(param1:IGameObject) : void {
      var i:int = 0;
      var m:BattleFacilities = null;
      var facilityObject:IGameObject = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = BattleFacilities(this.impl[i]);
          m.removeCheckZone(facilityObject);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
