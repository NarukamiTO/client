package projects.tanks.client.panel.model.quest.common.specification {
  public class QuestLevel {
    public static const EASY:QuestLevel = new QuestLevel(0,"EASY");
    public static const NORMAL:QuestLevel = new QuestLevel(1,"NORMAL");
    public static const HARD:QuestLevel = new QuestLevel(2,"HARD");

    private var _value:int;
    private var _name:String;

    public function QuestLevel(param1:int, param2:String) {
      super();
      this._value = param1;
      this._name = param2;
    }

    public static function get values() : Vector.<QuestLevel> {
      var local1:Vector.<QuestLevel> = new Vector.<QuestLevel>();
      local1.push(EASY);
      local1.push(NORMAL);
      local1.push(HARD);
      return local1;
    }

    public function toString() : String {
      return "QuestLevel [" + this._name + "]";
    }

    public function get value() : int {
      return this._value;
    }

    public function get name() : String {
      return this._name;
    }
  }
}
