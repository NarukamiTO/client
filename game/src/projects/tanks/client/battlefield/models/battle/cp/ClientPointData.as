package projects.tanks.client.battlefield.models.battle.cp {
  import alternativa.types.Long;
  import projects.tanks.client.battlefield.types.Vector3d;

  public class ClientPointData {
    private var _id:int;
    private var _name:String;
    private var _position:Vector3d;
    private var _score:Number;
    private var _scoreChangeRate:Number;
    private var _state:ControlPointState;
    private var _tankIds:Vector.<Long>;

    public function ClientPointData(param1:int = 0, param2:String = null, param3:Vector3d = null, param4:Number = 0, param5:Number = 0, param6:ControlPointState = null, param7:Vector.<Long> = null) {
      super();
      this._id = param1;
      this._name = param2;
      this._position = param3;
      this._score = param4;
      this._scoreChangeRate = param5;
      this._state = param6;
      this._tankIds = param7;
    }

    public function get id() : int {
      return this._id;
    }

    public function set id(param1:int) : void {
      this._id = param1;
    }

    public function get name() : String {
      return this._name;
    }

    public function set name(param1:String) : void {
      this._name = param1;
    }

    public function get position() : Vector3d {
      return this._position;
    }

    public function set position(param1:Vector3d) : void {
      this._position = param1;
    }

    public function get score() : Number {
      return this._score;
    }

    public function set score(param1:Number) : void {
      this._score = param1;
    }

    public function get scoreChangeRate() : Number {
      return this._scoreChangeRate;
    }

    public function set scoreChangeRate(param1:Number) : void {
      this._scoreChangeRate = param1;
    }

    public function get state() : ControlPointState {
      return this._state;
    }

    public function set state(param1:ControlPointState) : void {
      this._state = param1;
    }

    public function get tankIds() : Vector.<Long> {
      return this._tankIds;
    }

    public function set tankIds(param1:Vector.<Long>) : void {
      this._tankIds = param1;
    }

    public function toString() : String {
      var local1:String = "ClientPointData [";
      local1 += "id = " + this.id + " ";
      local1 += "name = " + this.name + " ";
      local1 += "position = " + this.position + " ";
      local1 += "score = " + this.score + " ";
      local1 += "scoreChangeRate = " + this.scoreChangeRate + " ";
      local1 += "state = " + this.state + " ";
      local1 += "tankIds = " + this.tankIds + " ";
      return local1 + "]";
    }
  }
}
