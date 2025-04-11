package projects.tanks.client.clans.space.createclan {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class ClanCreateModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:ClanCreateModelServer;

    private var client:IClanCreateModelBase = IClanCreateModelBase(this);
    private var modelId:Long = Long.getLong(1406824912,-478599334);
    private var _alreadyInClanId:Long = Long.getLong(224690586,33129736);
    private var _correctNameId:Long = Long.getLong(661618191,747527866);
    private var _correctTagId:Long = Long.getLong(255752141,-162666891);
    private var _nameIsIncorrectId:Long = Long.getLong(1686179352,1619108917);
    private var _notUniqueNameId:Long = Long.getLong(2117528051,-1228799124);
    private var _notUniqueTagId:Long = Long.getLong(899591349,1207281551);
    private var _otherErrorId:Long = Long.getLong(255677344,1199269997);
    private var _tagIsIncorrectId:Long = Long.getLong(180626480,535638748);

    public function ClanCreateModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new ClanCreateModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(ClanCreateCC,false)));
    }

    protected function getInitParam() : ClanCreateCC {
      return ClanCreateCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._alreadyInClanId:
          this.client.alreadyInClan();
          break;
        case this._correctNameId:
          this.client.correctName();
          break;
        case this._correctTagId:
          this.client.correctTag();
          break;
        case this._nameIsIncorrectId:
          this.client.nameIsIncorrect();
          break;
        case this._notUniqueNameId:
          this.client.notUniqueName();
          break;
        case this._notUniqueTagId:
          this.client.notUniqueTag();
          break;
        case this._otherErrorId:
          this.client.otherError();
          break;
        case this._tagIsIncorrectId:
          this.client.tagIsIncorrect();
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
