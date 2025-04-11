package projects.tanks.client.battlefield.models.battle.cp {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.EnumCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;

  public class ControlPointsModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:ControlPointsModelServer;

    private var client:IControlPointsModelBase = IControlPointsModelBase(this);
    private var modelId:Long = Long.getLong(375259874,-2064506790);
    private var _pointCaptureStartedId:Long = Long.getLong(113336798,-635616124);
    private var _pointCaptureStarted_teamCodec:ICodec;
    private var _pointCaptureStoppedId:Long = Long.getLong(113336798,-648481992);
    private var _pointCaptureStopped_teamCodec:ICodec;
    private var _setPointProgressId:Long = Long.getLong(1656540814,-150441162);
    private var _setPointProgress_pointIdCodec:ICodec;
    private var _setPointProgress_progressCodec:ICodec;
    private var _setPointProgress_progressSpeedCodec:ICodec;
    private var _setPointStateId:Long = Long.getLong(93222359,396117780);
    private var _setPointState_pointIdCodec:ICodec;
    private var _setPointState_stateCodec:ICodec;
    private var _stopBattleId:Long = Long.getLong(1109525934,-1995327689);
    private var _tankEnteredPointZoneId:Long = Long.getLong(1209531510,1444573534);
    private var _tankEnteredPointZone_pointIdCodec:ICodec;
    private var _tankEnteredPointZone_tankIdCodec:ICodec;
    private var _tankLeftPointZoneId:Long = Long.getLong(1944648201,859419652);
    private var _tankLeftPointZone_pointIdCodec:ICodec;
    private var _tankLeftPointZone_tankIdCodec:ICodec;

    public function ControlPointsModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new ControlPointsModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(ControlPointsCC,false)));
      this._pointCaptureStarted_teamCodec = this._protocol.getCodec(new EnumCodecInfo(BattleTeam,false));
      this._pointCaptureStopped_teamCodec = this._protocol.getCodec(new EnumCodecInfo(BattleTeam,false));
      this._setPointProgress_pointIdCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._setPointProgress_progressCodec = this._protocol.getCodec(new TypeCodecInfo(Float,false));
      this._setPointProgress_progressSpeedCodec = this._protocol.getCodec(new TypeCodecInfo(Float,false));
      this._setPointState_pointIdCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._setPointState_stateCodec = this._protocol.getCodec(new EnumCodecInfo(ControlPointState,false));
      this._tankEnteredPointZone_pointIdCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._tankEnteredPointZone_tankIdCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
      this._tankLeftPointZone_pointIdCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._tankLeftPointZone_tankIdCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
    }

    protected function getInitParam() : ControlPointsCC {
      return ControlPointsCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._pointCaptureStartedId:
          this.client.pointCaptureStarted(BattleTeam(this._pointCaptureStarted_teamCodec.decode(param2)));
          break;
        case this._pointCaptureStoppedId:
          this.client.pointCaptureStopped(BattleTeam(this._pointCaptureStopped_teamCodec.decode(param2)));
          break;
        case this._setPointProgressId:
          this.client.setPointProgress(int(this._setPointProgress_pointIdCodec.decode(param2)),Number(this._setPointProgress_progressCodec.decode(param2)),Number(this._setPointProgress_progressSpeedCodec.decode(param2)));
          break;
        case this._setPointStateId:
          this.client.setPointState(int(this._setPointState_pointIdCodec.decode(param2)),ControlPointState(this._setPointState_stateCodec.decode(param2)));
          break;
        case this._stopBattleId:
          this.client.stopBattle();
          break;
        case this._tankEnteredPointZoneId:
          this.client.tankEnteredPointZone(int(this._tankEnteredPointZone_pointIdCodec.decode(param2)),Long(this._tankEnteredPointZone_tankIdCodec.decode(param2)));
          break;
        case this._tankLeftPointZoneId:
          this.client.tankLeftPointZone(int(this._tankLeftPointZone_pointIdCodec.decode(param2)),Long(this._tankLeftPointZone_tankIdCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
