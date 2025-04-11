package projects.tanks.client.panel.model.mobilequest.quest {
  import platform.client.fp10.core.resource.types.ImageResource;

  public class MobileQuestReward {
    private var _count:int;
    private var _hint:String;
    private var _name:String;
    private var _preview:ImageResource;
    private var _step:int;

    public function MobileQuestReward(param1:int = 0, param2:String = null, param3:String = null, param4:ImageResource = null, param5:int = 0) {
      super();
      this._count = param1;
      this._hint = param2;
      this._name = param3;
      this._preview = param4;
      this._step = param5;
    }

    public function get count() : int {
      return this._count;
    }

    public function set count(param1:int) : void {
      this._count = param1;
    }

    public function get hint() : String {
      return this._hint;
    }

    public function set hint(param1:String) : void {
      this._hint = param1;
    }

    public function get name() : String {
      return this._name;
    }

    public function set name(param1:String) : void {
      this._name = param1;
    }

    public function get preview() : ImageResource {
      return this._preview;
    }

    public function set preview(param1:ImageResource) : void {
      this._preview = param1;
    }

    public function get step() : int {
      return this._step;
    }

    public function set step(param1:int) : void {
      this._step = param1;
    }

    public function toString() : String {
      var local1:String = "MobileQuestReward [";
      local1 += "count = " + this.count + " ";
      local1 += "hint = " + this.hint + " ";
      local1 += "name = " + this.name + " ";
      local1 += "preview = " + this.preview + " ";
      local1 += "step = " + this.step + " ";
      return local1 + "]";
    }
  }
}
