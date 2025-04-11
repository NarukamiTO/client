package alternativa.tanks.model.item.rename {
  import flash.events.Event;

  public class RenameEvent extends Event {
    public static const RENAME_EVENT:String = "REANAME_EVENT";

    private var nickname:String;

    public function RenameEvent(param1:String) {
      super(RENAME_EVENT);
      this.nickname = param1;
    }

    public function getNickname() : String {
      return this.nickname;
    }
  }
}
