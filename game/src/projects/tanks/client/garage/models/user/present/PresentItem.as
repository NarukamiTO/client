package projects.tanks.client.garage.models.user.present {
  import alternativa.types.Long;
  import platform.client.fp10.core.type.IGameObject;

  public class PresentItem {
    private var _banned:Boolean;
    private var _date:Date;
    private var _id:Long;
    private var _present:IGameObject;
    private var _presenter:Long;
    private var _text:String;

    public function PresentItem(param1:Boolean = false, param2:Date = null, param3:Long = null, param4:IGameObject = null, param5:Long = null, param6:String = null) {
      super();
      this._banned = param1;
      this._date = param2;
      this._id = param3;
      this._present = param4;
      this._presenter = param5;
      this._text = param6;
    }

    public function get banned() : Boolean {
      return this._banned;
    }

    public function set banned(param1:Boolean) : void {
      this._banned = param1;
    }

    public function get date() : Date {
      return this._date;
    }

    public function set date(param1:Date) : void {
      this._date = param1;
    }

    public function get id() : Long {
      return this._id;
    }

    public function set id(param1:Long) : void {
      this._id = param1;
    }

    public function get present() : IGameObject {
      return this._present;
    }

    public function set present(param1:IGameObject) : void {
      this._present = param1;
    }

    public function get presenter() : Long {
      return this._presenter;
    }

    public function set presenter(param1:Long) : void {
      this._presenter = param1;
    }

    public function get text() : String {
      return this._text;
    }

    public function set text(param1:String) : void {
      this._text = param1;
    }

    public function toString() : String {
      var local1:String = "PresentItem [";
      local1 += "banned = " + this.banned + " ";
      local1 += "date = " + this.date + " ";
      local1 += "id = " + this.id + " ";
      local1 += "present = " + this.present + " ";
      local1 += "presenter = " + this.presenter + " ";
      local1 += "text = " + this.text + " ";
      return local1 + "]";
    }
  }
}
