package projects.tanks.client.battlefield.models.battle.battlefield.facilities.facillity {
  import alternativa.types.Long;
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.client.battlefield.types.Vector3d;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;

  public class CommonFacilityCC {
    private var _facilityObject:Tanks3DSResource;
    private var _facilityTeam:BattleTeam;
    private var _facilityTexture:TextureResource;
    private var _localCenter:Vector3d;
    private var _ownerId:Long;
    private var _position:Vector3d;
    private var _rotation:Vector3d;
    private var _useLight:Boolean;
    private var _useShadows:Boolean;

    public function CommonFacilityCC(param1:Tanks3DSResource = null, param2:BattleTeam = null, param3:TextureResource = null, param4:Vector3d = null, param5:Long = null, param6:Vector3d = null, param7:Vector3d = null, param8:Boolean = false, param9:Boolean = false) {
      super();
      this._facilityObject = param1;
      this._facilityTeam = param2;
      this._facilityTexture = param3;
      this._localCenter = param4;
      this._ownerId = param5;
      this._position = param6;
      this._rotation = param7;
      this._useLight = param8;
      this._useShadows = param9;
    }

    public function get facilityObject() : Tanks3DSResource {
      return this._facilityObject;
    }

    public function set facilityObject(param1:Tanks3DSResource) : void {
      this._facilityObject = param1;
    }

    public function get facilityTeam() : BattleTeam {
      return this._facilityTeam;
    }

    public function set facilityTeam(param1:BattleTeam) : void {
      this._facilityTeam = param1;
    }

    public function get facilityTexture() : TextureResource {
      return this._facilityTexture;
    }

    public function set facilityTexture(param1:TextureResource) : void {
      this._facilityTexture = param1;
    }

    public function get localCenter() : Vector3d {
      return this._localCenter;
    }

    public function set localCenter(param1:Vector3d) : void {
      this._localCenter = param1;
    }

    public function get ownerId() : Long {
      return this._ownerId;
    }

    public function set ownerId(param1:Long) : void {
      this._ownerId = param1;
    }

    public function get position() : Vector3d {
      return this._position;
    }

    public function set position(param1:Vector3d) : void {
      this._position = param1;
    }

    public function get rotation() : Vector3d {
      return this._rotation;
    }

    public function set rotation(param1:Vector3d) : void {
      this._rotation = param1;
    }

    public function get useLight() : Boolean {
      return this._useLight;
    }

    public function set useLight(param1:Boolean) : void {
      this._useLight = param1;
    }

    public function get useShadows() : Boolean {
      return this._useShadows;
    }

    public function set useShadows(param1:Boolean) : void {
      this._useShadows = param1;
    }

    public function toString() : String {
      var local1:String = "CommonFacilityCC [";
      local1 += "facilityObject = " + this.facilityObject + " ";
      local1 += "facilityTeam = " + this.facilityTeam + " ";
      local1 += "facilityTexture = " + this.facilityTexture + " ";
      local1 += "localCenter = " + this.localCenter + " ";
      local1 += "ownerId = " + this.ownerId + " ";
      local1 += "position = " + this.position + " ";
      local1 += "rotation = " + this.rotation + " ";
      local1 += "useLight = " + this.useLight + " ";
      local1 += "useShadows = " + this.useShadows + " ";
      return local1 + "]";
    }
  }
}
