package projects.tanks.client.partners.impl.vkontakte {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class VkontakteInternalLoginModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:VkontakteInternalLoginModelServer;

    private var client:IVkontakteInternalLoginModelBase = IVkontakteInternalLoginModelBase(this);
    private var modelId:Long = Long.getLong(1975556474,1605360392);

    public function VkontakteInternalLoginModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new VkontakteInternalLoginModelServer(IModel(this));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      var local3:* = param1;
      switch(false ? 0 : 0) {
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
