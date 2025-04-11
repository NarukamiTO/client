package projects.tanks.client.battlefield.models.battle.battlefield.debug {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import projects.tanks.client.battlefield.types.Vector3d;

  public class BattleDebugModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:BattleDebugModelServer;

    private var client:IBattleDebugModelBase = IBattleDebugModelBase(this);
    private var modelId:Long = Long.getLong(779331045,19368635);
    private var _addFrameId:Long = Long.getLong(964810564,576305510);
    private var _addFrame_sizeCodec:ICodec;
    private var _addFrame_colorCodec:ICodec;
    private var _addFrame_debugFrameCodec:ICodec;
    private var _addFrame_timeoutCodec:ICodec;
    private var _addGizmoId:Long = Long.getLong(964810564,576984947);
    private var _addGizmo_sizeCodec:ICodec;
    private var _addGizmo_colorCodec:ICodec;
    private var _addGizmo_pointCodec:ICodec;
    private var _addGizmo_directionCodec:ICodec;
    private var _addGizmo_timeoutCodec:ICodec;
    private var _addMarkerId:Long = Long.getLong(155643583,-870810465);
    private var _addMarker_sizeCodec:ICodec;
    private var _addMarker_colorCodec:ICodec;
    private var _addMarker_pointCodec:ICodec;
    private var _addMarker_timeoutCodec:ICodec;

    public function BattleDebugModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new BattleDebugModelServer(IModel(this));
      this._addFrame_sizeCodec = this._protocol.getCodec(new TypeCodecInfo(Float,false));
      this._addFrame_colorCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._addFrame_debugFrameCodec = this._protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(Vector3d,false),false,1));
      this._addFrame_timeoutCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._addGizmo_sizeCodec = this._protocol.getCodec(new TypeCodecInfo(Float,false));
      this._addGizmo_colorCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._addGizmo_pointCodec = this._protocol.getCodec(new TypeCodecInfo(Vector3d,false));
      this._addGizmo_directionCodec = this._protocol.getCodec(new TypeCodecInfo(Vector3d,false));
      this._addGizmo_timeoutCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._addMarker_sizeCodec = this._protocol.getCodec(new TypeCodecInfo(Float,false));
      this._addMarker_colorCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._addMarker_pointCodec = this._protocol.getCodec(new TypeCodecInfo(Vector3d,false));
      this._addMarker_timeoutCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._addFrameId:
          this.client.addFrame(Number(this._addFrame_sizeCodec.decode(param2)),int(this._addFrame_colorCodec.decode(param2)),this._addFrame_debugFrameCodec.decode(param2) as Vector.<Vector3d>,int(this._addFrame_timeoutCodec.decode(param2)));
          break;
        case this._addGizmoId:
          this.client.addGizmo(Number(this._addGizmo_sizeCodec.decode(param2)),int(this._addGizmo_colorCodec.decode(param2)),Vector3d(this._addGizmo_pointCodec.decode(param2)),Vector3d(this._addGizmo_directionCodec.decode(param2)),int(this._addGizmo_timeoutCodec.decode(param2)));
          break;
        case this._addMarkerId:
          this.client.addMarker(Number(this._addMarker_sizeCodec.decode(param2)),int(this._addMarker_colorCodec.decode(param2)),Vector3d(this._addMarker_pointCodec.decode(param2)),int(this._addMarker_timeoutCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
