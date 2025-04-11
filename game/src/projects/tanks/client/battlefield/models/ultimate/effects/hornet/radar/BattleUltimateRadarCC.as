package projects.tanks.client.battlefield.models.ultimate.effects.hornet.radar {
  import alternativa.types.Long;
  import platform.client.fp10.core.resource.types.TextureResource;

  public class BattleUltimateRadarCC {
    private var _blueTankMarker:TextureResource;
    private var _discoveredTanksIds:Vector.<Long>;
    private var _farMarkerDistance:Number;
    private var _nearMarkerDistance:Number;
    private var _neutralTankMarker:TextureResource;
    private var _redTankMarker:TextureResource;

    public function BattleUltimateRadarCC(param1:TextureResource = null, param2:Vector.<Long> = null, param3:Number = 0, param4:Number = 0, param5:TextureResource = null, param6:TextureResource = null) {
      super();
      this._blueTankMarker = param1;
      this._discoveredTanksIds = param2;
      this._farMarkerDistance = param3;
      this._nearMarkerDistance = param4;
      this._neutralTankMarker = param5;
      this._redTankMarker = param6;
    }

    public function get blueTankMarker() : TextureResource {
      return this._blueTankMarker;
    }

    public function set blueTankMarker(param1:TextureResource) : void {
      this._blueTankMarker = param1;
    }

    public function get discoveredTanksIds() : Vector.<Long> {
      return this._discoveredTanksIds;
    }

    public function set discoveredTanksIds(param1:Vector.<Long>) : void {
      this._discoveredTanksIds = param1;
    }

    public function get farMarkerDistance() : Number {
      return this._farMarkerDistance;
    }

    public function set farMarkerDistance(param1:Number) : void {
      this._farMarkerDistance = param1;
    }

    public function get nearMarkerDistance() : Number {
      return this._nearMarkerDistance;
    }

    public function set nearMarkerDistance(param1:Number) : void {
      this._nearMarkerDistance = param1;
    }

    public function get neutralTankMarker() : TextureResource {
      return this._neutralTankMarker;
    }

    public function set neutralTankMarker(param1:TextureResource) : void {
      this._neutralTankMarker = param1;
    }

    public function get redTankMarker() : TextureResource {
      return this._redTankMarker;
    }

    public function set redTankMarker(param1:TextureResource) : void {
      this._redTankMarker = param1;
    }

    public function toString() : String {
      var local1:String = "BattleUltimateRadarCC [";
      local1 += "blueTankMarker = " + this.blueTankMarker + " ";
      local1 += "discoveredTanksIds = " + this.discoveredTanksIds + " ";
      local1 += "farMarkerDistance = " + this.farMarkerDistance + " ";
      local1 += "nearMarkerDistance = " + this.nearMarkerDistance + " ";
      local1 += "neutralTankMarker = " + this.neutralTankMarker + " ";
      local1 += "redTankMarker = " + this.redTankMarker + " ";
      return local1 + "]";
    }
  }
}
