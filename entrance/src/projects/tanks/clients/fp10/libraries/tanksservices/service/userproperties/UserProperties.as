package projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties {
  import alternativa.types.Long;

  public class UserProperties {
    private var _userId:Long;
    private var _userName:String;
    private var _score:int;
    private var _rank:int;

    public function UserProperties(param1:Long, param2:String, param3:int, param4:int) {
      super();
      this._userId = param1;
      this._userName = param2;
      this._score = param3;
      this._rank = param4;
    }

    public function get userId() : Long {
      return this._userId;
    }

    public function set userId(param1:Long) : void {
      this._userId = param1;
    }

    public function get userName() : String {
      return this._userName;
    }

    public function set userName(param1:String) : void {
      this._userName = param1;
    }

    public function get score() : int {
      return this._score;
    }

    public function set score(param1:int) : void {
      this._score = param1;
    }

    public function get rank() : int {
      return this._rank;
    }

    public function set rank(param1:int) : void {
      this._rank = param1;
    }
  }
}
