package projects.tanks.client.battlefield.models.ultimate.effects.titan.generator {
  import alternativa.types.Long;
  import platform.client.fp10.core.resource.types.MultiframeTextureResource;
  import platform.client.fp10.core.resource.types.SoundResource;
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;

  public class TitanUltimateGeneratorCC {
    private var _blueCell:TextureResource;
    private var _blueRay:TextureResource;
    private var _blueRayTip:TextureResource;
    private var _blueSimpleShield:TextureResource;
    private var _blueSphere:MultiframeTextureResource;
    private var _cell:TextureResource;
    private var _coveredTanksIds:Vector.<Long>;
    private var _generatorActivationSound:SoundResource;
    private var _generatorDeactivationSound:SoundResource;
    private var _generatorLoopSound:SoundResource;
    private var _generatorTeam:BattleTeam;
    private var _geosphere:Tanks3DSResource;
    private var _ray:TextureResource;
    private var _rayTip:TextureResource;
    private var _redCell:TextureResource;
    private var _redRay:TextureResource;
    private var _redRayTip:TextureResource;
    private var _redSimpleShield:TextureResource;
    private var _redSphere:MultiframeTextureResource;
    private var _shieldOffSound:SoundResource;
    private var _shieldOnSound:SoundResource;
    private var _simpleShield:TextureResource;
    private var _sphere:MultiframeTextureResource;
    private var _zoneRadiusFakeReducing:Number;

    public function TitanUltimateGeneratorCC(param1:TextureResource = null, param2:TextureResource = null, param3:TextureResource = null, param4:TextureResource = null, param5:MultiframeTextureResource = null, param6:TextureResource = null, param7:Vector.<Long> = null, param8:SoundResource = null, param9:SoundResource = null, param10:SoundResource = null, param11:BattleTeam = null, param12:Tanks3DSResource = null, param13:TextureResource = null, param14:TextureResource = null, param15:TextureResource = null, param16:TextureResource = null, param17:TextureResource = null, param18:TextureResource = null, param19:MultiframeTextureResource = null, param20:SoundResource = null, param21:SoundResource = null, param22:TextureResource = null, param23:MultiframeTextureResource = null, param24:Number = 0) {
      super();
      this._blueCell = param1;
      this._blueRay = param2;
      this._blueRayTip = param3;
      this._blueSimpleShield = param4;
      this._blueSphere = param5;
      this._cell = param6;
      this._coveredTanksIds = param7;
      this._generatorActivationSound = param8;
      this._generatorDeactivationSound = param9;
      this._generatorLoopSound = param10;
      this._generatorTeam = param11;
      this._geosphere = param12;
      this._ray = param13;
      this._rayTip = param14;
      this._redCell = param15;
      this._redRay = param16;
      this._redRayTip = param17;
      this._redSimpleShield = param18;
      this._redSphere = param19;
      this._shieldOffSound = param20;
      this._shieldOnSound = param21;
      this._simpleShield = param22;
      this._sphere = param23;
      this._zoneRadiusFakeReducing = param24;
    }

    public function get blueCell() : TextureResource {
      return this._blueCell;
    }

    public function set blueCell(param1:TextureResource) : void {
      this._blueCell = param1;
    }

    public function get blueRay() : TextureResource {
      return this._blueRay;
    }

    public function set blueRay(param1:TextureResource) : void {
      this._blueRay = param1;
    }

    public function get blueRayTip() : TextureResource {
      return this._blueRayTip;
    }

    public function set blueRayTip(param1:TextureResource) : void {
      this._blueRayTip = param1;
    }

    public function get blueSimpleShield() : TextureResource {
      return this._blueSimpleShield;
    }

    public function set blueSimpleShield(param1:TextureResource) : void {
      this._blueSimpleShield = param1;
    }

    public function get blueSphere() : MultiframeTextureResource {
      return this._blueSphere;
    }

    public function set blueSphere(param1:MultiframeTextureResource) : void {
      this._blueSphere = param1;
    }

    public function get cell() : TextureResource {
      return this._cell;
    }

    public function set cell(param1:TextureResource) : void {
      this._cell = param1;
    }

    public function get coveredTanksIds() : Vector.<Long> {
      return this._coveredTanksIds;
    }

    public function set coveredTanksIds(param1:Vector.<Long>) : void {
      this._coveredTanksIds = param1;
    }

    public function get generatorActivationSound() : SoundResource {
      return this._generatorActivationSound;
    }

    public function set generatorActivationSound(param1:SoundResource) : void {
      this._generatorActivationSound = param1;
    }

    public function get generatorDeactivationSound() : SoundResource {
      return this._generatorDeactivationSound;
    }

    public function set generatorDeactivationSound(param1:SoundResource) : void {
      this._generatorDeactivationSound = param1;
    }

    public function get generatorLoopSound() : SoundResource {
      return this._generatorLoopSound;
    }

    public function set generatorLoopSound(param1:SoundResource) : void {
      this._generatorLoopSound = param1;
    }

    public function get generatorTeam() : BattleTeam {
      return this._generatorTeam;
    }

    public function set generatorTeam(param1:BattleTeam) : void {
      this._generatorTeam = param1;
    }

    public function get geosphere() : Tanks3DSResource {
      return this._geosphere;
    }

    public function set geosphere(param1:Tanks3DSResource) : void {
      this._geosphere = param1;
    }

    public function get ray() : TextureResource {
      return this._ray;
    }

    public function set ray(param1:TextureResource) : void {
      this._ray = param1;
    }

    public function get rayTip() : TextureResource {
      return this._rayTip;
    }

    public function set rayTip(param1:TextureResource) : void {
      this._rayTip = param1;
    }

    public function get redCell() : TextureResource {
      return this._redCell;
    }

    public function set redCell(param1:TextureResource) : void {
      this._redCell = param1;
    }

    public function get redRay() : TextureResource {
      return this._redRay;
    }

    public function set redRay(param1:TextureResource) : void {
      this._redRay = param1;
    }

    public function get redRayTip() : TextureResource {
      return this._redRayTip;
    }

    public function set redRayTip(param1:TextureResource) : void {
      this._redRayTip = param1;
    }

    public function get redSimpleShield() : TextureResource {
      return this._redSimpleShield;
    }

    public function set redSimpleShield(param1:TextureResource) : void {
      this._redSimpleShield = param1;
    }

    public function get redSphere() : MultiframeTextureResource {
      return this._redSphere;
    }

    public function set redSphere(param1:MultiframeTextureResource) : void {
      this._redSphere = param1;
    }

    public function get shieldOffSound() : SoundResource {
      return this._shieldOffSound;
    }

    public function set shieldOffSound(param1:SoundResource) : void {
      this._shieldOffSound = param1;
    }

    public function get shieldOnSound() : SoundResource {
      return this._shieldOnSound;
    }

    public function set shieldOnSound(param1:SoundResource) : void {
      this._shieldOnSound = param1;
    }

    public function get simpleShield() : TextureResource {
      return this._simpleShield;
    }

    public function set simpleShield(param1:TextureResource) : void {
      this._simpleShield = param1;
    }

    public function get sphere() : MultiframeTextureResource {
      return this._sphere;
    }

    public function set sphere(param1:MultiframeTextureResource) : void {
      this._sphere = param1;
    }

    public function get zoneRadiusFakeReducing() : Number {
      return this._zoneRadiusFakeReducing;
    }

    public function set zoneRadiusFakeReducing(param1:Number) : void {
      this._zoneRadiusFakeReducing = param1;
    }

    public function toString() : String {
      var local1:String = "TitanUltimateGeneratorCC [";
      local1 += "blueCell = " + this.blueCell + " ";
      local1 += "blueRay = " + this.blueRay + " ";
      local1 += "blueRayTip = " + this.blueRayTip + " ";
      local1 += "blueSimpleShield = " + this.blueSimpleShield + " ";
      local1 += "blueSphere = " + this.blueSphere + " ";
      local1 += "cell = " + this.cell + " ";
      local1 += "coveredTanksIds = " + this.coveredTanksIds + " ";
      local1 += "generatorActivationSound = " + this.generatorActivationSound + " ";
      local1 += "generatorDeactivationSound = " + this.generatorDeactivationSound + " ";
      local1 += "generatorLoopSound = " + this.generatorLoopSound + " ";
      local1 += "generatorTeam = " + this.generatorTeam + " ";
      local1 += "geosphere = " + this.geosphere + " ";
      local1 += "ray = " + this.ray + " ";
      local1 += "rayTip = " + this.rayTip + " ";
      local1 += "redCell = " + this.redCell + " ";
      local1 += "redRay = " + this.redRay + " ";
      local1 += "redRayTip = " + this.redRayTip + " ";
      local1 += "redSimpleShield = " + this.redSimpleShield + " ";
      local1 += "redSphere = " + this.redSphere + " ";
      local1 += "shieldOffSound = " + this.shieldOffSound + " ";
      local1 += "shieldOnSound = " + this.shieldOnSound + " ";
      local1 += "simpleShield = " + this.simpleShield + " ";
      local1 += "sphere = " + this.sphere + " ";
      local1 += "zoneRadiusFakeReducing = " + this.zoneRadiusFakeReducing + " ";
      return local1 + "]";
    }
  }
}
