package projects.tanks.client.entrance.model.entrance.telegram {
  public class TelegramEntranceModelCC {
    private var _botName:String;

    public function TelegramEntranceModelCC(param1:String = null) {
      super();
      this._botName = param1;
    }

    public function get botName() : String {
      return this._botName;
    }

    public function set botName(param1:String) : void {
      this._botName = param1;
    }

    public function toString() : String {
      var local1:String = "TelegramEntranceModelCC [";
      local1 += "botName = " + this.botName + " ";
      return local1 + "]";
    }
  }
}
