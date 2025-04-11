package projects.tanks.client.panel.model.quest.showing {
  import alternativa.types.Long;
  import platform.client.fp10.core.resource.types.ImageResource;

  public class CommonQuestInfo {
    private var _description:String;
    private var _finishCriteria:int;
    private var _image:ImageResource;
    private var _prizes:Vector.<QuestPrizeInfo>;
    private var _progress:int;
    private var _questId:Long;

    public function CommonQuestInfo(param1:String = null, param2:int = 0, param3:ImageResource = null, param4:Vector.<QuestPrizeInfo> = null, param5:int = 0, param6:Long = null) {
      super();
      this._description = param1;
      this._finishCriteria = param2;
      this._image = param3;
      this._prizes = param4;
      this._progress = param5;
      this._questId = param6;
    }

    public function get description() : String {
      return this._description;
    }

    public function set description(param1:String) : void {
      this._description = param1;
    }

    public function get finishCriteria() : int {
      return this._finishCriteria;
    }

    public function set finishCriteria(param1:int) : void {
      this._finishCriteria = param1;
    }

    public function get image() : ImageResource {
      return this._image;
    }

    public function set image(param1:ImageResource) : void {
      this._image = param1;
    }

    public function get prizes() : Vector.<QuestPrizeInfo> {
      return this._prizes;
    }

    public function set prizes(param1:Vector.<QuestPrizeInfo>) : void {
      this._prizes = param1;
    }

    public function get progress() : int {
      return this._progress;
    }

    public function set progress(param1:int) : void {
      this._progress = param1;
    }

    public function get questId() : Long {
      return this._questId;
    }

    public function set questId(param1:Long) : void {
      this._questId = param1;
    }

    public function toString() : String {
      var local1:String = "CommonQuestInfo [";
      local1 += "description = " + this.description + " ";
      local1 += "finishCriteria = " + this.finishCriteria + " ";
      local1 += "image = " + this.image + " ";
      local1 += "prizes = " + this.prizes + " ";
      local1 += "progress = " + this.progress + " ";
      local1 += "questId = " + this.questId + " ";
      return local1 + "]";
    }
  }
}
