package projects.tanks.client.chat.models.news.showing {
  import alternativa.types.Long;

  public class NewsItemData {
    private var _dateInSeconds:int;
    private var _description:String;
    private var _endDate:int;
    private var _header:String;
    private var _id:Long;
    private var _imageUrl:String;

    public function NewsItemData(param1:int = 0, param2:String = null, param3:int = 0, param4:String = null, param5:Long = null, param6:String = null) {
      super();
      this._dateInSeconds = param1;
      this._description = param2;
      this._endDate = param3;
      this._header = param4;
      this._id = param5;
      this._imageUrl = param6;
    }

    public function get dateInSeconds() : int {
      return this._dateInSeconds;
    }

    public function set dateInSeconds(param1:int) : void {
      this._dateInSeconds = param1;
    }

    public function get description() : String {
      return this._description;
    }

    public function set description(param1:String) : void {
      this._description = param1;
    }

    public function get endDate() : int {
      return this._endDate;
    }

    public function set endDate(param1:int) : void {
      this._endDate = param1;
    }

    public function get header() : String {
      return this._header;
    }

    public function set header(param1:String) : void {
      this._header = param1;
    }

    public function get id() : Long {
      return this._id;
    }

    public function set id(param1:Long) : void {
      this._id = param1;
    }

    public function get imageUrl() : String {
      return this._imageUrl;
    }

    public function set imageUrl(param1:String) : void {
      this._imageUrl = param1;
    }

    public function toString() : String {
      var local1:String = "NewsItemData [";
      local1 += "dateInSeconds = " + this.dateInSeconds + " ";
      local1 += "description = " + this.description + " ";
      local1 += "endDate = " + this.endDate + " ";
      local1 += "header = " + this.header + " ";
      local1 += "id = " + this.id + " ";
      local1 += "imageUrl = " + this.imageUrl + " ";
      return local1 + "]";
    }
  }
}
