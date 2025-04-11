package projects.tanks.client.battlefield.models.battle.pointbased {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.battle.pointbased.flag.ClientFlagFlyingData;
  import projects.tanks.client.battlefield.types.Vector3d;

  public class PointBasedBattleModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:PointBasedBattleModelServer;

    private var client:IPointBasedBattleModelBase = IPointBasedBattleModelBase(this);
    private var modelId:Long = Long.getLong(705910854,-1245375245);
    private var _dropFlagId:Long = Long.getLong(906489116,-114905795);
    private var _dropFlag_flagIdCodec:ICodec;
    private var _dropFlag_positionCodec:ICodec;
    private var _dropFlyingFlagId:Long = Long.getLong(1984730396,1294099278);
    private var _dropFlyingFlag_idCodec:ICodec;
    private var _dropFlyingFlag_pointIdCodec:ICodec;
    private var _dropFlyingFlag_fallingDataCodec:ICodec;
    private var _exileFlagId:Long = Long.getLong(1963608681,-1790478509);
    private var _exileFlag_idCodec:ICodec;
    private var _flagDeliveredId:Long = Long.getLong(12556924,688130128);
    private var _flagDelivered_flagIdCodec:ICodec;
    private var _flagDelivered_baseIdCodec:ICodec;
    private var _flagDelivered_delivererTankIdCodec:ICodec;
    private var _flagTakenId:Long = Long.getLong(1963608801,-1704957453);
    private var _flagTaken_flagIdCodec:ICodec;
    private var _flagTaken_tankIdCodec:ICodec;
    private var _returnFlagToBaseId:Long = Long.getLong(549926507,-1447996528);
    private var _returnFlagToBase_flagIdCodec:ICodec;
    private var _returnFlagToBase_tankCodec:ICodec;
    private var _throwFlyingFlagId:Long = Long.getLong(476671394,1885696345);
    private var _throwFlyingFlag_idCodec:ICodec;
    private var _throwFlyingFlag_clientFlagFlyingDataCodec:ICodec;

    public function PointBasedBattleModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new PointBasedBattleModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(PointBasedBattleCC,false)));
      this._dropFlag_flagIdCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._dropFlag_positionCodec = this._protocol.getCodec(new TypeCodecInfo(Vector3d,false));
      this._dropFlyingFlag_idCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._dropFlyingFlag_pointIdCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._dropFlyingFlag_fallingDataCodec = this._protocol.getCodec(new TypeCodecInfo(ClientFlagFlyingData,false));
      this._exileFlag_idCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._flagDelivered_flagIdCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._flagDelivered_baseIdCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._flagDelivered_delivererTankIdCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
      this._flagTaken_flagIdCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._flagTaken_tankIdCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
      this._returnFlagToBase_flagIdCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._returnFlagToBase_tankCodec = this._protocol.getCodec(new TypeCodecInfo(IGameObject,true));
      this._throwFlyingFlag_idCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._throwFlyingFlag_clientFlagFlyingDataCodec = this._protocol.getCodec(new TypeCodecInfo(ClientFlagFlyingData,false));
    }

    protected function getInitParam() : PointBasedBattleCC {
      return PointBasedBattleCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._dropFlagId:
          this.client.dropFlag(int(this._dropFlag_flagIdCodec.decode(param2)),Vector3d(this._dropFlag_positionCodec.decode(param2)));
          break;
        case this._dropFlyingFlagId:
          this.client.dropFlyingFlag(int(this._dropFlyingFlag_idCodec.decode(param2)),int(this._dropFlyingFlag_pointIdCodec.decode(param2)),ClientFlagFlyingData(this._dropFlyingFlag_fallingDataCodec.decode(param2)));
          break;
        case this._exileFlagId:
          this.client.exileFlag(int(this._exileFlag_idCodec.decode(param2)));
          break;
        case this._flagDeliveredId:
          this.client.flagDelivered(int(this._flagDelivered_flagIdCodec.decode(param2)),int(this._flagDelivered_baseIdCodec.decode(param2)),Long(this._flagDelivered_delivererTankIdCodec.decode(param2)));
          break;
        case this._flagTakenId:
          this.client.flagTaken(int(this._flagTaken_flagIdCodec.decode(param2)),Long(this._flagTaken_tankIdCodec.decode(param2)));
          break;
        case this._returnFlagToBaseId:
          this.client.returnFlagToBase(int(this._returnFlagToBase_flagIdCodec.decode(param2)),IGameObject(this._returnFlagToBase_tankCodec.decode(param2)));
          break;
        case this._throwFlyingFlagId:
          this.client.throwFlyingFlag(int(this._throwFlyingFlag_idCodec.decode(param2)),ClientFlagFlyingData(this._throwFlyingFlag_clientFlagFlyingDataCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
