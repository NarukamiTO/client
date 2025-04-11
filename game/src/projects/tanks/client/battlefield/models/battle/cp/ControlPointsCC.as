package projects.tanks.client.battlefield.models.battle.cp {
  import projects.tanks.client.battlefield.models.battle.cp.resources.DominationResources;
  import projects.tanks.client.battlefield.models.battle.cp.resources.DominationSounds;

  public class ControlPointsCC {
    private var _keypointTriggerRadius:Number;
    private var _keypointVisorHeight:Number;
    private var _minesRestrictionRadius:Number;
    private var _points:Vector.<ClientPointData>;
    private var _resources:DominationResources;
    private var _sounds:DominationSounds;

    public function ControlPointsCC(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Vector.<ClientPointData> = null, param5:DominationResources = null, param6:DominationSounds = null) {
      super();
      this._keypointTriggerRadius = param1;
      this._keypointVisorHeight = param2;
      this._minesRestrictionRadius = param3;
      this._points = param4;
      this._resources = param5;
      this._sounds = param6;
    }

    public function get keypointTriggerRadius() : Number {
      return this._keypointTriggerRadius;
    }

    public function set keypointTriggerRadius(param1:Number) : void {
      this._keypointTriggerRadius = param1;
    }

    public function get keypointVisorHeight() : Number {
      return this._keypointVisorHeight;
    }

    public function set keypointVisorHeight(param1:Number) : void {
      this._keypointVisorHeight = param1;
    }

    public function get minesRestrictionRadius() : Number {
      return this._minesRestrictionRadius;
    }

    public function set minesRestrictionRadius(param1:Number) : void {
      this._minesRestrictionRadius = param1;
    }

    public function get points() : Vector.<ClientPointData> {
      return this._points;
    }

    public function set points(param1:Vector.<ClientPointData>) : void {
      this._points = param1;
    }

    public function get resources() : DominationResources {
      return this._resources;
    }

    public function set resources(param1:DominationResources) : void {
      this._resources = param1;
    }

    public function get sounds() : DominationSounds {
      return this._sounds;
    }

    public function set sounds(param1:DominationSounds) : void {
      this._sounds = param1;
    }

    public function toString() : String {
      var local1:String = "ControlPointsCC [";
      local1 += "keypointTriggerRadius = " + this.keypointTriggerRadius + " ";
      local1 += "keypointVisorHeight = " + this.keypointVisorHeight + " ";
      local1 += "minesRestrictionRadius = " + this.minesRestrictionRadius + " ";
      local1 += "points = " + this.points + " ";
      local1 += "resources = " + this.resources + " ";
      local1 += "sounds = " + this.sounds + " ";
      return local1 + "]";
    }
  }
}
