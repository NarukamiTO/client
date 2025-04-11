package projects.tanks.client.battlefield.models.battle.battlefield.mine {
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
  import platform.client.fp10.core.registry.ModelRegistry;

  public class BattleMinesModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:BattleMinesModelServer;

    private var client:IBattleMinesModelBase = IBattleMinesModelBase(this);
    private var modelId:Long = Long.getLong(479007306,2075268288);
    private var _activateMineId:Long = Long.getLong(1090794095,949129477);
    private var _activateMine_mineIdCodec:ICodec;
    private var _explodeMineId:Long = Long.getLong(1558315722,-513756959);
    private var _explodeMine_mineIdCodec:ICodec;
    private var _explodeMine_targetIdCodec:ICodec;
    private var _explodeMine_dummyCodec:ICodec;
    private var _putMineId:Long = Long.getLong(1130188491,-1001840691);
    private var _putMine_mineIdCodec:ICodec;
    private var _putMine_xCodec:ICodec;
    private var _putMine_yCodec:ICodec;
    private var _putMine_zCodec:ICodec;
    private var _putMine_userIdCodec:ICodec;
    private var _removeAllMinesId:Long = Long.getLong(2091233297,-183088088);
    private var _removeAllMines_ownerIdCodec:ICodec;
    private var _removeMinesId:Long = Long.getLong(1555952411,-2052736679);
    private var _removeMines_ownerIdCodec:ICodec;
    private var _removeMines_mineIdsCodec:ICodec;

    public function BattleMinesModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new BattleMinesModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(BattleMineCC,false)));
      this._activateMine_mineIdCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
      this._explodeMine_mineIdCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
      this._explodeMine_targetIdCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
      this._explodeMine_dummyCodec = this._protocol.getCodec(new TypeCodecInfo(Boolean,false));
      this._putMine_mineIdCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
      this._putMine_xCodec = this._protocol.getCodec(new TypeCodecInfo(Float,false));
      this._putMine_yCodec = this._protocol.getCodec(new TypeCodecInfo(Float,false));
      this._putMine_zCodec = this._protocol.getCodec(new TypeCodecInfo(Float,false));
      this._putMine_userIdCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
      this._removeAllMines_ownerIdCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
      this._removeMines_ownerIdCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
      this._removeMines_mineIdsCodec = this._protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(Long,false),false,1));
    }

    protected function getInitParam() : BattleMineCC {
      return BattleMineCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._activateMineId:
          this.client.activateMine(Long(this._activateMine_mineIdCodec.decode(param2)));
          break;
        case this._explodeMineId:
          this.client.explodeMine(Long(this._explodeMine_mineIdCodec.decode(param2)),Long(this._explodeMine_targetIdCodec.decode(param2)),Boolean(this._explodeMine_dummyCodec.decode(param2)));
          break;
        case this._putMineId:
          this.client.putMine(Long(this._putMine_mineIdCodec.decode(param2)),Number(this._putMine_xCodec.decode(param2)),Number(this._putMine_yCodec.decode(param2)),Number(this._putMine_zCodec.decode(param2)),Long(this._putMine_userIdCodec.decode(param2)));
          break;
        case this._removeAllMinesId:
          this.client.removeAllMines(Long(this._removeAllMines_ownerIdCodec.decode(param2)));
          break;
        case this._removeMinesId:
          this.client.removeMines(Long(this._removeMines_ownerIdCodec.decode(param2)),this._removeMines_mineIdsCodec.decode(param2) as Vector.<Long>);
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
