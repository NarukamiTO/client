package projects.tanks.client.battlefield.models.battle.pointbased.rugby {
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;

  public class RugbyCC {
    private var _ballFallSpeeed:Number;
    private var _ballModel:Tanks3DSResource;
    private var _ballRadius:Number;
    private var _ballSpawnZone:TextureResource;
    private var _bigBlueBallMarker:TextureResource;
    private var _bigGreenBallMarker:TextureResource;
    private var _bigRedBallMarker:TextureResource;
    private var _blueBallMarker:TextureResource;
    private var _blueGoalModel:Tanks3DSResource;
    private var _cordResource:TextureResource;
    private var _greenBallMarker:TextureResource;
    private var _parachuteInnerResource:Tanks3DSResource;
    private var _parachuteResource:Tanks3DSResource;
    private var _redBallMarker:TextureResource;
    private var _redGoalModel:Tanks3DSResource;
    private var _sounds:RugbySoundFX;

    public function RugbyCC(param1:Number = 0, param2:Tanks3DSResource = null, param3:Number = 0, param4:TextureResource = null, param5:TextureResource = null, param6:TextureResource = null, param7:TextureResource = null, param8:TextureResource = null, param9:Tanks3DSResource = null, param10:TextureResource = null, param11:TextureResource = null, param12:Tanks3DSResource = null, param13:Tanks3DSResource = null, param14:TextureResource = null, param15:Tanks3DSResource = null, param16:RugbySoundFX = null) {
      super();
      this._ballFallSpeeed = param1;
      this._ballModel = param2;
      this._ballRadius = param3;
      this._ballSpawnZone = param4;
      this._bigBlueBallMarker = param5;
      this._bigGreenBallMarker = param6;
      this._bigRedBallMarker = param7;
      this._blueBallMarker = param8;
      this._blueGoalModel = param9;
      this._cordResource = param10;
      this._greenBallMarker = param11;
      this._parachuteInnerResource = param12;
      this._parachuteResource = param13;
      this._redBallMarker = param14;
      this._redGoalModel = param15;
      this._sounds = param16;
    }

    public function get ballFallSpeeed() : Number {
      return this._ballFallSpeeed;
    }

    public function set ballFallSpeeed(param1:Number) : void {
      this._ballFallSpeeed = param1;
    }

    public function get ballModel() : Tanks3DSResource {
      return this._ballModel;
    }

    public function set ballModel(param1:Tanks3DSResource) : void {
      this._ballModel = param1;
    }

    public function get ballRadius() : Number {
      return this._ballRadius;
    }

    public function set ballRadius(param1:Number) : void {
      this._ballRadius = param1;
    }

    public function get ballSpawnZone() : TextureResource {
      return this._ballSpawnZone;
    }

    public function set ballSpawnZone(param1:TextureResource) : void {
      this._ballSpawnZone = param1;
    }

    public function get bigBlueBallMarker() : TextureResource {
      return this._bigBlueBallMarker;
    }

    public function set bigBlueBallMarker(param1:TextureResource) : void {
      this._bigBlueBallMarker = param1;
    }

    public function get bigGreenBallMarker() : TextureResource {
      return this._bigGreenBallMarker;
    }

    public function set bigGreenBallMarker(param1:TextureResource) : void {
      this._bigGreenBallMarker = param1;
    }

    public function get bigRedBallMarker() : TextureResource {
      return this._bigRedBallMarker;
    }

    public function set bigRedBallMarker(param1:TextureResource) : void {
      this._bigRedBallMarker = param1;
    }

    public function get blueBallMarker() : TextureResource {
      return this._blueBallMarker;
    }

    public function set blueBallMarker(param1:TextureResource) : void {
      this._blueBallMarker = param1;
    }

    public function get blueGoalModel() : Tanks3DSResource {
      return this._blueGoalModel;
    }

    public function set blueGoalModel(param1:Tanks3DSResource) : void {
      this._blueGoalModel = param1;
    }

    public function get cordResource() : TextureResource {
      return this._cordResource;
    }

    public function set cordResource(param1:TextureResource) : void {
      this._cordResource = param1;
    }

    public function get greenBallMarker() : TextureResource {
      return this._greenBallMarker;
    }

    public function set greenBallMarker(param1:TextureResource) : void {
      this._greenBallMarker = param1;
    }

    public function get parachuteInnerResource() : Tanks3DSResource {
      return this._parachuteInnerResource;
    }

    public function set parachuteInnerResource(param1:Tanks3DSResource) : void {
      this._parachuteInnerResource = param1;
    }

    public function get parachuteResource() : Tanks3DSResource {
      return this._parachuteResource;
    }

    public function set parachuteResource(param1:Tanks3DSResource) : void {
      this._parachuteResource = param1;
    }

    public function get redBallMarker() : TextureResource {
      return this._redBallMarker;
    }

    public function set redBallMarker(param1:TextureResource) : void {
      this._redBallMarker = param1;
    }

    public function get redGoalModel() : Tanks3DSResource {
      return this._redGoalModel;
    }

    public function set redGoalModel(param1:Tanks3DSResource) : void {
      this._redGoalModel = param1;
    }

    public function get sounds() : RugbySoundFX {
      return this._sounds;
    }

    public function set sounds(param1:RugbySoundFX) : void {
      this._sounds = param1;
    }

    public function toString() : String {
      var local1:String = "RugbyCC [";
      local1 += "ballFallSpeeed = " + this.ballFallSpeeed + " ";
      local1 += "ballModel = " + this.ballModel + " ";
      local1 += "ballRadius = " + this.ballRadius + " ";
      local1 += "ballSpawnZone = " + this.ballSpawnZone + " ";
      local1 += "bigBlueBallMarker = " + this.bigBlueBallMarker + " ";
      local1 += "bigGreenBallMarker = " + this.bigGreenBallMarker + " ";
      local1 += "bigRedBallMarker = " + this.bigRedBallMarker + " ";
      local1 += "blueBallMarker = " + this.blueBallMarker + " ";
      local1 += "blueGoalModel = " + this.blueGoalModel + " ";
      local1 += "cordResource = " + this.cordResource + " ";
      local1 += "greenBallMarker = " + this.greenBallMarker + " ";
      local1 += "parachuteInnerResource = " + this.parachuteInnerResource + " ";
      local1 += "parachuteResource = " + this.parachuteResource + " ";
      local1 += "redBallMarker = " + this.redBallMarker + " ";
      local1 += "redGoalModel = " + this.redGoalModel + " ";
      local1 += "sounds = " + this.sounds + " ";
      return local1 + "]";
    }
  }
}
