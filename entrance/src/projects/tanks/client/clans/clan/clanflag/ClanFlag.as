package projects.tanks.client.clans.clan.clanflag {
  import alternativa.types.Long;
  import platform.client.fp10.core.resource.types.ImageResource;

  public class ClanFlag {
    private var _flagImage:ImageResource;
    private var _id:Long;
    private var _name:String;

    public function ClanFlag(param1:ImageResource = null, param2:Long = null, param3:String = null) {
      super();
      this._flagImage = param1;
      this._id = param2;
      this._name = param3;
    }

    public function get flagImage() : ImageResource {
      return this._flagImage;
    }

    public function set flagImage(param1:ImageResource) : void {
      this._flagImage = param1;
    }

    public function get id() : Long {
      return this._id;
    }

    public function set id(param1:Long) : void {
      this._id = param1;
    }

    public function get name() : String {
      return this._name;
    }

    public function set name(param1:String) : void {
      this._name = param1;
    }

    public function toString() : String {
      var local1:String = "ClanFlag [";
      local1 += "flagImage = " + this.flagImage + " ";
      local1 += "id = " + this.id + " ";
      local1 += "name = " + this.name + " ";
      return local1 + "]";
    }
  }
}
