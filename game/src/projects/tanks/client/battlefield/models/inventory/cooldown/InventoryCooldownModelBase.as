package projects.tanks.client.battlefield.models.inventory.cooldown {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class InventoryCooldownModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:InventoryCooldownModelServer;

    private var client:IInventoryCooldownModelBase = IInventoryCooldownModelBase(this);
    private var modelId:Long = Long.getLong(169566618,2066569805);
    private var _activateCooldownId:Long = Long.getLong(450867590,-1737387168);
    private var _activateCooldown_durationCodec:ICodec;
    private var _activateDependentCooldownId:Long = Long.getLong(948633528,642461173);
    private var _activateDependentCooldown_dependedItemsCodec:ICodec;
    private var _readyId:Long = Long.getLong(1014436087,90975169);
    private var _setCooldownDurationId:Long = Long.getLong(1069928691,-717266881);
    private var _setCooldownDuration_durationCodec:ICodec;

    public function InventoryCooldownModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new InventoryCooldownModelServer(IModel(this));
      this._activateCooldown_durationCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._activateDependentCooldown_dependedItemsCodec = this._protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(DependedCooldownItem,false),false,1));
      this._setCooldownDuration_durationCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._activateCooldownId:
          this.client.activateCooldown(int(this._activateCooldown_durationCodec.decode(param2)));
          break;
        case this._activateDependentCooldownId:
          this.client.activateDependentCooldown(this._activateDependentCooldown_dependedItemsCodec.decode(param2) as Vector.<DependedCooldownItem>);
          break;
        case this._readyId:
          this.client.ready();
          break;
        case this._setCooldownDurationId:
          this.client.setCooldownDuration(int(this._setCooldownDuration_durationCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
